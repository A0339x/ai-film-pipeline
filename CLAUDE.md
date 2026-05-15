# AI Video Making — Workspace Guide for Claude

This folder is a Higgsfield-first AI video production workspace. When the user opens this folder, they are starting (or continuing) a high-end AI video project — character builds, scene plates, Seedance video shots, optional music + title card, final upscale.

## How this repo activates — two paths

This repo is designed to run in **either** of two Claude environments. The behavior differs slightly depending on which one you (the Claude agent reading this) are running in:

### If you're running in Claude Code CLI (recommended path for users)

**You do not need to tell the user to upload anything to claude.ai.** The four `SKILL.md` files (`banana-pro-director/SKILL.md`, `cinema-worldbuilder/SKILL.md`, `ai-film-director/SKILL.md`, `video-qa/SKILL.md`) are right here in the repo — read them directly with the `Read` tool when the matching trigger fires, and follow them as your operating instructions:

- User says *"I want to make an AI video / music video / commercial / short film / spot"* → read `ai-film-director/SKILL.md` and follow it as the orchestrator.
- User asks for an **image prompt** (character sheet, environment plate, prop sheet, GPT-2 detail shot) → read `banana-pro-director/SKILL.md` and follow it.
- User asks for a **Seedance video prompt** (any single shot or sequence) → read `cinema-worldbuilder/SKILL.md` and follow it.
- User says *"QA my project / check for drift / is this ready to ship"* → read `video-qa/SKILL.md` and follow it.

When the orchestrator instructs you to "call cinema-worldbuilder" or "hand off to banana-pro-director," that means: read the relevant specialist `SKILL.md` and adopt its prompt-grammar rules for the next output. You are the one agent — there is no separate skill invocation step in Claude Code.

In Claude Code you also get **filesystem-native reference handling** (no upload — Read tool picks up images directly), **can run `./scripts/new-project.sh` natively**, and **can install `ffmpeg` in-session** when QC needs it. Use these advantages.

### If you're running in claude.ai (web / desktop)

The four skills exist as installed claude.ai skills (Settings → Capabilities → Skills, uploaded as `.zip` files). They auto-activate based on conversation context. You don't read the `SKILL.md` files directly — the skill system loads them when the matching trigger fires. This folder's job at the workspace level is everything around the skills.

In claude.ai you cannot run shell scripts and cannot auto-install dependencies. Direct the user to run scaffold scripts on a desktop machine if they need them, and remind them to `brew install ffmpeg` (or platform equivalent) before invoking `video-qa`.

---

## The four skills

### The two specialists (compose prompts)

- **`banana-pro-director`** — image prompt director for Higgsfield's Banana Pro (Nano Banana Pro), Soul Cinema, and GPT-2. Owns: single-image character outfits on white seamless, 6-panel character sheets, scene plates (with or without characters), GPT-2 face/chest-up detail. Enforces the locked photoreal stack. Never names. Never brands. Pre-prompt confirmation on every prompt.

- **`cinema-worldbuilder`** — Seedance video prompt director. Five cinema modes (M1 Narrative / M2 Studio / M3 Action / M4 Performance / M5 Atmospheric), each with locked camera/lens/movement/filtration/grade. Diegetic audio only (no music, no lyrics). Single-paragraph output with inline Style & Mood / Dynamic / Static labels. Runtime always asked, never defaulted.

### The two orchestrators (lead the user)

