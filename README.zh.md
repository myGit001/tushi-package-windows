<div align="center">

# 🎬 途视 · Tushi

**Windows 上的 AI 批量视频生成工具** — 把小说、剧本、纯文本，批量做成短剧、漫剧、AI 视频。

[English](README.md) · 简体中文

![Windows](https://img.shields.io/badge/平台-Windows-0078D6) ![流水线](https://img.shields.io/badge/流水线-AI%20视频-informational) ![授权](https://img.shields.io/badge/授权-专有-lightgrey)

*一条工作流，批量打几十上百个分镜。工作流你来定，批量跑交给途视。*

[**⬇ 下载**](#环境准备) · [**🚀 快速上手**](#快速上手) · [**📖 文档**](#目录) · [**📺 B站教程**](https://space.bilibili.com/199774118)

</div>

<div align="center">

<video src="https://github.com/user-attachments/assets/cb7f3ee0-993f-4b0f-9994-00e3dd84a072" controls width="100%"></video>
[<img src="https://gitee.com/zttbb/tushi-package-windows/raw/master/ExePack/tushi-promo-loop.gif" width="820">](https://cdn.jsdelivr.net/gh/myGit001/tushi-package-windows@main/ExePack/tushi-promo.mp4)

</div>

---

## 目录

- [快速上手](#快速上手)
- [环境准备](#环境准备)
- [安装与启动](#安装与启动)
- [正推流程](#正推流程)
- [反推流程](#反推流程)
- [工作流配置](#工作流配置)
- [AI 推理与配音](#ai-推理与配音)
- [项目界面](#项目界面)
- [导出](#导出)
- [命令行 CLI](#命令行-cli)
- [AI Agent Skills](#ai-agent-skills)
- [常见问题](#常见问题)
- [相关资源](#相关资源)

---

> **途视** 是一款 **AI 工作流批量执行工具**。它把项目里的素材（文本、图片、视频、音频、角色、3D 模型）整理成统一数据，**批量调度**本地 ComfyUI、RunningHub 等平台的任意工作流去执行，再把结果自动回收整理回项目。只要是 ComfyUI 兼容的工作流，就能在途视里按项目批量跑、成批出。

## ✨ 为什么选途视

| | | |
|---|---|---|
| 🚂 **批量跑工作流** | 🔗 **全流水线** | 🧩 **工作流你自定义** |
| 一条工作流一次性作用到几十上百个分镜。粘贴 → 自动分镜 → 批量生图生视频 → 一键导出。 | 文本 → 提示词 → 生图 → 生视频 → 配音 → 后期，各环节都是工作流，串起来一键跑完。 | 工作流 100% 由你定（只要 ComfyUI 兼容），途视只负责调度、传参、回收结果。 |
| 🌐 **四种执行通道** | ⏩ **正推 & 反推** | 🎬 **剪映草稿导出** |
| 本地 ComfyUI / RunningHub / RunningHub 模型 API / 贞贞 AI，自由切换。 | 正推：文本进、视频出。反推：导入视频 → 自动切场景 → 反推提示词。 | 生成带字幕、动画、转场、特效的剪映工程，无缝衔接后期。 |
| 📦 **本地视频工具箱** | 🧠 **AI 推理** | 🔌 **CLI / AI Agent 接入** |
| 调速、倒放、裁剪、拼接、抽帧、字幕、背景乐、水印。 | LLM 改写、提示词、角色、分镜生成。 | 脚本与 AI Agent 通过内置 CLI 驱动整个创作全流程。 |

## 快速上手

1. 从[迅雷网盘](https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen)或[夸克网盘](https://pan.quark.cn/s/eb8e9af1a277?pwd=susf)下载整合包，解压后双击**运行途视.bat**。
2. 选一个**执行后端** —— 本地 ComfyUI / RunningHub / RunningHub 模型 API / 贞贞 AI（也有[带免费额度的云端平台](#环境准备)）。
3. 进入**设置**：配置**项目资源保存路径**、可选的**剪映草稿路径**，以及**推理 / 配音工作流**。
4. 新建**项目** → 粘贴文本（正推）或导入视频（反推）→ 开始生成。

## 环境准备

| 后端 | 说明 | 需要准备 |
|------|------|---------|
| **本地 ComfyUI** | 自建本地/服务器 ComfyUI | 跑通工作流并导出 **API 格式** |
| **RunningHub** | 云端工作流 / AI 应用市场 | 注册 RunningHub，配置 API Key |
| **RunningHub 模型 API** | 企业级模型接口 | 配置模型 API Key |
| **贞贞 AI** | 大模型聚合平台（T8） | 配置贞贞 AI Key |

**不想本地装 ComfyUI？用云端**（新用户有免费额度）：

| 平台 | 福利 | 注册链接 |
|------|------|---------|
| **仙宫云** | 新用户免费 4 小时 RTX 4090 | [立即注册](https://www.xiangongyun.com/register/83FV6Z) |
| **优云智算** | 新用户送 10 元 | [立即注册](https://passport.compshare.cn/register?referral_code=6ciWIQ1SWkeBvh6brdIqbu) |
| **RunningHub** | 送 1000 积分，每日登录再送 100 | [立即注册](https://www.runninghub.cn/user-center/1897913667256500225/userPost?inviteCode=rh-v1476) |

**推荐的两件小东西**

- **ComfyUI 配套插件**：[ComfyUI-Common-Extension](https://gitee.com/zttbb/ComfyUI-Common-Extension) · [comfy-portal-endpoint](https://github.com/ShunL12324/comfy-portal-endpoint) —— 源工作流、LoRA 预览图等。
- **浏览器扩展**：*Downloads Overwrite Already Existing Files* —— 保存 API 工作流时直接覆盖原文件，不再生成 `xxx (1)`。

## 安装与启动

```
├── 更新并启动途视.bat         # 更新 + 启动（需联网）
└── 途视包-Windows/
    ├── 途视/                  # 主程序（途视.exe、运行时、途视_Data/、Bin/Res/）
    ├── ExePack/               # 辅助：途视CLI.exe + FFmpeg（ffmpeg/ffprobe）
    ├── 外部工作流（API）/      # 本地 ComfyUI 的 API 工作流目录
    ├── skills/                # AI Agent 技能（tushi-cli-creation、tushi-cli-resume 等）
    ├── 运行途视.bat           # 一键启动
    ├── VC_redist.x64.exe      # Visual C++ 运行库（按提示安装）
    └── README.md / README.zh.md
```

启动方式：双击 **更新并启动途视.bat**（推荐，自动从 Gitee 同步最新版）、**运行途视.bat**。

> `途视/GameData/` 是用户数据目录（本地缓存图片/视频），首次运行后自动生成，更新时不会被覆盖。

## 正推流程

**半自动（精细控制）**：粘贴文本 → 分章 → 剧本 → 分镜 → 角色 → 批量文生图（场景&角色）→ 配音 → 生视频 → 放大 → 导出

**全自动（一键生成）**：粘贴文本 → 自动分镜 → 选模板 → 调提示词 → 开始运行 → 导出

| 功能 | 说明 |
|------|------|
| 自动分章 | 按"第X章"正则把文本拆成章节页签 |
| 生成小说/剧本 | LLM 对原文改写润色，或生成剧本格式 |
| 生成分镜 | LLM 返回 JSON 分镜表（场景/角色/对话/画面与视频提示词/时长）并自动建分镜 |
| 角色编辑 | 统一管理角色参数（提示词、LoRA、配图、模型3D），自动建库并挂到分镜 |
| 批量文生图 | 一键支持：跳过已完成 / 全部 / 奇数 / 偶数 / 仅首个镜头 |
| 多图/多视频 | 一个分镜可挂多张配图、多个视频，可一键拆分为独立分镜 |
| 配音 | 通过 TTS 工作流生成（可选），可视频时长对齐音频 |
| 生视频 | 文生视频、图生视频、视频生视频、首尾帧生视频 |
| 对口型/放大 | 通过对应工作流（如 kling-lip-sync 对口型工作流） |

## 反推流程

```
导入视频 → 调整分割阈值 → 自动场景分割 → 抽关键帧 → OCR 识别字幕（可选）
→ 参考图生图 / 提示词反推 → 对接正推流程
```

- **场景分割**：基于 FFmpeg 场景检测自动切分（可调阈值、最短/最长片段时长），也可整段使用
- **抽关键帧**：按时间间隔截取视频帧作参考图
- **字幕识别**：本地 OCR（PPOCRv5）识别视频/图片文字，作为原文进入正推流程

反推与正推同属一个框架、无缝对接，各环节提示词与工作流均可自行调整。

## 工作流配置

### 工作流分类 → 功能按钮

`外部工作流（API）/` 下每个子目录对应一个功能按钮：

| 分类 | 工作流 |
|------|--------|
| **推理** | 推理角色 · 生成小说 · 生成剧本 · 生成分镜 · 原文 · 原文改 · 提示词 · 提示词2 |
| **生图** | 文生图 · 图生图 |
| **视频** | 文生视频 · 图生视频 · 参考生视频 · 视频生视频 |
| **音频** | 音频（TTS） |
| **模型3D** | 模型3D |

### 绑定规则

工作流通过**节点标题**自动识别输入输出：

- **输入节点标题**格式：`输入-数据来源-数据类型`（如 `输入-当前镜头-提示词`），支持原文、提示词、参考图、参考视频、音频、角色、模型3D 等 30+ 种输入类型
- **输出节点标题**格式：`输出=类型`（文本、图片、视频、音频、模型3D 均可）
- **数据来源**：当前/上一/下一镜头、收藏角色、项目角色、自定义

### 配置方式

- **本地 ComfyUI**：浏览器跑通 → 导出 API 格式放进 `外部工作流（API）/<分类>` → 软件内绑定输入输出（蓝框=默认，黄框=已改）
- **RunningHub**：分配工作流（软件内可浏览/搜索模板与 AI 应用）→ 配置 API Key → 填充绑定输入
- **额外参数**：自定义参数（帧率、时长、文本、本地路径等）在设置里配置，分镜不填则走工作流默认

## AI 推理与配音

所有推理统一走 **工作流**（把工作流放进对应目录即可）：

| 类型 | 用途 |
|------|------|
| 原文改 | 润色、精简文本 |
| 提示词 / 提示词2 | 画面提示词 → 英文提示词 |
| 推理角色 | 自动建角色库 |
| 生成小说 / 生成剧本 | 章节文本 / 剧本格式 |
| 生成分镜 | 分镜表（场景/对话/提示词） |

**配音**：同样是工作流（音频分类）—— 文本 → TTS 节点 → 音频文件。每个分镜可指定**音频角色**（与画面角色分离）、全局音色、音量/语速，以及视频时长对齐音频。

## 项目界面

- **视图**：列表视图（平铺逐条操作）或面板视图（图文并排）
- **分镜状态**：红=未完成，绿=已完成；显示图片数/视频数/运行时长
- **分镜操作**：上移/下移、插入、删除、复制、**合并**（拼接视频/音频/文本）、**分割**（多图/多视频拆分子分镜）、交换
- **图片与视频**是两个独立管理区（增删、选中、复制参考；图片支持遮罩/简笔画/取景，视频支持裁剪/调速/倒放/抽帧/分辨率）
- **进阶**：分镜支持参考图/参考视频/模型3D；顶部一键"原文→提示词→提示词2"或批量清图/清视频/清配音/清参考（全局或单章）

## 导出

| 选项 | 说明 |
|------|------|
| **剪映草稿** | 图片/视频+字幕+动画+转场+位移动画+特效+配音（由剪映合成渲染） |
| **视频（mp4）** | FFmpeg 直接合成原视频+配音+背景乐，无特效 |
| **图片** | 导出分镜配图 |
| **CSV** | 导出原文改/提示词/翻译文本 |

草稿特效：镜头入场/出场/组合动画（随机/顺序/固定）、转场、位移动画、剪映内置特效、字幕轨（颜色/字号/位置）、片头/全片文字、片尾视频/音乐。导出设置：**单文件几镜头**（`9999`=整章合成一个视频，`1`=每镜一个视频）、章节合并、视频时长对齐音频、右侧实时估计导出数量/总时长。

## 字幕识别（Whisper）

分镜字幕识别基于本地 Whisper（`ExePack/Whisper/whisper_cli`，独立子仓库 [{name}]({url}) 分发）：

- 首次运行 `运行途视.bat` 自动同步 whisper_cli（约 670MB），之后每次启动增量更新
- 识别模型不进包，首次使用按所选模型从 ModelScope 动态下载
- 手动同步：运行 `更新Whisper.bat`

## 命令行 CLI

`ExePack/途视CLI.exe` 让脚本、批处理、AI Agent 直接驱动创作全流程——**导演在外面，工厂在途视里**。

```
命令行 / 脚本 / AI Agent ──▶ 途视主程序内置服务 127.0.0.1:19112 ──▶ 工作流执行 → 归档 → 导出
                                     （需保持 途视/途视.exe 运行）
```

- 只做转发，**前提是主程序在运行**（首次通常先 `login`）
- 默认端口 `19112`（换端口：`途视.exe --aicli-port <端口>`；鉴权：`--aicli-token xxx` + `--token xxx`）
- **所有输出都是一行 JSON**，看 `ok` 判断成败，退出码 0/1
- 长任务返回 `jobId`，加 `--wait` 轮询到结束

```bash
ExePack\途视CLI.exe <命令> [key=value ...] [JSON对象] [选项]
```

| 选项 | 说明 |
|------|------|
| `--json '{...}'` | 数组/嵌套结构参数走 JSON |
| `--arg key=value` | 追加单个参数（可重复） |
| `--wait` `--poll 2` `--timeout 600` | 轮询长任务（间隔/最长秒数） |
| `--port` / `--host` / `--url` / `--token` | 服务地址 / 鉴权 token |

命令名不区分大小写（`shot gen` = `shot.gen`）。**具体命令与参数由运行中的程序动态给出，动手前先自省**：

```bash
ExePack\途视CLI.exe help                        # 列出全部命令
ExePack\途视CLI.exe schema name="shot creates"  # 查某命令的参数
```

**能驱动什么**（功能概览，实际命令名/参数走 `help` / `schema`）：

| 板块 | 能做什么 |
|------|---------|
| 连接/自省 | 列命令、查参数、探活、登录、唤起主界面 |
| 设置 | 读写配置项（如剪映草稿路径） |
| 项目 | 项目增删改查、章节、交接信息、全局音色 |
| 模板/角色 | 读模板；建角色库、批量定妆出图 |
| 分镜 | 增删改查、批量跑生成、资源与接续管理 |
| 工作流 | 列出/导入、绑定输入输出、自定义参数、模板工作流 |
| 运行/导出/音频 | 提交并跟踪运行、导出前质检；剪映草稿/mp4；音色与分类 |

**注意**：先自省后动手 —— `shot creates` 的提示词字段是 `imagePrompt` / `videoPrompt`（字段名写错会返回成功但内容为空，用 `shot get` 回读抽查）。PowerShell 直调偶发吞输出，脚本里建议用 Python `subprocess` 按 UTF-8 读取。CLI 没有独立账号体系，用的是主程序当前的登录状态与项目文件。

## AI Agent Skills

途视随包自带一套 **AI Agent 技能**（`skills/`）：把 Claude Code、Trae、Cursor 等 AI 助手放到「导演」的位置，用 CLI 驱动途视，帮你在选题 → 剧本 → 分镜 → 出图 → 出视频 → 配音 → 导出剪映草稿的整条链路里代你干活。

| 技能 | 作用 |
|------|------|
| `tushi-cli-creation` | **本地从零出片/做一段**：AI 自己启动 `运行途视.bat`、建项目、拉导演模板，生成角色/分镜/画面/视频/配音，并导出剪映草稿。 |
| `tushi-cli-resume` | **中途接手**：AI 用 CLI 盘点真实项目状态，从断点续做，不靠记忆猜进度。 |

**怎么用**：把对应 skill 文件夹放进你的 AI 助手的 `skills` 目录，直接对它说「用途视出一段短剧」即可；AI 会自己启动 `运行途视.bat`，通过 `途视CLI.exe`（或 HTTP 服务 `127.0.0.1:19112`）驱动途视。配合上文「命令行 CLI」一节使用 —— 命令名与参数一律按运行中的程序动态获取（`help` / `schema` / `template get`）。

## 常见问题

<details>
<summary>必须使用本地 ComfyUI 吗？</summary>

不是。可以用仙宫云、优云智算、RunningHub 等云端服务，无需本地配置。
</details>

<details>
<summary>工作流怎么配置？</summary>

本地：在 ComfyUI 跑通 → 导出 API 格式放进对应目录（一个功能按钮对应一个文件夹）。云端：分配完工作流，在软件里查看并绑定输入参数。
</details>

<details>
<summary>红色标记是什么意思？</summary>

对应后端（ComfyUI / RunningHub）未连接，或连接后没找到对应工作流文件。
</details>

<details>
<summary>反推和正推能混用吗？</summary>

可以。两者同属一个框架，操作无缝对接。
</details>

<details>
<summary>CLI 没反应 / 连不上怎么办？</summary>

先确认主程序在运行 —— `途视CLI.exe system status` 能返回 JSON 即在线。改过端口就用 `途视.exe --aicli-port <端口>` 指定，命令侧 `--port <端口>` 跟上；端口占用者会写在启动日志里。
</details>

<details>
<summary>推理、翻译、配音用什么后端？</summary>

统一走 **工作流**，放进对应目录、软件内选择即可。翻译结果写入「提示词2」用于生成英文提示词。
</details>

## 相关资源

| 资源 | 链接 |
|------|------|
| **本仓库（Gitee）** | https://gitee.com/zttbb/tushi-package-windows |
| **ComfyUI 插件** | [ComfyUI-Common-Extension](https://gitee.com/zttbb/ComfyUI-Common-Extension) · [comfy-portal-endpoint](https://github.com/ShunL12324/comfy-portal-endpoint) |
| **B站教程** | https://space.bilibili.com/199774118 |
| **迅雷网盘（整合包）** | https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen |
| **夸克网盘** | https://pan.quark.cn/s/eb8e9af1a277?pwd=susf |

---

<div align="center">

⭐ **途视帮你做出好片子的话，给个 star，并关注 [@zzbbto](https://space.bilibili.com/199774118) 看教程。**

Made with ❤️ by [@zzbbto](https://space.bilibili.com/199774118)

</div>