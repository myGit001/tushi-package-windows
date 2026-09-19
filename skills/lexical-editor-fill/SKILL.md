---
name: lexical-editor-fill
agent_created: true
description: >-
  Kimi 等 Lexical/contenteditable 网页编辑器「长文本填入失败、输入框为空、日志与实际不符、超长自动转 txt 附件」的诊断与修复。
  适用于 AI 聊天页/网页编辑器（Lexical、ProseMirror、Slate 等）回填命令、长 prompt、AI 回复时内容被清空/截断的场景。
  用户说「Kimi 输入框没内容」「填进去被清空了」「粘贴超长变 txt」「日志说填了实际是空的」时用。
---

# Lexical/contenteditable 编辑器长文本填充诊断

在 Kimi 等基于 Lexical 的 contenteditable 编辑器里，用 DOM 操作（innerHTML、合成键盘事件）填入长文本时会遇到一系列「表面成功、实际被清空」的坑。本 skill 记录 **2026-08-31 在真实 Kimi 会话页 5 轮 Playwright 实测锁定的根因与可靠修复路径**。

## 核心根因（按破坏力排序）

1. **空编辑器上 clearEditor = Lexical 坏状态（头号杀手）**
   - 在**空**编辑器上合成 Ctrl+A/Backspace（clearEditor 的常见实现）会让 Lexical 进入坏状态
   - 之后填的长文本会被**异步重渲染清空**（实测 2439/5125/7857 字全部 len=1）
   - **只有编辑器有残留内容时才清空是可靠的**；空编辑器直接跳过清空
2. **Kimi 4000 字符阈值**
   - 单次 `input` 事件 `data` >4000 字符时，Kimi 判定为「粘贴超长」，**自动转成 txt 附件**，输入框文字清空
   - 必须**分块填充**：每块 ≤1500 字符，块间累积 innerHTML，每块独立派发 `InputEvent('input')`
3. **同步验证被骗（先真后空）**
   - Lexical 在 `input` 事件后**异步重渲染**，填完立即读 innerText 会看到内容，350ms 后再读可能已空
   - 验证必须等 350ms 后再做；长文本比对**头尾各 100 字**即可（不要全量比对）
4. **单行 `<input>` 粘贴多行丢换行（命令类场景）**
   - `<input type="text">` 粘贴多行内容，浏览器行为吃掉换行 → 多行命令糊成一行 → 后续按行解析只抽出 1 条 → `unknown cmd`
   - 手动命令框必须用 `<textarea>` 保留换行

## 可靠填充模式（生产验证通过）

```js
// ① 只在有残留内容时才清空（空编辑器跳过！）
if (!this.isEditorEmpty()) { this.clearEditor(); }

// ② 分块填充：CH=1500，累积 innerHTML + 每块独立 input 事件
const CH = 1500;
let html = '';
for (let i = 0; i < text.length; i += CH) {
  const part = text.slice(i, i + CH);
  html += escapeHtml(part);            // 换行→<br>、特殊字符转义
  editor.innerHTML = html;
  editor.dispatchEvent(new InputEvent('input', {
    bubbles: true, inputType: 'insertText', data: part,
  }));
}

// ③ 等 Lexical 异步重渲染安定后验证头尾
await sleep(350);
if (containsHeadTail(editor, text)) return true;

// ④ 兜底：clipboard 粘贴（需要 user activation，自动转发场景可能失败）
await navigator.clipboard.writeText(text);
editor.focus();
editor.dispatchEvent(new KeyboardEvent('keydown', { key: 'v', ctrlKey: true, bubbles: true }));
// 或合成 ClipboardEvent('paste')
return verifyAgain(editor, text);
```

## 诊断工作流（真实页面实测，别在本地 mock 里猜）

用 Playwright + `.pw-profile` 持久化登录态在**生产页面**逐方法 A/B 对比（详见 `playwright-install` skill 的启动方式）：

1. 启动：`chromium.launchPersistentContext(scripts/browser/.pw-profile, { executablePath: 系统Chrome, headless:false, ignoreDefaultArgs:['--enable-automation'], args:['--disable-blink-features=AutomationControlled'] })`
2. 打开真实 Kimi 会话页（`www.kimi.com/chat/<id>`，走历史会话避免新建会话）
3. 用 `page.evaluate` 注入候选填充方法，**每轮只隔离一个变量**（本轮教训：`diag-fill-live4.js` 把 Node 作用域的转义函数传进 evaluate 直接 ReferenceError——辅助函数必须内联进 evaluate）
4. 每方法测完**清空编辑器时注意**：直接 innerHTML='' 会触发 Lexical 恢复旧内容（坏路径 H2），换「有残留→清空→填」的正常路径验证
5. 收集结果：`len / 头含 / 尾含 / 发送按钮 disabled / 页面 console.warn 数`
6. 截图存档每轮关键状态（`diag-*.png`），方便回溯

参考脚本（`scripts/browser/kimi/`）：
- `diag-fill-live.js` ~ `diag-fill-live6.js`：6 轮隔离变量实测（T1-T6 / M-A~E / A-E / H1-H5）
- `diag-fill-final.js`：端到端最终验证模板（5125/7857/12984 字 + 预填旧文本 4 场景 + console.warn 计数），**新场景直接改这个**

## 已验证结论速查

| 操作 | 结果 |
|---|---|
| 空编辑器 + clearEditor + 长文本 | ❌ len=1（Lexical 坏状态） |
| 有残留 + clearEditor + 长文本 | ✅ |
| 单次 input data>4000 | ❌ 转 txt 附件 |
| CH=1500 分块 + 每块 input | ✅ 7857/12984 字完整 |
| 填完立即验证 | 假阳性（异步重渲染） |
| 等 350ms 再验证头尾 | ✅ |
| clipboard 兜底（有 user activation） | ✅ |
| `<input>` 粘贴多行命令 | ❌ 换行丢失 → 1 条坏命令 |
| `<textarea>` 粘贴多行命令 | ✅ 逐条抽取 |

## 相关文件

- `scripts/Retweet/adapter-kimi.js`：`setEditorText`（生产修复落点）、`_editorContainsText`、`_pasteFromClipboard`
- `scripts/Retweet/content.js`：手动命令框 `<textarea rows="2">`、`hasCliLine` 补前缀判断、Enter/Shift+Enter
- `scripts/browser/kimi/long-payload-*.txt`：长文本测试 payload