- **`ai-film-director`** — pipeline orchestrator. Activates on any "I want to make an AI video / music video / brand spot / short film" intention. Asks at the start: **guided mode** (default — full seven phases with strict gates, for users who haven't made AI videos in Higgsfield before) or **pro mode** (lean five-step iterative loop — idea → character sheet → scene/reference → shot/prompt → generate/log, for users who know the workflow and want to move fast). Calls `banana-pro-director` and `cinema-worldbuilder` at the right moments, pauses for Higgsfield generation, protects against credit-burning pitfalls (drift, runtime overshoot, mode mismatch, music in video prompts, brand contamination). **Mode is switchable mid-project** — say "switch to pro" or "switch to guided" any time.

- **`video-qa`** — quality-control supervisor. Activates on "QA my film," "is this ready to ship," "check for drift." Asks at the start: **guided QC** (default — three-tier sweep across eight weighted categories, 0–100 health score with Ship/Hold/Block verdict, saved report — for ship-readiness checks and hero projects) or **pro QC** (three checks only — drift screening, continuity audit, prompt rule scan — no score, no report, for in-flight checks during a generation session). Pauses the producer with evidence (frame still + reference image side-by-side), diagnoses the cause from `generation-log.md`, prescribes a fix path, hands back to the right specialist skill. **Mode is switchable mid-pass.**

**Do not duplicate these skills.** When the user asks for an image prompt, `banana-pro-director` handles it. When they ask for a video prompt, `cinema-worldbuilder` handles it. When they want to start or run a project end-to-end, `ai-film-director` leads. When they want to QC what they've built, `video-qa` audits. This folder's job is everything *around* the skills: planning artifacts, music, title cards, tracking, file organization.

## The production stack (from the K-Pop breakdown)

| Stage | Tool | Notes |
|---|---|---|
| Image generation host (recommended default) | **ChatGPT Plus** (~$20/mo flat) | Practically unlimited generations within rate limits, identity-preserving edits (drop in a character image, ask "make a 6-panel sheet of this person" — face stays intact), conversational refinement, real-photo inspiration uploads. Saves substantial Higgsfield credits for the entire image phase. Same banana-pro-director prompt grammar works here directly. |
| Character faces (Higgsfield path) | Soul Cinema (Soul Cast) | One ultra-prompt can handle face + base look in one shot. Regenerate freely — Soul is unlimited. Use as fallback when ChatGPT refuses content. |
| Outfits / fuses / merges (Higgsfield path) | Nano Banana Pro | Use for compositing a face ref + outfit ref. Heavier credit cost — prefer ChatGPT when possible. |
| Multi-angle sheet (Higgsfield path) | Banana Pro 6-panel | Fallback only. ChatGPT's identity-preserving edit is dramatically more reliable for this step — Banana Pro often drifts faces panel-to-panel and forces multiple rerolls. |
| Environments / props / creatures | ChatGPT (preferred) or Banana Pro Mode 3B (fallback) | Build as pure-environment plates first, then composite humans in later. Upload real-world inspiration photos when the location/prop exists in reality — ground-truth lock at zero generation credits. |
| Video generation | Seedance 2.0 | Auto-edit ON for multi-shot. OFF only when you need a sustained single take. |
| Video generation platform | Higgsfield (full features) **or** ArtCraft ([getartcraft.com](https://getartcraft.com/), hobby-tier) | ArtCraft Basic (~$10/mo) is the cheap default — same Seedance 2.0 model, ~63s of generation, no auto-edit / multi-cut. Push the user to Higgsfield Plus only when they need multi-cut bursts in a single generation. |
| Upscale | Topaz Video | Final pass. 720p → higher. |
| Music | Suno | Hand-written style prompt + lyric sheet. See `templates/suno-music-prompt.md`. |

## How to work in this folder

When the user opens this folder and asks for help:

1. **Figure out where they are in the pipeline** — character development, world building, shot list, prompt generation, post.
2. **Use the templates in `templates/`** to capture project state (character bibles, shot list, generation log). Fill them in as the project develops. Treat each new project as either using this folder directly or cloned into a sibling folder.
3. **For image and video prompts, the skills do the prompting** — the user runs those on claude.ai. If they paste a prompt back here, you can help refine, log it, and plan the next shot.
4. **For everything else (story flow, scene-by-scene mapping, music prompt, title card prompt, generation tracking, post pipeline), help directly** using the patterns in `WORKFLOW.md` and the templates.

### Pre-flight: load the context before asking for a scene prompt

The single biggest workflow unlock from the production debrief: **don't ask the skill for a scene cold.** Seed it first.

Before requesting any new scene prompt on claude.ai:

1. **Attach the actual reference images** — locked character sheet(s), environment plate(s), prop sheet(s) — to the claude.ai conversation. The skill reads images natively; pasting text descriptions alone leaves identity detail on the table.
2. **Paste the matching bible blocks** alongside the images — the locked-identity paragraph + the specific look needed for the shot, the environment paragraph, any prop entry.
3. **Paste the shot-list entry** for the shot you're about to prompt — including what it connects from and what it connects to.
4. **State the format explicitly:** multi-shot sequence (auto-edit ON, hard cuts between beats inside one prompt) *or* one sustained take (auto-edit OFF, single locked shot).
5. **Confirm runtime.** The runtime the skill quotes back is also your credit-cost preview — every second is spend. If a 15s ask comes back looking thinner than expected, push back before generating.

Once that context is in the conversation, the skill ("write me the stadium scene" / "write me Shot 12") returns a prompt an order of magnitude sharper than asking from scratch. The skill is a director — it works best when the director has the script bible in hand.

A clean starting message looks like: *"Attached: character sheet for [working name], environment plate for the loft, prop sheet for the arcade. Bibles pasted below. Write me Shot 04 — 12 seconds, multi-shot sequence with two hard cuts."* — then paste the bibles + shot-list entry under the message.

## Real-world references > AI-generated, when available

**If your subject exists in the real world, use real photos as your reference assets rather than generating new ones.** This is a high-leverage workflow pattern that saves credits, locks identity tighter, and produces sharper downstream results.

### When real-world references win

- **Real vehicles** (E39 M5, Porsche 911 SC, Jaguar XKE, etc.) — manufacturer press photos, owner photos from forums/Bring a Trailer, real auction listings
- **Real architecture** (a specific building style, an iconic interior, a historical location) — stock photography, your own photos, location scout shots
- **Real watches, jewelry, branded objects you want to evoke** (described brand-neutrally in prompts) — manufacturer product photography
- **Real fashion/wardrobe** (a specific tux cut, a particular leather jacket) — editorial shoots, brand lookbooks, your own photos
- **Real environments you've actually been to** — your own photos beat anything AI can imagine

### Why this works

- **Tighter identity lock.** AI references are interpretations; real photos are ground truth. Seedance reading a real photo of an E39 M5 cockpit will preserve fine details (M-tri-color stitching, H-pattern shift gate, specific gauge cluster numerals) that are hard to prompt accurately and hard for an image AI to nail without multiple iterations.
- **Zero credits.** Real photos cost nothing. AI-generated reference plates cost credits per attempt.
- **Faster workflow.** Five minutes assembling a real-photo reference grid beats 20–40 minutes iterating on AI-generated plates that may still drift on key details.
- **Better fine-detail catches by `video-qa`.** The QC skill compares generated clips against locked references. Real-photo references give QC a higher-fidelity baseline to catch wrong-generation slips (e.g. the E39/E46 taillight case the source production hit).

### How to use them in the pipeline

Drop real-world reference photos into the project's `references/` folder using the same naming conventions as AI-generated plates. The skills treat them as first-class anchors — no special handling required:

- `references/characters/<name>/sheet.png` — could be an AI-generated 6-panel OR a multi-panel grid built from real photos of a real person (with their permission) or a stylized character composite
- `references/props/<prop-name>/sheet.png` — for the M5 specifically in the source production, this was a 6-panel grid built from real BMW press photos and detail shots
- `references/props/<prop-name>/cockpit.png` etc. — same pattern for interior detail sheets, dashboard macros, signature element close-ups
- `references/environments/<location-name>/wide.png` — could be an AI plate OR a real photograph of an actual location

For **multi-panel reference grids built from real photos**, the same rule applies as for AI-generated grids: **individual high-resolution images often work better than a tiled grid** (covered in the panel grid vs. individual images guidance in this doc and in the QC skill). Real photos at full resolution let Seedance pick the relevant detail per shot.

### When AI generation IS the right choice

- **Original characters** — your specific creative person who doesn't exist in the real world. Soul Cinema ultra-prompt is the right tool here.
- **Fictional or stylized environments** — alien planets, cyberpunk corridors, near-future versions of real cities, anything in the world you're inventing for the film
- **Hero props that don't exist** — the alien creature, the bespoke prop, the imagined vehicle
- **When real photos don't match your specific creative vision** — e.g. a real M5 photographed in studio lighting, but you want it in a cinematic editorial register that no real photo captures

The Phase 0 character development flow in `banana-pro-director` is for the "develop from scratch" case. The "reference exists" path is exactly for the real-photo-as-reference pattern — that's a feature, not a workaround.

### One caveat — brand / IP visibility

Real photos often include readable brand marks, license plates, copyrighted designs. These will propagate into your generated clips. For personal/test projects this is usually fine; for **public release or client work**, plan to mask/blur in post or pick references that don't carry the brand mark prominently. The same caveat applies to AI-generated outputs that inherit brand marks from real-photo references — covered in the brand/IP/naming category of `video-qa`'s QC checks.

---

## Iron rules carried from the skills

> **Source of truth:** the two specialist skills (`banana-pro-director` and `cinema-worldbuilder`) are the canonical source for these rules. The summary below is a workspace-level mirror for quick reference — if the specialists update and this section disagrees, the specialists win. When in doubt, defer to the specialist `SKILL.md` files at the repo root.

These apply anywhere a prompt is composed in this workspace, even when the skills aren't active:

- **No proper names** in any prompt going to Higgsfield. Describe by visual markers (hair color, outfit, identity markers).
- **No real brand names** — "three-stripe athletic sneakers," not the brand. Internal chat is fine; prompt body is brand-neutral.
- **Age-blind** — no "young," "teen," "middle-aged." Describe by build, role, and clothing.
- **Every prompt is standalone.** Higgsfield has no memory between generations. Re-state the world every time.
- **Photoreal default.** Real skin texture, individual hair strands, fabric weave, film emulation. The skill files have the canonical block.
- **No music language in Seedance prompts.** Only diegetic audio in the video prompt itself. Music is layered later from Suno.
- **No aspect ratios written into prompts.** The user sets aspect in the Higgsfield UI.

## What lives where

```
.
├── README.md                  — public-facing repo page
├── LICENSE                    — MIT, with attribution to Joey
├── CLAUDE.md                  — this file (workspace entry doc)
├── WORKFLOW.md                — the full pipeline, step by step
├── banana-pro-director/       — Joey's image-prompt skill (zip + upload)
│   └── SKILL.md
├── cinema-worldbuilder/       — Joey's Seedance video-prompt skill (zip + upload)
│   └── SKILL.md
├── ai-film-director/          — orchestrator skill (zip + upload)
│   └── SKILL.md
├── video-qa/                  — QC skill (zip + upload)
│   └── SKILL.md
├── templates/                 — empty templates (copied per project)
│   ├── character-bible.md
│   ├── environment-bible.md
│   ├── prop-bible.md
│   ├── shot-list.md
│   ├── generation-log.md
│   ├── suno-music-prompt.md
│   └── title-card-prompt.md
├── scripts/
│   └── new-project.sh         — scaffold a new project workspace
└── projects/                  — one folder per project (gitignored — your workspaces)
    ├── bmw-m5-spot/
    │   ├── README.md
    │   ├── character-bible-driver.md
    │   ├── environment-bible-venue.md
    │   ├── shot-list.md
    │   ├── generation-log.md
    │   ├── references/{characters,environments,props,titles}/
    │   ├── clips/
    │   ├── audio/
    │   ├── prompts/
    │   └── qc-reports/
    └── <your-next-project>/
        └── ...
```

## Multi-project workspace convention

**Each project lives in its own subfolder under `projects/`.** This keeps multiple film projects isolated so their bibles, references, clips, and QC reports don't collide.

### Starting a new project

**Claude Code (CLI):** the orchestrator can run the scaffold script itself. Just tell it the project name when it asks.

**Manually (any environment):** run the bundled scaffold script —
```bash
./scripts/new-project.sh <project-name>
```
…where `<project-name>` is lowercase-with-hyphens (e.g. `bmw-m5-spot`, `kpop-music-video`, `perfume-brand-30s`). The script creates `projects/<project-name>/` with all the standard templates copied in, a per-project README stubbed, and the right subfolders (`references/`, `clips/`, `audio/`, `qc-reports/`, `prompts/`) pre-created.

**On claude.ai (no shell access):** the agent can't run the script for you. Create the folder structure manually following the layout above, or run the script once on a desktop machine and sync the result via cloud storage.

### Where the orchestrator works

Once a project folder exists, the producer opens that folder (in Claude Code) or just references it conversationally (on claude.ai). All the skills' relative paths (`references/characters/<name>/sheet.png`, `clips/shot_NN_v01.mp4`, etc.) work relative to the project root — same conventions as before, just rooted in `projects/<project-name>/` instead of the repo root.

### Gitignore

`projects/` is **gitignored entirely** by default. Project content is personal — bibles, locked references, generated clips, QC reports — none of it gets committed to the public repo. If you ever want to share a project as an example, force-add it (`git add -f projects/<name>/...`).

**To use the skills, zip each of the four skill folders and upload to claude.ai (Settings → Capabilities → Skills → +).** Each zip must contain a folder named after the skill (e.g. `ai-film-director/`) with `SKILL.md` directly inside it. By platform:

- **macOS Finder:** right-click `ai-film-director/` → Compress. Produces `ai-film-director.zip`. Repeat for `video-qa/`.
- **macOS / Linux Terminal:** `cd` into this workspace and run `zip -r ai-film-director.zip ai-film-director/` and `zip -r video-qa.zip video-qa/`.
- **Windows File Explorer:** right-click the folder → Send to → Compressed (zipped) folder. Verify the resulting `.zip` contains the folder (not just `SKILL.md` at the root) — Windows occasionally flattens.
- **Windows PowerShell:** `Compress-Archive -Path ai-film-director -DestinationPath ai-film-director.zip` and the same for video-qa.
- **iPad / browser-only:** use Files app's "Compress" option on each folder. If working from a synced cloud drive, ensure sync completed before zipping. If the workspace lives only in claude.ai chat scratch space, paste each `SKILL.md` into a desktop machine first — claude.ai's Skills uploader needs a real `.zip` from your filesystem.

Upload both zips to claude.ai the same way as the original two.

When starting a new project: copy the relevant templates into a project-named subfolder, fill them in. On claude.ai, say "I want to make an AI video for X" — `ai-film-director` activates and leads you through. After any major batch of generations, say "QA the project" — `video-qa` audits.
