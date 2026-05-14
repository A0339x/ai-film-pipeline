# AI Film Pipeline — claude.ai skills for high-end AI video production in Higgsfield

End-to-end claude.ai skill set for making cinema-grade AI videos in Higgsfield without burning credits on shots that drift. Four skills work together: two specialists that write the prompts, one orchestrator that leads you through the whole project, and one QC supervisor that catches drift before it ships.

Built on top of two original skills by **Joey** (the creator of the AI-built K-Pop short film [*CTRL: Hunters*](https://youtu.be/sVib0X-PvsY)) — extended with a guided orchestrator + QC layer to walk first-time users through the workflow.

---

## Scope — what this is and what it isn't

**This is the pre-production and asset-generation pipeline.** It gets you everything you need to assemble a finished film: locked character sheets, environment plates, hero prop sheets, Seedance video clips, an original Suno music track, a title card, and a full shot list and generation log to organize it all.

**This is NOT a video editor.** The skills don't cut, color, conform, master, or assemble. Once you have your clips, music, and title card, you take them into a real NLE (DaVinci Resolve, Premiere, Final Cut, etc.) and edit the film yourself. The pipeline ends at "you have all the parts" — the assembly is on you.

Think of it as the difference between a production crew and a post-production editor: this skill set is the crew that shoots and delivers the dailies. The cut is still your job.

## What this gives you

A complete operating system for the *creation* side of AI video projects in Higgsfield:

- **Character consistency across hundreds of generations.** Lock a character once, reuse forever. The skills enforce naming discipline, locked photoreal stacks, and 6-panel reference sheets that keep faces from drifting by Shot 3.
- **Cinema-grade camera grammar.** Five locked cinema modes (Narrative / Studio / Action / Performance / Atmospheric), each with its own ARRI body, lens stack, filtration, and Kodak film emulation grade. Prompts come out looking like they were shot, not rendered.
- **Credit savings by design.** Pitfall flags fire before you generate shots that won't earn — character not locked, runtime overshoot past Seedance's 15s reliability window, mode mismatch, music language leaking into video prompts, brand contamination. The source production team burned ~7,500 credits on their first project; their post-mortem said they could have done it in 3,000 with this workflow in hand.
- **Guided pipeline for first-timers, lean iterative loop for pros.** Two operating modes per skill, switchable mid-project. Newbies get walked through seven structured phases. Pros run a five-step iterative loop with just-in-time builds.
- **QC before ship.** A dedicated skill audits the project against locked bibles — eight scored categories in guided mode, three lean checks (drift / continuity / prompt audit) in pro mode. Pause-with-evidence, prescribed fix path, hand back to the right specialist to regenerate.

What you get out at the end: a folder of locked references, a folder of generated clips, a music track, a title card image, and the bibles + shot list + generation log that document how the project was built. You bring that bundle into your NLE of choice and cut the film.

---

## The four skills

| Skill | Role | Owns |
|---|---|---|
| **`banana-pro-director`** | Image prompts | Character outfits on white seamless (Banana Pro or Soul Cinema), 6-panel character sheets, scene plates, GPT-2 detail face shots. Enforces the locked photoreal stack. |
| **`cinema-worldbuilder`** | Seedance video prompts | Five cinema modes with locked camera/lens/filtration/grade, per-shot runtime, diegetic audio rule, multi-shot per-shot timing. Single-paragraph output with inline Style & Mood / Dynamic / Static labels. |
| **`ai-film-director`** | Pipeline orchestrator | Leads users from a one-line intention through every phase of the project. Calls the two specialists at the right moments. Pauses for Higgsfield generation. Protects against credit-burning pitfalls. Two modes: guided (seven phases) or pro (five-step loop). |
| **`video-qa`** | QC supervisor | Audits the project against locked character/environment/prop bibles. Pauses with evidence, prescribes fixes, hands back to specialists to regenerate. Two modes: guided (eight scored categories, Ship/Hold/Block verdict) or pro (drift + continuity + prompt scan, no score). |

---

## Install

All four skills run inside **claude.ai** (Settings → Capabilities → Skills → +). You upload them as `.zip` files; each zip must contain a folder named after the skill (e.g. `ai-film-director/`) with `SKILL.md` directly inside it.

### Zip each folder by platform

| Platform | Command / action |
|---|---|
| macOS Finder | Right-click each of the four folders → **Compress**. Produces `<skill>.zip`. |
| macOS / Linux Terminal | `zip -r ai-film-director.zip ai-film-director/` (repeat for the other three) |
| Windows File Explorer | Right-click → **Send to** → **Compressed (zipped) folder**. Verify the zip contains the folder (not just `SKILL.md` flattened). |
| Windows PowerShell | `Compress-Archive -Path ai-film-director -DestinationPath ai-film-director.zip` (repeat for the other three) |
| iPad / browser-only | Use the Files app's **Compress** option on each folder. Upload via claude.ai on a desktop browser. |

### Upload to claude.ai

1. Open [claude.ai](https://claude.ai) in a browser or the desktop app.
2. Go to **Settings → Capabilities → Skills**.
3. Click **+** and select **Upload skill**.
4. Drop each `.zip` in individually.
5. Skills auto-activate based on conversation context — no manual invocation needed.

You need all four installed for the orchestrator and QC to work properly. Without the specialists installed, handoffs degrade silently to generic Claude prompt-writing.

---

## Use

In a new claude.ai chat, say what you want to make:

> *"I want to make an AI music video"*
> *"Help me build a short film concept"*
> *"Make me a brand spot for [thing]"*

`ai-film-director` activates and asks two opening questions:

1. **Are the other three skills installed?** (If not, install them first — handoffs need them.)
2. **Pro mode or guided mode?** Guided walks first-timers through seven phases with structured gates. Pro runs a five-step iterative loop for users who know the workflow.

From there, the orchestrator leads. It will:

- Help you develop characters (or lock the ones you already have from reference images)
- Build environment plates and prop sheets as shots call for them
- Map your shot list beat-by-beat
- Call `cinema-worldbuilder` for every Seedance prompt with the right context loaded
- Pause for you to generate in Higgsfield with explicit "save to this path, return when locked" handoffs
- Warn before you torch credits on shots that aren't yet earnable

After generating a batch (or before final assembly), invoke `video-qa` to audit drift, continuity, and prompt-rule violations.

The workspace `templates/` folder gives you starting templates for character bibles, shot lists, generation logs, Suno music prompts, and title card briefs.

---

## Source attribution

The two specialist skills (`banana-pro-director` and `cinema-worldbuilder`) come from **Joey**, the creator of the AI-built K-pop short *CTRL: Hunters*. He published them free on his YouTube channel and Notion, in his own words:

> *"The pipeline is the actual product. The video is just a demo showcasing it being used. Take them, use them, modify them, build your own off of them. I don't care."*

His full project breakdown (the 133-generation, 7,500-credit post-mortem that produced the workflow patterns in this repo) lives in his [YouTube release video](https://youtu.be/sVib0X-PvsY) and the linked Notion playbook. Watch them — they're the source material.

The two added skills (`ai-film-director` and `video-qa`) and the workspace templates are derivative work built on top of Joey's pipeline, designed to walk first-time users through it without re-deriving the patterns from scratch.

---

## File structure

```
.
├── README.md                  — this file
├── LICENSE                    — MIT
├── CLAUDE.md                  — workspace entry doc for Claude
├── WORKFLOW.md                — the full pipeline narrative
├── banana-pro-director/       — Joey's image-prompt skill
│   └── SKILL.md
├── cinema-worldbuilder/       — Joey's Seedance video-prompt skill
│   └── SKILL.md
├── ai-film-director/          — orchestrator skill
│   └── SKILL.md
├── video-qa/                  — QC skill
│   └── SKILL.md
└── templates/
    ├── character-bible.md     — per-character spec
    ├── environment-bible.md   — per-location spec
    ├── prop-bible.md          — creatures, vehicles, hero props
    ├── shot-list.md           — beat-by-beat film map
    ├── generation-log.md      — what was generated, what worked
    ├── suno-music-prompt.md   — Suno music style + lyric template
    └── title-card-prompt.md   — Banana Pro title card brief
```

---

## License

MIT. See [LICENSE](LICENSE). The two specialist skills (`banana-pro-director`, `cinema-worldbuilder`) are Joey's original work, included here per his explicit "take them, use them, modify them" release. The added orchestrator and QC layer plus templates are derivative work licensed under the same terms.

---

## Production stack reference

For the curious — the tools the source production used and which this pipeline assumes:

| Stage | Tool |
|---|---|
| Character faces (unlimited rerolls) | Soul Cinema |
| Outfits / fuses / merges | Nano Banana Pro |
| Detail face / chest-up portraits | Higgsfield GPT-2 |
| Video generation | Seedance 2.0 |
| Music | Suno |
| Upscale | Topaz Video |
| Edit / assembly | Any NLE (DaVinci Resolve, Premiere, Final Cut) |

If Higgsfield ships UI changes or new model variants, the skills are written to flex around them as long as the underlying model behavior is intact.
