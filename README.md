# Tushi — AI Batch Video Generation Tool

[简体中文](README.zh.md) | English

**AI video creation for Windows.** Turn novels, scripts or plain text into short dramas, motion comics and AI videos — in batch.

- **Built for:** short drama / micro drama / vertical drama, motion comic, AI comic, novel-to-video, AI storytelling, AI commentary video, video style remixing, AI filmmaking, AI content creation
- **Powered by:** ComfyUI, RunningHub, Stable Diffusion, Kling, Jimeng, Vidu, MiniMax (Hailuo), Doubao, Sora
- **Pipeline:** text-to-image, image-to-video, text-to-video, lip-sync, TTS voice-over, upscaling, 3D model generation, JianYing (CapCut CN) draft export

<p align="center">
  <b>Multiply your output. A batch-generation workhorse for motion comics, short dramas, and reverse-prompting workflows.</b>
</p>

> **Tushi** is an **AI workflow batch-execution tool**. It organizes a project's assets (text, images, video, audio, characters, 3D models, and more) into a unified data model, then **batch-dispatches** any workflow — local ComfyUI, RunningHub, or other platforms — to run against them, and automatically collects and files the results back into the project. Text-to-image, image-to-video, LLM inference, voice-over, 3D generation — if it's a ComfyUI-compatible workflow, Tushi can run it in bulk, project by project.

---

<video src="https://github.com/myGit001/tushi-package-windows/raw/main/ExePack/tushi-promo.mp4" controls preload="metadata"></video>

## Overview

At its core, Tushi is about **running workflows in batches**: you organize your content into a **project + shots** structure, then send the whole batch of shots through your configured workflows (local ComfyUI / RunningHub / etc.) with one click. Data goes in automatically, results come back automatically, everything gets filed automatically.

What that buys you:

- **Batch** — one workflow can hit dozens or hundreds of shots at once; no more running them one by one
- **Pipeline** — text → prompts → images → video → voice-over → post; every stage is a workflow, and they chain into a single run
- **Flexible** — workflows are entirely yours to define (anything ComfyUI-compatible). Tushi only handles dispatch, parameter passing, and result collection
- **Multi-platform** — the same pipeline can switch between local ComfyUI, RunningHub, or other cloud channels

Typical uses (what a workflow actually does is up to your configuration):

- Text workflows: rewriting, translation, LLM inference, shot/script/character generation
- Image workflows: text-to-image, image-to-image, face swap, upscaling, prompt reverse-engineering
- Video workflows: text-to-video, image-to-video, lip-sync, motion transfer, first/last frame
- Audio workflows: TTS voice-over, music
- 3D workflows: model generation

### Use Cases

| Use Case | What Tushi Does |
|---------|-----------------|
| **Motion comics / dynamic manga** | Feed in novel text → auto chapter & shot splitting → batch image generation → image-to-video → voice-over → export JianYing draft |
| **Short dramas** | Script to shots, images, video, lip-sync, and upscaling — fully automated batch output |
| **Commentary / news videos** | Copy → illustrations → voice-over → finished cut, produced in batches |
| **Video remixing / style reference** | Import a reference video, auto-split shots, extract keyframes, reverse-engineer prompts, then batch-generate frames in the same style |
| **Novel visualization** | Turn text into shot illustrations and build a video novel |

> Tushi ships with two ways to organize work: **forward generation** (start from a piece of text and batch-produce content) and **reverse engineering** (start from a reference video, split scenes, extract keyframes, reverse-engineer prompts, then feed into batch generation). Both converge on the same core: **shots → batch-run workflows**.

---

## Highlights

- **Batch workflow execution** — run an entire shot list through your workflow in sequence, with automatic input feeding and result collection
- **Forward pipeline** — paste text, auto-split into shots, batch-generate images and video
- **Reverse pipeline** — import a reference video for automatic scene splitting, keyframe extraction, and subtitle text recognition
- **Semi-auto & full-auto modes** — fine-grained control or one-click batch generation
- **Four execution channels** — local ComfyUI / RunningHub / RunningHub Model API / Zhenzhen AI, switchable at will
- **Full pipeline coverage** — shots → images → video → voice-over → export, all in one place
- **JianYing draft export** — generate JianYing projects with subtitles, animations, transitions, and effects, ready for further editing
- **Local video toolbox** — speed change, reverse, trim, concat, frame extraction, subtitle extraction, background music, watermarking

---

## Table of Contents

