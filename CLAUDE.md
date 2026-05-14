# AI Video Making — Workspace Guide for Claude

This folder is a Higgsfield-first AI video production workspace. When the user opens this folder, they are starting (or continuing) a high-end AI video project — character builds, scene plates, Seedance video shots, optional music + title card, final upscale.

## The four skills

Four skill folders live at the root of this repo. Each folder needs to be zipped and uploaded to **claude.ai** (Settings → Capabilities → Skills → +) before any of them activate. See the README's "Install" section for platform-specific zip instructions.

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
| Character faces | Soul Cinema (Soul Cast) | One ultra-prompt can handle face + base look in one shot. Regenerate freely — Soul is unlimited. |
| Outfits / fuses / merges | Nano Banana Pro | Use for compositing a face ref + outfit ref. Heavier credit cost. |
| Multi-angle sheet | Banana Pro 6-panel | Lock the character once a base looks right. |
| Environments / props / creatures | Banana Pro (Mode 3B) | Build as pure-environment plates first, then composite humans in later. |
| Video generation | Seedance 2.0 | Auto-edit ON for multi-shot. OFF only when you need a sustained single take. |
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
└── templates/
    ├── character-bible.md     — per-character spec
    ├── environment-bible.md   — per-location spec
    ├── prop-bible.md          — creatures, vehicles, hero props
    ├── shot-list.md           — beat-by-beat film map
    ├── generation-log.md      — what was generated, what worked
    ├── suno-music-prompt.md   — Suno style + lyric template
    └── title-card-prompt.md   — Banana Pro title card brief
```

**To use the skills, zip each of the four skill folders and upload to claude.ai (Settings → Capabilities → Skills → +).** Each zip must contain a folder named after the skill (e.g. `ai-film-director/`) with `SKILL.md` directly inside it. By platform:

- **macOS Finder:** right-click `ai-film-director/` → Compress. Produces `ai-film-director.zip`. Repeat for `video-qa/`.
- **macOS / Linux Terminal:** `cd` into this workspace and run `zip -r ai-film-director.zip ai-film-director/` and `zip -r video-qa.zip video-qa/`.
- **Windows File Explorer:** right-click the folder → Send to → Compressed (zipped) folder. Verify the resulting `.zip` contains the folder (not just `SKILL.md` at the root) — Windows occasionally flattens.
- **Windows PowerShell:** `Compress-Archive -Path ai-film-director -DestinationPath ai-film-director.zip` and the same for video-qa.
- **iPad / browser-only:** use Files app's "Compress" option on each folder. If working from a synced cloud drive, ensure sync completed before zipping. If the workspace lives only in claude.ai chat scratch space, paste each `SKILL.md` into a desktop machine first — claude.ai's Skills uploader needs a real `.zip` from your filesystem.

Upload both zips to claude.ai the same way as the original two.

When starting a new project: copy the relevant templates into a project-named subfolder, fill them in. On claude.ai, say "I want to make an AI video for X" — `ai-film-director` activates and leads you through. After any major batch of generations, say "QA the project" — `video-qa` audits.
