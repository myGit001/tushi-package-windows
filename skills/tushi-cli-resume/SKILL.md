---
name: tushi-cli-resume
description: >-
  用途视CLI接手他人做了一半的短剧/短视频项目。新会话开场先调本 skill：用 CLI 盘点真实项目状态（哪个项目/几集/角色分镜产物到哪一步），
  快速定位「差哪一步」，从断点续做。用户说「接着做」「继续上回的」「这个项目做到哪了」「帮我续拍」时用。
---

# 途视CLI 中途接手

上一个 AI（或上一个会话）做过的事，**不需要靠记忆**——途视把全部分镜/角色/产物**持久化在项目里**，`途视CLI.exe` 能实时读出。本 skill 教你**用 CLI 盘点现状，从断点继续**，而不是猜进度。

命令名以 `help` 为准，参数以 `schema` 为准（JSON 对象，Windows 终端用单引号包住）。不要用 `--arg`，没有 `run gen` / `role gensound` / `project dump`。**不要联网搜索**（本地私有工具，网上查不到，所有信息只能来自 CLI 返回）；`role list` 只返回 roleSn+name，**没有 type / 产物路径，不要编造**，详情用 `role get`。

## 接手四步（必做，别跳）

### 1. 启动途视 + CLI（同创作 skill）

- 运行 `途视包-Windows/运行途视.bat`，等 `system status` 连上且 `loggedIn=true`（未登录先 `login`）
- CLI 绝对路径：`途视包-Windows/ExePack/途视CLI.exe`（找不到问用户）

### 2. 盘点「有什么项目」

```
<CLI> project list
```

### 2b. 看项目交接文档

```
<CLI> schema project handoff get
<CLI> project handoff get '{"projectName":"<list 里的真名>"}'
```

- 返回 `content` 即全文；空 = 还没写过
- 续做完一段：`schema project handoff set` 再写回

### 3. 盘点「项目做到哪一步」

```
<CLI> schema project progress
<CLI> project progress '{"projectName":"<真名>"}'
<CLI> schema shot list
<CLI> shot list '{"projectName":"<真名>"}'
<CLI> schema role list
<CLI> role list '{"projectName":"<真名>"}'
```

产物是否已有：对具体分镜/角色用 `shot get` / `role get`（list 只有 Sn/原文/名字，没有图视频路径；list 按章节 key 分组返回，**key 分镜和角色共用同一套**）。**`shot get` / `role get` 每次最多 3 条**（返回带产物路径，一次太多回复又长又慢）。字段名以 schema / 返回 JSON 为准。`run preview` 的 `ok=true` 仍要看 `data.precheckIssues`。

### 4. 从断点续做（复用创作 skill）

| 缺什么 | 续做什么 |
|---|---|
| 没建项目 | 创作 skill：空项目 → `workflow temp set` → `role creates` → `shot creates` |
| 角色/场景没图 | `run preview` → `role gen`（白底 vs 场景工作流不要混；`workflowSn` 来自 `template get` / `workflow list`）。同一角色换形态（变装/变龄/变身）必须用图生图：先 `role res` 把原图设为 refpic，再用图生图工作流 gen |
| 分镜没图 | 确认角色已绑且已有图 → `run preview` → 风格/分辨率不对用 `workflow customize set` / `workflow param set` 改 → `shot gen`（融合工作流）。`镜头其它1(空)` 可忽略 |
| 分镜没视频 | `shot set` 的 `time`=时长； `run preview` → `shot gen`（视频工作流） |
| 分镜没配音 | 仅视频不自带声（`shot get` 的 `curVideoHaveAudio=false`）：**配音就在该角色身上，不是独立角色**——同一角色既出画面图也出声音，没有单独的「配音」角色（筛选面板的「配音」只是该角色有配音的筛选项）。**先设计后绑定，声音按角色维度复用**：`role list` 扫现成角色，同一角色/同一声线跨集直接复用其 Sn（解说类可全片一个，对话剧每角色各一个）；该角色还没建（如解说旁白无画面角色）才 `role creates` 建角色 → 声音设计类工作流 `role gen` 设计声音（产物存在该角色 `audio` 字段，跨集复用该角色即复用声音）→ 绑到分镜：`shot setaudiorole`（参数 `soundRoleSn`，先 `schema`，同角色每镜绑同一 Sn；`shot setsound` 是绑独立音色，一般不用）→ `shot gen` 文本克隆工作流出台词配音 |
| 都齐了没导出 | 先 `run qa` 确认无 issue → 剪映 `export draft`；mp4 `export video`。**字幕：导出剪映会自动补提取（whisper）并写入字幕轨道**，导出后**抽查**几镜 `shot subtitle get` 核对文本与时间码，个别错字用 `shot subtitle set` 改，不用逐镜手动校准 |

队列占用：等当前 job，或 `shot stop` / `role stop`。不要 `run stop`。

## 与创作 skill 的关系

- **接手**用本 skill；**从零做**用 `tushi-cli-creation`
- 拿不准：`help` → `schema <命令名>`
