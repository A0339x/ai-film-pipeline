# The Pipeline

Derived directly from the K-Pop CTRL: Hunters breakdown. This is the order that wastes the fewest credits.

## Phase 0 — Concept lock (before any generation)

Write down, in plain language, what the film is. One paragraph. Then expand it into:

- **Who** — recurring characters, named in your notes (never in prompts). For each one, how many distinct looks they'll need across the film.
- **Where** — every distinct environment. Day or night. Interior or exterior. Establishing wide or anchored medium.
- **What** — hero props and creatures. Anything the camera lingers on.
- **Why** — one-sentence emotional throughline. The reason a viewer cares.
- **How long** — total target runtime. Most AI shorts live in the 30s–2min band.

Drop these in `templates/shot-list.md` under the Concept section.

## Phase 1 — Character builds (the part that breaks most projects)

For each recurring character:

1. **Develop or upload reference.** Either describe them to the `banana-pro-director` skill (Step 0 free-form character development), or upload an existing image and have the skill mirror back a locked spec. Iterate until the user confirms.

2. **Build the base look in Soul Cinema with one ultra-prompt.** Face + base outfit in a single generation, white seamless backdrop. Regenerate until the face *is* the character. Soul Cinema is unlimited — use it. The K-Pop project ran 10–20 generations per member at this stage.

3. **Lock the character sheet (Banana Pro 6-panel).** Once one base image truly reads as the character, run a 6-panel multi-angle sheet against it. This is the canonical reference everything downstream pulls from.

4. **Build the other looks.** Use the character sheet as Reference Image 1, design the new outfit as a separate Soul Cinema generation on a neutral model (Mode 1B), then composite. Common pattern from the breakdown: four looks per character —
   - Base identity (loungewear / personal style)
   - Battle suit / hero suit, helmet on
   - Battle suit, helmet off
   - Performance / stadium look (often with a distinct hairstyle)

5. **Log each locked look in `templates/character-bible.md`.** One bible per character. Reference images saved next to the bible.

## Phase 2 — World builds

For each environment from Phase 0:

1. **Build the pure environment plate first** (Banana Pro Mode 3B / Atmospheric M5). No humans. Establishing wide. This gives you the world.

2. **Iterate on second-angle plates** of the same space if the film needs them. The breakdown notes Higgsfield can be stubborn about flipping POV on an existing plate — expect trial and error here.

3. **Log each environment in `templates/environment-bible.md`** with the prompt that produced it and the reference image filename.

For creatures and hero props (alien creatures, arcade machines, vehicles, weapons):

4. **Build a creature/prop reference sheet** (6-panel against white seamless, product-render lighting).
5. **Log in `templates/prop-bible.md`.**

## Phase 3 — Story flow lock

Before generating a single video shot:

1. **Map the film beat by beat in `templates/shot-list.md`.** Every cut. Every transition. Every payoff.
2. **For each shot, write down what the viewer sees and what they hear.** If a character looks off-frame, what's she looking at? The next shot has to deliver it.
3. **Mark which cinema mode (M1–M5) each shot uses.** This locks camera grammar.
4. **Mark which characters and which look** appears in each shot.
5. **Decide auto-edit per shot.** Multi-shot sequences in one prompt = auto-edit ON. Sustained single takes = OFF.

This phase is what separates a film from "the sickest poster of all time." The HTML breakdown is emphatic: shots that don't follow from the shot before are wasted.

## Phase 4 — Seedance generation

For each shot in the shot list:

1. **Feed the scene + references into `cinema-worldbuilder`** on claude.ai. Confirm runtime explicitly. Confirm the 5-line pre-prompt summary.
2. **Paste the prompt into Seedance.** Attach the same reference images in the Higgsfield UI.
3. **Generate. Review.** If it lands, log it in `templates/generation-log.md` with the prompt, references used, and the result filename.
4. **If it misses, iterate.** Small adjustments don't need a full re-prompt — the skill skips the pre-prompt check on minor iterations.

Tips that save credits:
- Let Seedance handle multi-shot cuts. The model is good at edits.
- Don't waste credits on shots whose narrative role you haven't confirmed.
- 11–15 seconds is the sweet spot per generation. Longer often degrades.

## Phase 5 — Audio (Suno) and title card

1. **Music via Suno.** Use `templates/suno-music-prompt.md` for a style prompt and a lyric sheet. Two generations is usually enough. Upload the chosen track into Higgsfield in 12–15s slices so Seedance can sync lip movement.

2. **Title card via Banana Pro.** Use `templates/title-card-prompt.md` — product-render letterform grammar from the breakdown.

## Phase 6 — Post

1. **Topaz Video** to upscale every clip to delivery resolution.
2. **Edit the assembly.** A real NLE (DaVinci Resolve, Premiere, FCP). AI generations are clips, not the cut.
3. **Layer music + dialogue + diegetic sound effects.** Seedance produces diegetic audio natively — keep what's useful, mute what isn't, layer Suno on top.
4. **Color pass if needed.** Most clips are already graded; the assembly may need balancing.

## Credit discipline (from the breakdown)

The K-Pop project burned ~7,500 credits, half wasted, across 133 video generations averaging 11s each. The author estimates it could have been done in ~3,000 with the workflow they wrote *after* the project. The biggest credit sinks were:

- Fighting Seedance instead of feeding it the right prompt grammar → the skills fix this.
- Generating before the shot list was locked → Phase 3 fixes this.
- Regenerating characters that weren't fully locked → Phase 1 fixes this.

Every generation should answer: *which shot in the shot list is this for, and which look from the character bible.* If you can't answer both, stop and lock that first.
