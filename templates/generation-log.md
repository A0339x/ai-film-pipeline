# Generation Log

A running log of every Higgsfield generation. Catches what worked, what didn't, and where the credits went. Cuts the wasted half of the budget.

## Running totals

- **Total generations attempted:**
- **Total kept:**
- **Total wasted:**
- **Approx credits burned:**

---

## Image generations (Banana Pro / Soul Cinema / GPT-2)

The log has two columns sets — **core** (fill every row) and **optional** (fill when it matters or when you're debugging Higgsfield platform behavior). Don't drag your feet logging optional columns; the core is what actually catches wasted credits.

**Core columns (fill every row):**

| # | Date | Tool | Purpose | Refs | Credits | Result file | Kept? | Notes |
|---|---|---|---|---|---|---|---|---|
| 1 | YYYY-MM-DD | Soul Cinema | Char A base | none | 0 | `references/characters/char_a/base_v01.png` | no | hair too short |
| 2 | YYYY-MM-DD | Soul Cinema | Char A base | none | 0 | `references/characters/char_a/base.png` | yes | locked |
| 3 | YYYY-MM-DD | Banana Pro | Char A 6-panel | `.../base.png` | ~15 | `references/characters/char_a/sheet.png` | yes | canonical |

**Optional columns to add when relevant** (extend the table with these as needed):

- **Model version** — when Higgsfield ships an update. Note which variant (Nano Banana Pro vs. Soul Cinema vs. GPT-2, with version if shown) so a future regeneration that looks different can be diagnosed.
- **Higgsfield asset IDs** — if you attached references via the Higgsfield asset library rather than fresh uploads each time.
- **Aspect ratio** — useful when you're testing the same generation across multiple aspects.
- **UI settings** (style, strength, seed) — useful for reproducing a specific result.

For each kept image, store the prompt under the asset bible (`character-bible.md`, `environment-bible.md`, `prop-bible.md`). The log is the index.

---

## Video generations (Seedance)

### Shot 01 — [shot title]

- **Attempt 1**

  **Core (fill every attempt):**
  - Date:
  - Prompt (from `cinema-worldbuilder`): code block or `prompts/shot_01_v01.txt`
  - References attached:
  - Credit cost:
  - Result file: `clips/shot_01_v01.mp4`
  - Kept? yes / no
  - Why / why not:

  **Optional (fill when debugging or reproducing):**
  - Tool + model version (if not the default Seedance):
  - Aspect ratio set in UI:
  - Resolution: 720p / 1080p
  - Runtime requested vs. actual:
  - Auto-edit: ON / OFF
  - Seed / control values if set:
  - Higgsfield asset IDs (if refs came from the asset library):

- **Attempt 2** (if needed) — same shape, lighter:
  - What changed from attempt 1:
  - Credit cost:
  - Result file: `clips/shot_01_v02.mp4`
  - Kept? yes / no
  - Why:

> Iteration discipline: if you can't articulate *what changed and why*, you're burning credits. Keep every version — never overwrite `_v01`. Future you and `video-qa` need the diff trail.

### Shot 02 — [...]

[copy block]

---

## Music generations (Suno)

| # | Date | Style prompt file | Lyric file | Result | Kept? | Notes |
|---|---|---|---|---|---|---|
| 1 | | `prompts/track_v01_style.md` | `prompts/track_v01_lyrics.md` | track_v01.mp3 | yes/no | |

---

## Lessons file

Bullet points only. What you learn the hard way. Examples:

- POV flip inside the same loft took 3 attempts and a transform-flip in post — budget extra credits when inventing reverse angles.
- 12s is the Seedance sweet spot for lip-sync to a Suno bar — 15s started to drift.
- Soul Cinema occasionally adds jewelry that wasn't prompted — call it out explicitly *or* explicitly state "no jewelry."
- [your observations here]
