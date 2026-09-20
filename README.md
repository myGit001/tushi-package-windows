<div align="center">

# 🎬 Tushi · 途视

**AI Batch Video Generation for Windows** — Turn novels, scripts, and plain text into short dramas, motion comics & AI videos — in batch.

[简体中文](README.zh.md) · English

![Windows](https://img.shields.io/badge/Platform-Windows-0078D6) ![Pipelines](https://img.shields.io/badge/Pipeline-AI%20Video-informational) ![License](https://img.shields.io/badge/License-Proprietary-lightgrey)

*One workflow, hundreds of shots. You decide the workflow — Tushi batches it.*

[**⬇ 下载 Download**](#requirements) · [**🚀 快速开始 Quick Start**](#quick-start) · [**📖 文档 Docs**](#table-of-contents) · [**📺 B站教程**](https://space.bilibili.com/199774118)

</div>

<div align="center">

<video src="https://github.com/user-attachments/assets/cb7f3ee0-993f-4b0f-9994-00e3dd84a072" controls width="100%"></video>
[<img src="https://gitee.com/zttbb/tushi-package-windows/raw/master/ExePack/tushi-promo-loop.gif" width="820">](https://cdn.jsdelivr.net/gh/myGit001/tushi-package-windows@main/ExePack/tushi-promo.mp4)

</div>

---

## Table of Contents

- [Quick Start](#quick-start)
- [Requirements](#requirements)
- [Installation & Launch](#installation--launch)
- [Forward Generation](#forward-generation)
- [Reverse Engineering](#reverse-engineering)
- [Workflow Configuration](#workflow-configuration)
- [AI Inference & Voice-Over](#ai-inference--voice-over)
- [Project Interface](#project-interface)
- [Export](#export)
- [Command Line (CLI)](#command-line-cli)
- [AI Agent Skills](#ai-agent-skills)
- [FAQ](#faq)
- [Resources](#resources)

---

> **Tushi** is an **AI workflow batch-execution tool**. It organizes a project's assets (text, images, video, audio, characters, 3D models) into a unified data model, then **batch-dispatches** any workflow — local ComfyUI / RunningHub or other platforms — to run against them, and automatically collects & files the results back into the project. If it's a ComfyUI-compatible workflow, Tushi can run it in bulk, project by project.

## ✨ Why Tushi

| | | |
|---|---|---|
| 🚂 **Batch everything** | 🔗 **Full pipeline** | 🧩 **Bring your own workflow** |
| One workflow hits dozens–hundreds of shots at once. Paste → auto-split → batch generate → export. | Text → prompt → image → video → voice-over → post. Every stage is a workflow; they chain into one click. | Workflows are 100% yours (anything ComfyUI-compatible). Tushi only handles dispatch, params & result collection. |
| 🌐 **4 execution channels** | ⏩ **Forward & Reverse** | 🎬 **JianYing (CapCut CN) export** |
| Local ComfyUI / RunningHub / RunningHub Model API / Zhenzhen AI — switch freely. | Forward: text in, video out. Reverse: import video → auto scene split → reverse-engineer prompts. | Drafts with subtitles, animation, transitions & effects, ready for cutting. |
| 📦 **Local video toolbox** | 🧠 **AI inference** | 🔌 **CLI & AI-agent ready** |
| Speed, reverse, trim, concat, frames, subtitles, BGM, watermark. | LLM rewriting, prompt, character & shot generation. | Scripts & AI agents drive the whole pipeline via a built-in CLI. |

## Quick Start

1. **Download** the bundle from [Xunlei Pan](https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen) or [Quark Pan](https://pan.quark.cn/s/eb8e9af1a277?pwd=susf), extract, and double-click **运行途视.bat**.
2. Pick an **execution backend** — local ComfyUI / RunningHub / RunningHub Model API / Zhenzhen AI ([cloud options with free credits](#requirements)).
3. Open **Settings**: set your **asset save path**, optional **JianYing draft path**, and the **inference / voice-over workflows**.
4. Create a **project** → paste text (forward) or import a video (reverse) → generate.

## Requirements

| Backend | Description | What You Need |
|---------|-------------|---------------|
| **Local ComfyUI** | Your own local/server ComfyUI | ComfyUI installed, workflow exported in **API format** |
| **RunningHub** | Cloud workflow / AI-app marketplace | RunningHub account + API Key |
| **RunningHub Model API** | Enterprise model endpoints | Model API Key |
| **Zhenzhen AI** | LLM aggregation platform (T8) | Zhenzhen AI Key |

**No local ComfyUI? Use cloud** (free credits for new users):

| Platform | Bonus | Sign Up |
|----------|-------|---------|
| **Xiangong Cloud** | 4 free hours of RTX 4090 | [Register](https://www.xiangongyun.com/register/83FV6Z) |
| **Compshare** | ¥10 credit | [Register](https://passport.compshare.cn/register?referral_code=6ciWIQ1SWkeBvh6brdIqbu) |
| **RunningHub** | 1000 credits + 100 daily | [Register](https://www.runninghub.cn/user-center/1897913667256500225/userPost?inviteCode=rh-v1476) |

**Recommended extras**

- **ComfyUI extensions**: [ComfyUI-Common-Extension](https://gitee.com/zttbb/ComfyUI-Common-Extension) · [comfy-portal-endpoint](https://github.com/ShunL12324/comfy-portal-endpoint) — source workflows, LoRA previews, etc.
- **Browser extension**: *Downloads Overwrite Already Existing Files* — so saving an API workflow overwrites the file instead of creating `workflow (1)`.

## Installation & Launch

```
├── 更新并启动途视.bat   # update + launch (needs internet)
└── 途视包-Windows/
    ├── 途视/                  # main app: 途视.exe + runtime + 途视_Data/ + Bin/Res/
    ├── ExePack/               # helpers: 途视CLI.exe + FFmpeg (ffmpeg / ffprobe)
    ├── 外部工作流（API）/      # API-workflow folders for local ComfyUI
    ├── skills/                # AI-agent skills (tushi-cli-creation, tushi-cli-resume, …)
    ├── 运行途视.bat           # one-click launch
    ├── VC_redist.x64.exe      # Visual C++ runtime (install if prompted)
    └── README.md / README.zh.md
```

Launch via **更新并启动途视.bat** (recommended — syncs the latest build from Gitee) or **运行途视.bat** (direct launch).

> `途视/GameData/` is your user data directory (cached images/videos) — created on first run, never overwritten by updates.

## Forward Generation

**Semi-auto (fine control)**: paste text → split chapters → script → shots → characters → batch text-to-image (scenes & characters) → voice-over → to-video → upscale → export

**Full-auto (one click)**: paste text → auto split → pick template → adjust prompts → run → export

| Feature | What it does |
|---------|-------------|
| Auto chapter split | Split text into chapter tabs by a "Chapter X" regex |
| Novel / script generation | LLM polishes source text or outputs script format |
| Shot generation | LLM returns a JSON shot table (scene / characters / dialogue / image & video prompts / duration) and builds shots |
| Character editing | Central character params (prompt, LoRA, reference image, 3D model); auto-builds a library and attaches to shots |
| Batch text-to-image | Skip-done / all / odd / even / first-shot-only one-click modes |
| Multi-image / multi-video | One shot holds several images & clips; split into separate shots in one click |
| Voice-over | TTS via workflow (optional); align video speed to audio |
| Video generation | text-to-video, image-to-video, video-to-video, first-last frame |
| Lip-sync / upscale | Via the matching workflow (e.g. kling-lip-sync) |

## Reverse Engineering

```
Import video → adjust split threshold → auto scene split → extract keyframes
→ OCR subtitle text (optional) → reference-image generation / prompt reverse-engineering → hand off to forward
```

- **Scene split**: FFmpeg scene detection (adjustable threshold, min/max segment length; also usable as one segment)
- **Keyframes**: grab frames at time intervals as reference images
- **Subtitle recognition**: local OCR (PPOCRv5) extracts text as source text for the forward pipeline

Reverse and forward share one framework and connect seamlessly — every prompt and workflow is configurable.

## Workflow Configuration

### Workflow categories → function buttons

Each folder under `外部工作流（API）/` (External-Workflows API) maps to a function button:

| Category | Workflows |
|----------|-----------|
| **推理 Inference** | Infer Characters · Generate Novel · Generate Script · Generate Shots · Source Text · Source Text Rewrite · Prompt · Prompt2 |
| **生图 Image** | Text-to-Image · Image-to-Image |
| **视频 Video** | Text-to-Video · Image-to-Video · Reference-to-Video · Video-to-Video |
| **音频 Audio** | Audio (TTS) |
| **模型3D Model** | 3D Model |

### Binding rules

Workflows identify inputs & outputs by **node title**:

- **Input node title** format: `输入-数据来源-数据类型` (e.g. `输入-当前镜头-提示词`), with 30+ input types: source text, prompt, reference image, reference video, audio, characters, 3D model, etc.
- **Output node title** format: `输出=类型` (text, image, video, audio, 3D model all supported)
- **Data sources**: current / previous / next shot, favorited / project character, custom

### Setup

- **Local ComfyUI**: get it working in the browser → export API format into `外部工作流（API）/<category>` → bind inputs/outputs in Tushi (blue = defaults, yellow = modified)
- **RunningHub**: assign the workflow (browse/search templates & AI apps) → configure API Key → fill bound inputs
- **Extra parameters**: custom params (frame rate, duration, text, local paths…) set in Settings; empty shots use workflow defaults.

## AI Inference & Voice-Over

All inference runs through **workflows** (drop the workflow into the matching folder):

| Type | Purpose |
|------|---------|
| Source Text Rewrite | polish / condense text |
| Prompt / Prompt2 | visual prompt → English prompt |
| Character Inference | auto-build the character library |
| Generate Novel / Script | chapter text / script format |
| Generate Shots | shot table (scene / dialogue / prompts) |

**Voice-over**: also a workflow (Audio category) — text → TTS node → audio file. Each shot can set an audio character (separate from the visual one), a global voice, volume/speed, and video duration aligned to audio.

## Project Interface

- **Views**: list view (flat, per-item) or panel view (image + text side by side)
- **Shot states**: red = pending, green = complete; shows image/video counts & runtime
- **Shot ops**: move, insert, delete, duplicate, **merge** (concat video/audio/text), **split** (multi-image/video → sub-shots), swap
- **Images** & **video** are two independent areas: add / delete / select / copy-as-reference; mask editing, sketch, framing; trim, speed, reverse, frame extraction, resolution
- **Advanced**: reference image/video & 3D model per shot; batch one-click text→prompt→prompt2 or clear image/video/voice/reference (global or per chapter)

## Export

| Option | Description |
|--------|-------------|
| **JianYing draft** | Image/video + subtitles + animation + transitions + position animation + effects + voice-over (rendered by JianYing) |
| **Video (mp4)** | FFmpeg composite of source video + voice-over + BGM, no effects |
| **Images** | Export shot images |
| **CSV** | Export rewritten text / prompts / translated text |

Draft effects: shot in/out/combined animation (random/sequential/fixed), transitions, keyframe position animation, built-in JianYing effects, auto subtitle track (color/size/position), intro text / global text / outro video & music. Export settings: **shots per file** (`9999` = whole chapter in one video, `1` = one video per shot), merge chapters, align video length to audio, live export estimates on the right panel.

## Command Line (CLI)

`ExePack/途视CLI.exe` lets scripts, batch files & AI agents drive the whole pipeline — **the director stays outside, the factory stays in Tushi**.

```
CLI / script / AI agent ──▶ built-in service 127.0.0.1:19112 ──▶ workflow → filing → export
                                    (途视/途视.exe must be running)
```

- Forwards only; **the main app must be running** (usually `login` first)
- Port `19112` (override: `途视.exe --aicli-port <port>`; auth: `--aicli-token xxx` + `--token xxx`)
- **All output is one line of JSON** — check `ok`; exit code 0/1
- Long tasks return a `jobId`; add `--wait` to poll until done

```bash
ExePack\途视CLI.exe <command> [key=value ...] [JSON] [options]
```

| Option | Description |
|--------|-------------|
| `--json '{...}'` | Pass nested/array params as JSON |
| `--arg key=value` | Append one param (repeatable) |
| `--wait` `--poll 2` `--timeout 600` | Poll a long task (interval / max seconds) |
| `--port` / `--host` / `--url` / `--token` | Service address / auth token |

Commands are case-insensitive (`shot gen` = `shot.gen`). **The exact command set & parameters come from the running app — introspect first**:

```bash
ExePack\途视CLI.exe help                       # list available commands
ExePack\途视CLI.exe schema name="shot creates" # show a command's parameters
```

**What you can drive** (capability overview — live names/params via `help` / `schema`):

| Area | What you can do |
|------|-----------------|
| Introspection / connection | list commands, read params, health check, login, raise UI |
| Settings | read/write config (e.g. JianYing draft path) |
| Projects | create/read/update/delete projects, chapters, handoff, global voice |
| Templates / Characters | read templates; build character library & batch character sheets |
| Shots | CRUD, batch generation, assets & continuity |
| Workflows | list/import, bind inputs/outputs, custom params, template workflows |
| Run / Export / Audio | submit & track runs, pre-export QC; JianYing draft / mp4; voices & categories |

**Caveats**: introspect first — `shot creates` prompt fields are `imagePrompt` / `videoPrompt` (a wrong field name returns success but writes empty content; `shot get` to verify). PowerShell may swallow output in scripts — call via Python `subprocess` and read UTF-8. No separate account system; it uses the main app's login & project files.

## AI Agent Skills

The package bundles a set of **AI-agent skills** (`skills/`) that let an AI assistant — Claude Code, Trae, Cursor, … — drive the whole pipeline for you: idea → script → storyboard → images → video → voice-over → JianYing draft. The AI sits in the director's seat and operates 途视 through the CLI.

| Skill | What it does |
|-------|--------------|
| `tushi-cli-creation` | From-scratch production (local). The AI launches 运行途视.bat, creates the project, pulls the director template, generates characters / shots / images / video / voice-over, and exports a JianYing draft. |
| `tushi-cli-resume` | Take over a half-finished project. The AI reads the real project state through the CLI and continues from the breakpoint — no guessing. |

**How to use**: copy the skill folder into your AI assistant's skills directory, then simply say something like *"用途视出一段短剧."* The AI will start 运行途视.bat itself and drive 途视 through 途视CLI.exe (or the HTTP service at `127.0.0.1:19112`). Pairs with the CLI section above — command names & parameters are always introspected at runtime (`help` / `schema` / `template get`).

## FAQ

<details>
<summary>Do I have to use a local ComfyUI?</summary>

No — use cloud services (Xiangong Cloud, Compshare, RunningHub) with no local setup.
</details>

<details>
<summary>How do I configure workflows?</summary>

Local: run it in ComfyUI → export API format → drop into the matching folder (one function button = one folder). Cloud: assign the workflow, then review & bind inputs in Tushi.
</details>

<details>
<summary>What does a red marker mean?</summary>

A backend (ComfyUI / RunningHub) isn't connected, or its workflow file wasn't found.
</details>

<details>
<summary>Can I mix reverse and forward?</summary>

Yes — they share one framework and connect seamlessly.
</details>

<details>
<summary>The CLI won't connect. What now?</summary>

Confirm the main app is running — `途视CLI.exe system status` returning JSON means it's up. If you moved the port, start `途视.exe --aicli-port <port>` and pass `--port <port>`; the port-holder is logged at startup.
</details>

<details>
<summary>What backend handles inference, translation & voice-over?</summary>

All through **workflows** — place them in the matching folder and select in the app. Translation output goes to "Prompt2" (English prompts).
</details>

## Resources

| Resource | Link |
|----------|------|
| **This repo (Gitee)** | https://gitee.com/zttbb/tushi-package-windows |
| **ComfyUI extensions** | [ComfyUI-Common-Extension](https://gitee.com/zttbb/ComfyUI-Common-Extension) · [comfy-portal-endpoint](https://github.com/ShunL12324/comfy-portal-endpoint) |
| **Bilibili tutorials** | https://space.bilibili.com/199774118 |
| **Xunlei Pan (bundle)** | https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen |
| **Quark Pan** | https://pan.quark.cn/s/eb8e9af1a277?pwd=susf |

---

<div align="center">

⭐ **If Tushi helped you make something cool, give the repo a star and follow [@zzbbto](https://space.bilibili.com/199774118) for tutorials.**

Made with ❤️ by [@zzbbto](https://space.bilibili.com/199774118)

</div>