- [Overview](#overview)
- [Promo Video](#promo-video)
- [Requirements](#requirements)
- [Installation & Launch](#installation--launch)
- [Getting Started](#getting-started)
- [Forward Generation Workflow](#forward-generation-workflow)
- [Reverse Engineering Workflow](#reverse-engineering-workflow)
- [Workflow Configuration](#workflow-configuration)
- [AI Inference](#ai-inference)
- [Voice-Over](#voice-over)
- [Project Interface](#project-interface)
- [Export](#export)
- [Command Line (CLI)](#command-line-cli)
- [FAQ](#faq)
- [Video Tutorials](#video-tutorials)
- [Resources](#resources)

---

## Requirements

### 1. Download

Get the latest release from one of the mirrors:

| Source | Link | Notes |
|--------|------|-------|
| Xunlei Pan | [Download](https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen) | Full bundle |
| Quark Pan | [Download](https://pan.quark.cn/s/eb8e9af1a277?pwd=susf) | Faster download |

### 2. Workflow Execution Backend

Tushi supports four execution channels — pick what you need (they can be mixed):

| Backend | Description | What You Need |
|---------|-------------|---------------|
| **Local ComfyUI** | Your own local/server ComfyUI | ComfyUI environment installed, workflow working and exported in API format |
| **RunningHub** | Cloud workflow / AI app marketplace | RunningHub account + API Key |
| **RunningHub Model API** | RunningHub enterprise model endpoints | Model API Key |
| **Zhenzhen AI** | LLM aggregation platform (T8) | Zhenzhen AI Key |

**Cloud usage**: no local setup required — just use the cloud service. Recommended platforms (new-user bonuses):

| Platform | Bonus | Sign Up |
|----------|-------|---------|
| **Xiangong Cloud** | 4 free hours of RTX 4090 for new users | [Register](https://www.xiangongyun.com/register/83FV6Z) |
| **Compshare** | ¥10 for new users | [Register](https://passport.compshare.cn/register?referral_code=6ciWIQ1SWkeBvh6brdIqbu) |
| **RunningHub** | 1000 credits for new users, plus 100 daily on login | [Register](https://www.runninghub.cn/user-center/1897913667256500225/userPost?inviteCode=rh-v1476) |

### 3. ComfyUI Extensions (Optional, Recommended)

Install the companion extensions to get source workflows, LoRA preview images, and other enhancements:

```bash
git clone https://gitee.com/zttbb/ComfyUI-Common-Extension
git clone https://github.com/ShunL12324/comfy-portal-endpoint
```

### 4. Browser Extension (Strongly Recommended)

Install **Downloads Overwrite Already Existing Files** so saving API workflows overwrites the original file instead of producing duplicates like `workflow (1)` or `workflow (2)`.

---

## Installation & Launch

After downloading and extracting the bundle:

```
├── Update-and-Launch-Tushi.bat   # One-click update + launch (requires internet)
└── Tushi-Package-Windows/
    ├── Tushi/                    # Main program
    │   ├── Tushi.exe             # Entry point
    │   ├── UnityPlayer.dll       # Unity runtime
    │   ├── GameAssembly.dll      # Game logic assembly
    │   ├── baselib.dll           # Base runtime library
    │   ├── UnityCrashHandler64.exe  # Crash handler
    │   ├── Tushi_Data/           # Unity asset data
    │   └── Bin/Res/              # Built-in resources (UI, fonts, materials)
    ├── ExePack/                  # Helper tools
    │   ├── TushiCLI.exe          # CLI entry (external scripts / AI agents)
    │   ├── FFmpeg/               # Video engine (ffmpeg / ffprobe)
    │   ├── process_server.exe    # Process service (127.0.0.1:19111)
    │   └── openFolder.bat        # Helper script for opening asset folders
    ├── External-Workflows (API)/ # API workflow directory for local ComfyUI
    │   ├── Text2Image / Text2Video / Image2Image / Image2Video / Video2Video
    │   ├── Inference Center / Generate Shots / Generate Script / Generate Novel / Infer Characters
    │   ├── Prompt / Prompt2 / 3D Model / Audio
    │   └── Source Text / Source Text Rewrite
    ├── Run-Tushi.bat             # One-click launch script
    └── README.md                 # This file
```

### Launching

- Double-click **Update-and-Launch-Tushi.bat**: syncs the latest version from Gitee and launches (recommended for first install or upgrades)
- Double-click **Run-Tushi.bat**: launches the current version directly (no update)
- Running `Tushi/Tushi.exe` directly also works

> **Note**: `Tushi/GameData/` is the user data directory (locally cached images, videos, etc.). It is created on first run and is never overwritten during updates.

---

## Getting Started

### First-Run Setup

1. Launch the app and open the **Settings** page
2. Set the **project asset save path** (asset cache location)
3. Set the **JianYing draft install path** (if you plan to export to JianYing)
4. Configure **SDWebUI / ComfyUI / RunningHub** connection parameters
5. Configure the ComfyUI workflows used for **inference / translation / voice-over**

> **Note**: settings take effect immediately — no manual save. A red marker means the backend is not connected or a file was not found.

### Creating a Project

| Project Type | Description |
|--------------|-------------|
| **Forward** | Input a text passage and auto-generate shots into video |
| **Reverse** | Import a video file or folder for scene splitting and reference-image generation |
| **Generate Novel / Generate Script** | Rewrite from source text via inference, or generate a script |

To import new content while keeping the project name, just run the flow again — it will overwrite.

---

## Forward Generation Workflow

### Semi-Automatic (Fine Control)

```
Paste text → split chapters → generate script → generate shots → edit characters
→ batch text-to-image for scenes → batch text-to-image for characters → select audio (optional)
→ shot images → multi-image/multi-video split (optional) → voice-over (optional)
→ image-to-video / first-last-frame video → lip-sync (optional) → upscale (optional) → export
```

### Full-Automatic (One Click)

```
Paste text → auto shot split → choose template → adjust prompts → run
→ lip-sync (optional) → upscale (optional) → export
```

### Core Feature Notes

| Feature | Description |
|---------|-------------|
| Auto chapter split | Splits text into chapter tabs using a "Chapter X" regex |
| Novel / script generation | LLM rewrites and polishes source text, or produces script format |
| Shot generation | LLM returns a shot table as JSON (scene / characters / dialogue / image prompt / video prompt / duration) and creates shots automatically |
| Character editing | Centralized character parameters (prompt, LoRA, reference image, 3D model); character inference builds the library and attaches it to shots |
| Batch text-to-image | One-click options: skip completed / all / odd / even / first shot only |
| Multi-image / multi-video | A shot can hold multiple images and videos, and can be split into separate shots |
| Voice-over | Generated via ComfyUI workflow; optional step |
| Image-to-video | Supports text-to-video, image-to-video, video-to-video, first-last-frame video |
| Lip-sync / upscale | Via RunningHub Model API (e.g. kling-lip-sync) or the corresponding workflow |

> **Note**: the inference center defaults to RH free models (quality floor). For better results, build your own workflows or use paid models.

---

## Reverse Engineering Workflow

```
Import video → adjust split threshold → auto scene split → extract keyframes as references
→ OCR subtitle text (optional) → reference-image generation / prompt reverse-engineering
→ ...hand off to the forward pipeline
```

- **Scene splitting**: FFmpeg-based scene detection with adjustable threshold, min/max segment duration; the whole clip can also be used as one segment
- **Keyframe extraction**: grabs frames at time intervals as reference images
- **Subtitle recognition**: local OCR (PPOCRv5) extracts text from video/images as source text for the forward pipeline

> **Note**: reverse and forward share the same framework and connect seamlessly. Every step's prompts and workflows are yours to adjust.

---

## Workflow Configuration

### Supported Models & Platforms

Tushi can call all major models below, letting you balance cost against quality:

| Type | Platforms / Models |
|------|--------------------|
| **Free models** | RunningHub free models |
| **Major CN models** | Doubao, Kling, Jimeng, Hailuo (MiniMax), Vidu |
| **Major international** | Sora, BigBanana, and more |
| **Generic workflows** | Any ComfyUI-compatible workflow |

### Workflow Categories

Each subdirectory under `External-Workflows (API)/` maps to a function button in the app:

| Category | Workflow Types |
|----------|----------------|
| **Image** | Text-to-image, image-to-image, face swap, outfit swap, image editing, upscale |
| **Video** | Text-to-video, image-to-video, video-to-video, face swap, first-last frame, lip-sync, motion transfer, background audio, upscale |
| **Inference** | Inference center, novel, script, shots, characters |
| **Other** | Prompt, Prompt2, 3D model, audio, source text, source text rewrite |

### Workflow Binding Rules

Workflows identify inputs and outputs by **node title**:

- Input node title format: `input-data-source-data-type` (e.g. `input-current-shot-prompt`), supporting 30+ input types such as source text, prompt, image, reference image, reference video, audio, and character
- Output node title format: `output=image` (images, video, audio, text, and 3D models can all be outputs)
- Data sources: current shot / previous shot / next shot / favorited character / project character / custom

### ComfyUI Workflow Setup (Local)

1. Get the workflow working in the ComfyUI browser
2. Export it in **API format** and place it in the matching directory under `External-Workflows (API)/` (one function button = one folder)
3. Bind input parameters (cross-shot, character selection) and output nodes inside Tushi
4. Blue boxes are workflow default parameters; yellow means modified

### RunningHub Workflow Setup (Cloud)

1. Assign/bind the workflow in RunningHub (you can browse and search workflow templates and AI apps inside Tushi)
2. Configure your RunningHub API Key
3. Review the workflow's bound input parameters and fill them in inside Tushi

### SDWebUI Support

> SDWebUI is no longer receiving new features. Currently supported: image generation, upscale, LoRA, ControlNet, WD prompt reverse-engineering

### Extra Parameters

Custom parameters are supported (frame rate, duration, text, local asset paths, etc.). Configure them in Settings first; if a shot leaves them empty, the workflow defaults apply.

---

## AI Inference

Tushi has built-in LLM inference for text rewriting, prompt extraction, character extraction, and shot generation. Inference always runs through **ComfyUI workflows** — just drop the matching workflow into the corresponding directory under `External-Workflows (API)/`:

| Type | Input | Output | Purpose |
|------|-------|--------|---------|
| Source Text Rewrite | current page/chapter text | rewritten text | polishing, condensing |
| Prompt | rewritten text | visual prompt | for text-to-image |
| Prompt2 | prompt | translated text | English prompt generation |
| Character Inference | current page of source text | character profile (auto-builds character library) | character management |
| Generate Novel | combined data + template | novel body | chapter text |
| Generate Script | combined data + template | script text | script format |
| Generate Shots | combined data + template | shot table (scene / dialogue / image prompt / video prompt) | auto shot splitting |
| Inference Center | image/audio/video + characters + workflows | AI decisions (auto-edit shots/characters and call workflows) | fully automated creation |

---

## Voice-Over

Voice-over also runs through **ComfyUI workflows** (the `Audio` category): text in → TTS node → audio file out.

- Each shot can specify an **audio character** (separate from the visual character), with support for a global voice
- Volume and speed are adjustable, and video duration can be aligned to audio (automatic speed adjustment)

---

## Project Interface

### Views

| View | Description |
|------|-------------|
| **List view** | Flat shot list for per-item operations |
| **Panel view** | Shot cards with image and text side by side |

### Shot Management

- **Red background**: not yet complete; **green background**: complete
- Shows image count, video count, and workflow runtime for the current shot
- Supported operations: move up/down, insert, delete, duplicate, **merge** (concatenate video/audio/text), **split** (multi-image/multi-video into sub-shots), swap

### Image / Video Management

Images and video are **two independent management areas**, each supporting add, delete, select, and copy-as-reference:

- **Images**: a shot can hold multiple images, with mask editing, sketch input, and framing tools
- **Video**: a shot can hold multiple clips, with trim, speed change, reverse, frame extraction, resolution/frame-rate adjustment
- When text-to-video runs without an input image, a first-frame image is created automatically on success
- Shots also support reference images, reference video, and 3D models

### Advanced Operations

- **Image editing**: open details for mask editing, sketch input, and 360 framing
- **Video concatenation**: use "merge upward" on a shot to concatenate clips (do this after upscaling — very long clips can fail to process)
- **Asset selection**: local images/video/audio, or images from adjacent shots; the seconds parameter controls which frame to grab
- **One-click actions**: batch source text → prompt, prompt → prompt2, or clear images / video / voice-over / references — applied globally or to a single chapter

---

## Export

### Export Options

| Option | Description |
|--------|-------------|
| **Export JianYing draft** | Generates a JianYing project (image/video + subtitles + animation + transitions + position animation + effects + voice-over); JianYing renders it |
| **Export video** | FFmpeg composites an mp4 directly (source video + voice-over + background music), no effects |
| **Export images** | Exports shot images |
| **Export CSV** | Exports rewritten text / prompts / translated text |

### JianYing Draft Effects

- **Shot animation**: in / out / combined animation, with random, sequential, or fixed modes
- **Transitions**: transition effects between shots
- **Position animation**: horizontal/vertical keyframe movement
- **Shot effects**: built-in JianYing effects (identified by resource ID)
- **Subtitles**: auto-generated subtitle track from rewritten text, with configurable color, size, and position
- **Intro/outro**: intro text, global text, outro video, outro music (loopable)

### Export Settings

- **Shots per file**: how many shots go into one video
  - Set to `9999`: the whole chapter merges into a single video
  - Set to `1`: each shot exports as its own video
- **Merge chapters**: merge chapter output
- **Align video duration to audio**: automatically adjusts video speed to match voice-over length
- The right panel shows estimated export count, total duration, and total shot count

---

## Command Line (CLI)

Beyond the UI, Tushi ships a command-line entry point: `ExePack/TushiCLI.exe`. It lets scripts, batch files, and AI agents drive the whole creation pipeline — **the director stays outside, the factory stays in Tushi**: the outside decides *what to run*, while workflow dispatch, asset collection, and export remain inside Tushi.

### How It Works

```
CLI / script / AI agent
        │  POST {"cmd":"shot gen","args":{...}}
        ▼
Built-in service in Tushi main app — 127.0.0.1:19112   ← Tushi/Tushi.exe must be running
        │
        ▼
Workflow execution → asset filing → export
```

- The CLI does no work itself; it only forwards. **The main app must be running** (the first run usually needs `login`)
- Default port `19112`; the main app can switch with `Tushi.exe --aicli-port 19212`, and enable auth with `--aicli-token xxx` (then commands must pass `--token xxx`)
- **All output is a single line of JSON** — check `ok` for success; process exit code is 0 / 1
- Long tasks like generation and export return a `jobId` and return immediately; add `--wait` to poll until finished

### Usage

```bash
ExePack\TushiCLI.exe <command> [key=value ...] [JSON object] [options]
```

| Option | Description |
|--------|-------------|
| `--json '{...}'` | Pass parameters as JSON — use this for arrays and nested structures |
| `--arg key=value` | Append a single parameter, repeatable |
| `--wait` | Poll a long task until it finishes (default returns jobId immediately) |
| `--poll 2` | Polling interval in seconds when using `--wait` (default 2) |
| `--timeout 600` | Max wait seconds for `--wait`; 0 = unlimited |
| `--port` / `--host` / `--url` | Specify the service address |
| `--token` | Auth token (when the main app has auth enabled) |

Command names are case-insensitive: `shot.gen`, `Shot_Gen`, and `shot gen` are equivalent. When in doubt about parameters, use **introspection**:

```bash
ExePack\TushiCLI.exe help                      # List all commands
ExePack\TushiCLI.exe schema name="shot creates"  # Show a command's parameters
```

### Command Reference

| Group | Commands | Description |
|-------|----------|-------------|
| **Connection / Introspection** | `help`, `schema`, `system status`, `login`, `ui main` | Command list, parameter help, health check, login, raise main window |
| **Settings** | `setting get` / `set` / `list` | Read/write config items (e.g. JianYing draft path) |
| **Project** | `project list` / `get` / `create` / `set` / `delete` / `progress` | Project CRUD and progress |
| | `project key add` / `list` / `delete` | Chapter (tab) management |
| | `project handoff get` / `set`, `project setsound` | Handoff info, global voice |
| **Templates** | `template list` / `get` | Project templates |
| **Characters** | `role creates` / `list` / `get` / `set` / `gen` / `stop` / `copy` / `bind` / `res` / `delete` | Character library and batch character-sheet generation |
| **Shots** | `shot creates` / `list` / `get` / `set` / `gen` / `stop` / `insert` / `delete` / `trim` / `res` / `frame` | Shot CRUD, batch generation, asset and continuity management |
| | `shot setsound` / `shot setaudiorole` / `shot setusevideo` | Dialogue audio, voice-over character, whether to use video |
| **Workflows** | `workflow list` / `get` / `inputs` | Workflow list (requires template name) and inputs/outputs |
| | `workflow temp list` / `get` / `set` | Template workflows |
| | `workflow param list` / `set` / `bind`, `workflow customize list` / `set` / `delete` | Parameter binding and custom parameters |
| | `workflow intype list`, `workflow out type list`, `workflow out set` | Input / output types |
| **Run** | `run preview` / `status` / `list` / `qa` | Submit preview, check progress by jobId, pre-export QC |
| **Export** | `export draft`, `export video` | JianYing draft / mp4 output |
| **Audio** | `sound list` / `get` / `create` / `set` / `delete`, `sound tab list` / `create` | Voices and voice categories |

### Typical Flow

```bash
ExePack\TushiCLI.exe login
ExePack\TushiCLI.exe project create projectName="My Short Film"
ExePack\TushiCLI.exe role creates projectName="My Short Film" --json '{"roleItems":[{"name":"Alan"}]}'
ExePack\TushiCLI.exe role gen projectName="My Short Film" workflowSn=6102 --json '{"roleSn":[1]}'
ExePack\TushiCLI.exe shot creates projectName="My Short Film" --json '{"shotItems":[{"dialogue":"...","imagePrompt":"...","videoPrompt":"..."}]}'
ExePack\TushiCLI.exe shot list projectName="My Short Film"
ExePack\TushiCLI.exe shot gen projectName="My Short Film" workflowSn=10401 --json '{"shotSn":[1,2,3]}' --wait
ExePack\TushiCLI.exe run qa projectName="My Short Film"
ExePack\TushiCLI.exe export draft projectName="My Short Film" --wait
```

Get `workflowSn` from `workflow list`, and `roleSn` / `shotSn` from `role list` / `shot list`. Once a generation command returns a `jobId`, check progress with `run status jobId=xxx`.

### When to Use It & Caveats

- **Good for**: batch scripts, scheduled tasks, external AI agents driving fully automated production; non-interactive pipelines for multi-user collaboration
- **Introspect first**: parameters are defined by `schema`. The prompt fields in `shot creates` are `imagePrompt` / `videoPrompt` — a wrong field name returns success but writes empty content, so `shot get` to spot-check after submitting
- The Windows console (PowerShell) occasionally swallows output; in scripts, call it from Python `subprocess` and read as UTF-8
- The CLI is an external front door to the same UI capabilities — there is **no separate account system**; it uses the main app's current login state and project files

---

## FAQ

### Q: Do I have to use a local ComfyUI?

No. You can use cloud services such as Xiangong Cloud, Compshare, or RunningHub with no local setup.

### Q: How do I configure workflows?

For local use: get the workflow running in the ComfyUI browser, export it in API format, and drop it into the matching directory — one function button per folder.
For cloud use: assign the workflow, then review and bind the input parameters inside Tushi.

### Q: What does a red marker mean?

The corresponding backend is not connected (ComfyUI / RunningHub / SDWebUI), or it is connected but the file was not found.

### Q: Can I mix reverse and forward workflows?

Yes. Both share the same framework and connect seamlessly.

### Q: The CLI does nothing / won't connect. What now?

First confirm the main app is running: `TushiCLI.exe system status` returning JSON means the service is up. If you changed the port or it's occupied, start the main app with `Tushi.exe --aicli-port 19212` and pass `--port 19212` on the command side; the process holding the port is written to the startup log.

### Q: What backend handles inference, translation, and voice-over?

All of them go through **ComfyUI workflows**. Place inference / translation / voice-over workflows in the matching directory under `External-Workflows (API)/` and select them in the app. Translation output is written to "Prompt2" for English prompt generation.

---

## Video Tutorials

📺 **Bilibili channel**: [@zzbbto](https://space.bilibili.com/199774118)

The author keeps publishing Tushi tutorials, tips, and new-feature walkthroughs. Feel free to follow.

---

## Resources

| Resource | Link |
|----------|------|
| **This repository (Gitee)** | https://gitee.com/zttbb/tushi-package-windows |
| **ComfyUI extensions** | [ComfyUI-Common-Extension](https://gitee.com/zttbb/ComfyUI-Common-Extension) · [comfy-portal-endpoint](https://github.com/ShunL12324/comfy-portal-endpoint) |
| **Bilibili tutorials** | https://space.bilibili.com/199774118 |
| **Xunlei Pan (bundle)** | https://pan.xunlei.com/s/VOZTX7ULtVWKUTvuBdUaY7BPA1?pwd=gjen |
| **Quark Pan** | https://pan.quark.cn/s/eb8e9af1a277?pwd=susf |
| **Xiangong Cloud** | https://www.xiangongyun.com/register/83FV6Z |
| **Compshare** | https://passport.compshare.cn/register?referral_code=6ciWIQ1SWkeBvh6brdIqbu |
| **RunningHub** | https://www.runninghub.cn/user-center/1897913667256500225/userPost?inviteCode=rh-v1476 |

---

<p align="center">
  Made with ❤️ by <a href="https://space.bilibili.com/199774118">@zzbbto</a>
</p>
