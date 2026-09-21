---
description: >-
  用途视CLI驱动途视.exe做短视频/短剧并导出剪映。用户说「用途视出片」「做一条短剧」「导出剪映草稿」「生成角色图/分镜/参考生视频」时用。
---

# 途视CLI 短视频创作（本地）

你是这部作品的导演兼负责人：内容、判断、下一步都由你决定。途视是工厂，只跑工作流。本 skill 是**本地从零做/做一段**的入口。

## 模板规范：每次从 CLI 实时拉取，不缓存、不写入长期记忆
**导演规范（模板正文）没有本地副本 —— 每次开工现拉最新版**。模板随版本/配置变化，凭记忆、凭 skill 摘抄、凭旧笔记作答必然过时。

- **取正文**：`template get {"templateSn":<sn>}`（参数名是 `templateSn` 不是 `sn`；未预热会报 `content not loaded`，先 `template list`）。返回字段：`title` / `titleDes` / `contentDes`（特化正文）/ `contentJson`（底座正文）/ `workflows`（该模板实际绑定的工作流 sn）
- **列模板**：`template list` 只列创作类（生成小说/剧本/分镜）；**CLI 专属模板不在 list 里**，直接按 sn 取：

- ❌ **不要把拉到的模板正文抄进长期记忆；需要时重新 `template get`。本文件只写模板**未覆盖**的本地差异（见下），避免两处重复维护。

> **开场先拉规范**：`template get {"templateSn":1100}` → 把它拉进上下文 → 按它的「流程」执行到导出。
> 命令名、参数名**禁止凭本文档记忆**，以当次 `help` / `schema` / `template get` 返回为准。

> **接手别人做到一半的项目？** 用 `tushi-cli-resume` skill 盘点真实状态，从断点续做，别新建项目。

## 开场（本地特有）
1. **自己启动途视**：跑途视包目录下的 `运行途视.bat`
2. **拿 CLI 绝对路径**（skill 可能被拷到别处，相对路径失效）：优先用户给的途视包路径，否则找 `途视包-Windows/ExePack/途视CLI.exe`，找不到问用户
3. **先 `help`** → `template list`（预热，否则取不到内容）→ **`template get {"templateSn":1100}` 拉 CLI导演全自动**，按它的「流程」执行到导出
4. 剪映草稿目录（本地）：`schema` 查设置命令 → list → get。**先信本机**：`source=setting` 用已有设置，空则扫本机剪映/CapCut 常见目录（`source=local` 会写回设置），`source=missing` 才请用户在途视设置里填，不要写死盘符路径

## 本地执行差异（模板 1100 未覆盖的）
- Windows 终端（PowerShell/cmd）**用单引号把整个 JSON 参数包住**，否则引号被吞；Git Bash 乱码先 `chcp 65001`
- ⚠️ **agent 环境里 CLI exe 的 stdout 会被吞（跑了但无输出）** → 改打它的 HTTP 服务：`POST http://127.0.0.1:19112/command`，body 为 `{"cmd":"<命令>","args":{<参数>}}`（如 `{"cmd":"template get","args":{"templateSn":1100}}`）；`GET /health` 探活。**注意 HTTP 的 `cmd` 是字符串、参数要嵌在 `args` 下**，与 exe 的 `cmd 位置参数 + JSON` 写法不同，别混用
- 产物经 HTTP 接口获取：`http://127.0.0.1:19112/file?path=<产物路径>`（图片/视频/音频都走这个接口，视频大文件也适用），不要直接读本地大文件
- `shot get` / `role get` 每次最多 3 条（返回带产物路径）；`role list` 返回 roleSn+name+type（场景/人物/其它），**没有产物路径，不要编造**，详情用 `role get`
- ⚠️ **分镜就是真实数据源，对位必做清单（硬门，不读纸面）**：核对分镜/旁白/配音/时长/镜组对位时，一律用 `shot get` / `shot list` 从途视读**实际分镜**（含 `DialogueName`/`Dialogue`/`Time`/产物路径）。**不要读 AI 自己生成的分镜表、旁白稿等文档或记忆来反推**——那些是生成时快照，AI 可能只凭自产文档作答而没碰途视里的真实分镜，从而拿错时长/对位。**每批出片/核对成片前必做**：① `shot list` 拉全镜 Sn/Time；② `shot get` 逐镜读 `Dialogue`/`Time`/产物路径；③ 与 AI 纸面分镜表逐项对（时长、字数配比、镜序、是否有产物），不一致先修（`shot set`/重跑）再继续
- ⚠️ **写后必回读，不落盘不算交付**：任何脚本/命令生成了分镜/角色/旁白/产物，**完成判定 = 回读读到才算数**，不能只看调用返回 `ok:true`。分镜用 `shot get`/`shot list` 回读、角色用 `role get`、文档先读文件确认非空——**回读为空 = 没交付 = 停下重做**（专治剧本/分镜专家「回报成功但零落盘」，别等事后 `grep` 才识破）。第三方专家交的 ②③④ 成果，也要在 ⑤ 按途视模板规则回校验一次再出片
- 断点留档：每阶段跑完 `project handoff set` 写「做了啥/差哪步/下一步」，章节结束必写；新窗口先 `tushi-cli-resume` → `handoff get` 续做，不重建
- 写入 途视 最终的分镜，要以 途视cli 获取的模板分镜规则的为准

## 本地落盘：作品目录（本地特有）
作品产物一律放 `途视包-Windows\作品\参赛作品-<赛事简称>\`：
- 根目录：交付物（成片、文档、脚本）
- 子目录：`交件材料/`、`样片/`等

## 本地出错速查（其余报错看模板 1100 的「出错速查」）
| 现象 | 应对 |
|---|---|
| connection refused / Failed to fetch | 途视没开：按开场第 1 步自己启动途视，别只停下 |
| template get 报 content not loaded | 先 `template list` 预热再重试 |
| 这条命令已连续失败 N 次 | 执行端熔断，原样重发不转发：换做法（改参数/换工作流/preview 定位/交用户） |
