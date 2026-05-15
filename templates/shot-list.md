# Shot List — [Project Title]

> The film, mapped beat by beat, before a single Seedance credit is spent. Every shot connects to the one before and the one after. If a shot doesn't follow, it's a poster, not a film.

## Concept

- **Logline (one sentence):**
- **Total target runtime:**
- **Emotional throughline (one sentence):**
- **Music role:** scored by Suno track / diegetic only / silent
- **Anchor moments / payoffs:** the 2–4 beats the whole film is built around — set time codes if known
- **Color grade palette (optional):** 4–6 swatch hex palette + plain-English captions if locked at Phase 0.5, e.g. `["#1a2832", "#4a5b6c", "#d8c8a0", "#e89a5e"]` (deep teal shadow, cool steel midtone, warm dusty highlight, sunset accent). Skip this line if no palette was locked — each cinema mode uses its default grade.

## Cast index

| Working name | Bible file | Looks needed |
|---|---|---|
| [name] | `character-bible-[name].md` | Look 1, Look 2, Look 4 |

## Location index

| Location | Bible file | Cinema mode |
|---|---|---|
| [name] | `environment-bible-[loc].md` | M1 / M5 |

## Prop / creature index

| Asset | Bible file |
|---|---|
| [name] | `prop-bible.md#entry-[name]` |

---

## Shots

Format per shot. Copy the block for each.

Fields below are split into **core** (fill these for every shot — they're what makes the shot list useful) and **optional** (fill only when relevant; skip when not). The shot list is a working artifact, not a contract — don't drag your feet logging an optional field that doesn't apply.

### Shot 01 — [one-line beat description]

**Core (fill for every shot):**

- **Runtime:** Xs
- **Cinema mode:** M1 Narrative / M2 Studio / M3 Action / M4 Performance / M5 Atmospheric
- **Auto-edit:** ON (multi-cut sequence) / OFF (single sustained take)
- **In-frame characters & looks:** [working name → look key]; [working name → look key]
- **Location:** [from location index]
- **References to attach in Higgsfield:** [list filenames]
- **What the viewer sees:** [the action arc across the duration]
- **Connects from Shot ##:** [what the previous shot ended on that this opens against]
- **Connects to Shot ##:** [what this shot ends on that the next opens against]
- **Status:** planned / prompted / generated / locked / cut

**Optional (fill when relevant, skip when not):**

- **Hero props:** [from prop index, if any]
- **What the viewer hears:** [diegetic only — footsteps, fabric, dialogue line if any, room tone, weather; cinema-worldbuilder writes this from the action description if you skip it]
- **What this shot delivers / why it's here:** [setup, payoff, transition, beat — useful for your own pacing scan]
- **Lens length:** 32mm / 50mm / 55mm / 75mm / 100mm *(cinema-worldbuilder picks a sensible default per mode if you don't specify)*
- **Aspect ratio (set in Higgsfield UI, not in prompt):** 16:9 / 21:9 / 2.39:1 / 9:16 / 1:1 / 4:5
- **Mode stack (only if intentional):** e.g. *"M4 environment + M3 camera grammar"* — cinema-worldbuilder writes a separate camera block per stack component. Skip for single-mode shots.
- **State transition (only if the shot has one):** e.g. *"helmet on (0–3s) → helmet retracts (3–5s) → helmet off (5–end)"*, *"hair-down → hair-up"*, *"clean → bloodied"*, *"day → dusk crossfade"*. Skip if the shot is state-stable.
- **Result file:** `clips/shot_<##>_v01.mp4` *(increment `_v02`, `_v03` on iterations; never overwrite)*
- **Generation log entry:** `generation-log.md#shot-<##>`

### Shot 02 — [...]

[copy block]

---

## Cut sheet (rough order)

A compressed list once everything is mapped — title + runtime per shot in delivery order. Easy to scan for pacing.

| # | Title | Runtime | Mode | Status |
|---|---|---|---|---|
| 01 | [shot title] | 8s | M3 | planned |
| 02 | [...] | 12s | M3 | planned |
| 03 | [...] | 6s | M1 | planned |

**Total mapped runtime:** Xs
