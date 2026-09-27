---
name: playwright-install
description: >-
  在**当前工作区**安装并配置 Playwright（Python 或 Node 版本），用于自动化控制 Chrome/Edge 浏览器。
  覆盖 npm 安装、系统 Chrome 直连、持久化登录 profile（登录态可复用）、登录态检测、常驻控制器、站点子目录组织。
  用户说「装 Playwright」「自动化控制浏览器」「打开某某网站登录后操作」「检测是否登录」时用。
---

# Playwright 安装与浏览器自动化

用 Playwright 驱动真实浏览器（Chrome/Edge）做自动化：打开页面、登录、点击、填表、截图、长驻轮询。本 skill 覆盖**安装 → 目录组织 → 启动浏览器 → 登录检测/复用 → 操作**全流程。

## 目录组织（当前工作区约定）

所有东西都装在**当前工作区**里，不要装到别的项目或全局目录：

```
scripts/browser/                  # Node 版根目录（含 package.json）
├── package.json                  # 依赖 playwright
├── .pw-profile/                  # 登录 profile（放这里，脚本统一引用）
├── open.js                       # 通用：系统 Chrome 直连 + 持久化 profile 打开 URL
├── <站点>/                       # 站点脚本（当前工作区已有 kimi/）
│   ├── open-<站点>.js            # 打开站点
│   ├── verify-login.js           # 检测登录态
│   ├── <站点>-controller.js      # 常驻控制器（轮询命令文件）
│   └── ...
└── <站点>-results/               # 控制器结果输出目录
```

- 站点脚本放 `scripts/browser/<站点>/`，**不要**放根目录或别处
- 登录 profile `.pw-profile` 放 `scripts/browser/`，站点脚本引用时用 `path.join(__dirname, '..', '.pw-profile')`

## 选语言版本

| 场景 | 推荐 |
|---|---|
| 快速开浏览器、脚本一次性 | **Python**（`pip install playwright`） |
| 与现有 npm 依赖共存、长驻控制器 | **Node**（`npm i playwright`，需 package.json） |

两者 API 一致。下面以 Node 为主。

## 安装步骤

### Node 版

```bash
cd 当前工作区/scripts/browser
# 建 package.json 声明依赖，然后：
npm install playwright
```

- `npm install` 只装库，**不**下载浏览器内核。系统 Chrome 直连模式（推荐）**不需要** `playwright install chromium`

### Python 版

```bash
python -m pip install playwright
python -m playwright install chromium   # 下载 Chromium 内核（仅自用内核时需要）
```

## 系统 Chrome 直连 + 持久化登录（推荐）

用 `launchPersistentContext` + `executablePath` 指向已装的系统 Chrome。**登录态持久化**在 user-data-dir，下次复用不用重新登录。**免下载内核**。

```js
const { chromium } = require('playwright');
const path = require('path');

const USER_DATA = path.join(__dirname, '..', '.pw-profile');  // scripts/browser/.pw-profile
const CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe';

(async () => {
  const browser = await chromium.launchPersistentContext(USER_DATA, {
    executablePath: CHROME,
    headless: false,                  // false=有头（可见窗口，便于人工登录）；true=无头
    viewport: { width: 1440, height: 900 },
    // 贴近正常浏览器，不注入自动化痕迹，避免被站点识别拦截
    ignoreDefaultArgs: ['--enable-automation'],
    args: [
      '--disable-blink-features=AutomationControlled',
      '--start-maximized',
      '--no-first-run',
      '--no-default-browser-check',
    ],
  });

  const page = browser.pages()[0] || (await browser.newPage());
  await page.goto('https://目标网站/', { waitUntil: 'domcontentloaded', timeout: 60000 });
  console.log('OPENED: ' + page.url());
  // ...操作...

  await browser.close();
})().catch((e) => { console.error('ERR:', e && e.message); process.exit(1); });
```

