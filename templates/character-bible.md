# Character Bible — [Working Name]

> **Working name is for your notes only.** It never appears in any prompt sent to Higgsfield. Prompts describe by visual marker.

## Locked identity (never changes)

- **Visual descriptor (use this verbatim in prompts — age-blind, no proper names, no real brands):**
  - e.g. "a woman with a slim athletic build, flawless porcelain skin, soft symmetrical features, large expressive almond-shaped eyes, full lips"
  - **Do not use:** age words (young / teen / middle-aged / older), proper names, brand names. Describe by build, role, and clothing instead.
- **Hair (canonical / default):** color (every nuance — platinum, jet black, rose-pink, etc.), length, texture, parting, signature styling
- **Eyes:** color, shape, brow shape and density
- **Skin:** finish (matte, dewy, glass-skin, bare), tone, any beauty marks visible in references
- **Build & proportions:**
- **Distinguishing markers:** piercings, tattoos, freckles — only if locked into the character
- **Default expression / energy:**

## Locked character sheet reference

> **Why this can't be skipped:** without a locked sheet, the character drifts by Shot 3. Every regeneration trying to recover the face costs credits the shot list can't afford.

- **File:** `references/characters/<working-name>/sheet.png`
- **Prompt used (from banana-pro-director Mode 2):**
  ```
  [paste the 6-panel prompt here once it's locked]
  ```

### 6-panel layout — record which panels you locked

`banana-pro-director` Mode 2 ships a default panel layout (full-body front · 3/4 turn · back · waist-up · hands · face) and supports any panel swap the producer requests — "profile side, torso close-up, boot detail, back of head with hair clip," whatever the project needs to lock. Same 3×2 grid, single-prompt format.

When you generate the sheet, describe your panel pick to banana-pro-director in plain language. Don't worry about named canonical mixes — there aren't any.

- **Panels locked for this character:** [list the six panels actually generated, e.g. "front · 3/4 turn · side profile · hands close-up · face straight · face 3-quarter"]
- **Reason for the panel pick (if non-default):** [e.g. "front-and-hands carry the read in this film; back view isn't needed"]

---

## Look 1 — [Base identity / loungewear]

- **What it is:** her personal style off-duty.
- **Wardrobe (head to toe):** every garment, fabric, fit, color, accessory, footwear.
- **Hair (if different from canonical):**
- **Jewelry & accessories:**
- **Reference image:** `references/characters/<working-name>/base.png`
- **Prompt used:**
  ```
  [paste the locked prompt]
  ```

## Look 2 — [Hero / battle / signature suit, fully closed]

- **Wardrobe / armor description:**
- **Helmet / face cover state:** on, sealed, no glass visor
- **Reference image:** `references/characters/<working-name>/look_suit_closed.png`
- **Prompt used:**
  ```
  [paste]
  ```

## Look 3 — [Same suit, helmet retracted / face revealed]

- **Wardrobe:** same as Look 2.
- **Helmet state:** retracted into suit collar
- **Hair revealed:** [should match canonical hair from identity block]
- **Reference image:** `references/characters/<working-name>/look_suit_open.png`
- **Prompt used:**
  ```
  [paste]
  ```

## Look 4 — [Performance / stadium look]

- **Wardrobe:**
- **Hair (often distinct for performance — high pony, pigtails, etc.):**
- **Performance props:** microphone, in-ear monitor, wireless pack
- **Reference image:** `references/characters/<working-name>/look_perf.png`
- **Prompt used:**
  ```
  [paste]
  ```

## Add more looks as needed

For each additional look (festival, press, casual, sleepwear, etc.), copy a block. Keep canonical identity locked; only the look changes.

---

## Cross-reference

- **Shots this character appears in:** see `shot-list.md` for filter by character.
- **Other characters seen with:** [list working names of groupmates / co-stars]
- **Voice / dialogue notes:** [tonal register — dry, flat, warm, sharp; never written into prompts but useful for dialogue lines inside Static Description]