要点：
- **有头 + 人工登录**：窗口保持，人工完成登录（短信/扫码/验证码），登录态写进 `.pw-profile`
- **再次运行**：同一 `USER_DATA` 自动带登录态，无需重复登录
- `executablePath` 是系统 Chrome 路径：`C:/Program Files/Google/Chrome/Application/chrome.exe`（Edge 同理替换 msedge.exe）

## 登录态检测（复用已有登录）

打开站点后**先检测是否已登录**，未登录再提示人工登录，不要盲目走登录流程：

```js
await page.goto('https://站点/', { waitUntil: 'domcontentloaded', timeout: 60000 });
await page.waitForTimeout(6000);   // 等页面 JS 渲染
const body = await page.locator('body').innerText();
const loggedIn = body.includes('登录后特有的特征文本');
console.log('登录态有效:', loggedIn);
```

- 特征文本选**登录后必然出现**的：如 Kimi 的「新建会话」、用户中心、头像菜单等
- 未登录时输出 body 前几百字辅助判断当前处于什么状态（登录页？验证码？）

## 常驻控制器（长驻轮询命令文件）

浏览器常开，轮询命令文件持续对话，结果写结果目录：

```js
const fs = require('fs');
const CMDS = path.join(__dirname, '<站点>-commands.jsonl');   // 命令队列（追加 JSON 行）
const RES_DIR = path.join(__dirname, '<站点>-results');        // 结果目录（每命令一个 json）

// 读已完成结果 id 作为游标
let cursor = fs.readdirSync(RES_DIR).filter(f => f.endsWith('.json'))
  .map(f => Number(f.slice(0, -5))).sort((a, b) => a - b).pop() || 0;

while (true) {
  // 读命令文件找 id > cursor 的下一条，执行，写结果，cursor 前进
  await new Promise(r => setTimeout(r, 1500));   // 轮询间隔
}
```

- 命令文件按 id 递增追加 JSON 行；结果文件 `kimi-results/<id>.json`
- 常见动作：`goto`（打开+读 body）、`chat`（填输入框发送+等回复稳定）、`read`（读 body）、`shot`（截图）

## 加载浏览器扩展

给自动化浏览器加载"已解压的扩展"（MV3），复用其后台特权调用（跨域 API、cookies）：

```js
const EXT_DIR = path.resolve(__dirname, 'browser-extension');   // manifest.json 所在目录
const browser = await chromium.launchPersistentContext(USER_DATA, {
  executablePath: CHROME,
  headless: false,                       // 扩展不会在无头模式加载
  ignoreDefaultArgs: ['--enable-automation'],
  args: [
    '--disable-blink-features=AutomationControlled',
    '--disable-extensions-except=' + EXT_DIR,
    '--load-extension=' + EXT_DIR,
    '--no-first-run',
  ],
});
```

## 常用操作速查

```js
await page.goto(url);                     // 打开
await page.waitForSelector('#login');     // 等元素
await page.fill('#phone', '13800000000'); // 填输入框
await page.click('button:has-text("登录")'); // 点击
await page.locator('div.result').textContent(); // 读文本
await page.screenshot({ path: 'shot.png' }); // 截图
await page.title();                       // 页面标题
```

## 常见问题

- **`require('playwright')` 找不到** → 没进到有 package.json 的目录，cd 到 `scripts/browser` 再装
- **`Target page, context or browser has been closed` / 「在该浏览器会话中打开」** → profile 被残留的 Chrome 进程占用。之前的有头进程没退出，**先停掉占用该 profile 的 Chrome 进程再跑**（`tasklist` 查命令行含 profile 路径的 chrome.exe，`taskkill /F`）
- **浏览器打开的是 `chrome://intro`（首次运行欢迎页）** → 页面内 `location.assign()` 跳不走，用 `page.goto()`（Playwright 层导航）
- **站点头像/滑块验证** → 保持有头 + 不注入自动化痕迹（上述 args），必要时人工过验证
- **登录检测要等渲染** → `goto` 后 `waitForTimeout` 几秒再读 body，特征文本在 JS 渲染后才出现
