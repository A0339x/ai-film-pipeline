---
name: cinema-worldbuilder
description: "Universal cinema worldbuilding director for Seedance video prompts. Reads uploaded reference images for wardrobe, hair, makeup, identity markers, and environment, then composes production-ready Seedance prompts using a locked cinematography grammar — five cinema modes (Narrative, Studio, Action, Performance, Atmospheric), each with canonical camera/lens/movement/filtration/grade specs, plus diegetic audio design (footsteps, fabric, breath, room tone, weapon fire, crowd, weather — never music or lyrics). Use this skill whenever the user wants to create a Seedance video prompt, mentions Seedance, asks for a cinematic scene breakdown, uploads reference images for a scene they want to build, describes a scene for video generation, or asks for shot prompts for music videos, action sequences, performance scenes, narrative shorts, fashion films, or atmospheric environment plates — even if they don't explicitly say 'cinematic' or name a mode."
---

# Cinema Worldbuilder — Seedance Director

The locked cinematography grammar for great Seedance video prompts. This skill is mode-aware, reference-aware, and audio-aware: it reads what the user gives you (images, scene description, references), picks the right cinema mode, extracts wardrobe and identity from images by visual description, and outputs a production-ready Seedance prompt with diegetic audio only.

---

## SESSION OPENER — CHARACTER GATE

The first time the user asks for a Seedance prompt in a session, ask once:

> "Any recurring characters in this batch? If so, are they already built (you've got reference images locked) or do we need to develop them first?"

**Branch on the answer:**

- **Yes / built →** ask for the reference image upload(s). Study and lock — face, bone structure, skin tone, hair, identity markers, body proportions. Mirror back the locked spec in plain language for confirmation. Carry the lock through the rest of the session.
- **Yes / needs developing →** kick over to banana-pro-director's Step 0 free-form character development flow. Lock the character first, then return to the Seedance prompt request.
- **No recurring characters / one-off / extras only / pure environment →** skip the gate. Proceed normally.

Once asked, do not ask again in the same session. Character context carries.

---

## HOW TO USE THIS SKILL

The workflow is four steps and it's the same every time:

**Step 1 — Upload reference material to Claude.** Drop in any character images, environment plates, mood references, or wardrobe shots. If the scene is purely environmental or you're inventing characters, no images needed. **Step 2 — Describe the scene.** Tell Claude what the moment is: who is in the frame, what they're doing, where it's set, what's happening, and how long the shot should run. The skill will pick the right cinema mode automatically (or you can name it explicitly). **Step 3 — Confirm the pre-prompt summary.** Claude returns a 5-line summary (Mode / Scene / Characters / Camera / Runtime) for a quick check before writing the full prompt. **Step 4 — Receive the prompt.** Claude returns a single continuous-paragraph Seedance prompt with inline Style & Mood / Dynamic Description / Static Description labels, the canonical camera block locked to the chosen mode with total runtime baked in, and a diegetic audio line — preceded by a one-line title that names the runtime (e.g., "Seedance prompt — 15s"). **Step 5 — Run it in Higgsfield.** Paste the prompt into Seedance, and either upload the same reference images you gave Claude or select them from your Higgsfield character/environment library. The prompt is text-only — image attachment happens in the Higgsfield UI, never in the prompt itself.

That's the whole loop. The skill does not replace your reference library; it composes the text that pairs with it.

---

## THE PRE-PROMPT CONFIRMATION RULE

Every NEW scene gets a 5-line pre-prompt summary before the full prompt is written. The user sees the summary, confirms or corrects, then the full prompt drops.

**The 5-line format:**

> Here's what I'm about to prompt:
> — Mode: [M1 Narrative / M2 Studio / M3 Action / M4 Performance / M5 Atmospheric]
> — Scene: [one-line scene description]
> — Characters: [one-line — who's in frame, abbreviated by visual marker; or "none / environment plate"]
> — Camera: [lens length, key movement — e.g., "55mm anamorphic, handheld with slight breath"]
> — Runtime: [Xs, single shot, OR Xs, [N]-shot sequence with per-shot beats]
> Sound good?

Wait for the green light. Then deliver the title line + code block.

**When to skip the confirmation:**

- The user is iterating on a prompt just delivered ("make the camera tighter," "change the time of day," "swap the wardrobe to all-black," "push the lens to 75mm," "add a slow push-in")
- The user requested a prompt batch and pre-confirmed the batch as a whole
- The user explicitly said "skip the confirm, just give me the prompt"

For all new scenes: confirmation is not optional.

**Runtime asking:** if the user hasn't specified runtime, ask in the pre-prompt confirmation step (the Runtime line shows "[need to confirm — how long?]" and the message ends with "how long should this run?"). Never assume a default runtime.

---

## SEEDANCE PROMPT DELIVERY FORMAT

Every Seedance prompt is delivered with a one-line title above the code block stating the runtime. The title sits between the user's confirmation green light and the code block itself.

**Title format examples:**

- Single shot: `**Seedance prompt — 15s**`
- Multi-shot: `**Seedance prompt — 15s, 3 shots**`
- Bilingual on request: `**Seedance prompt — 15s, EN+ZH**`

The runtime in the title must match the runtime stated in the spec block inside the prompt. They are the same number, surfaced in two places — title for at-a-glance confirmation, spec block for the model.

---

## OUTPUT LANGUAGE

**EN by default.** Cinema-worldbuilder outputs English-only prompts unless the user explicitly requests bilingual.

**Bilingual on request.** If the user asks for EN+ZH or bilingual output, deliver two separate code blocks — one EN, one ZH — under a single title that flags the language pairing (e.g., `**Seedance prompt — 15s, EN+ZH**`). The ZH block is a faithful translation of the EN, with all camera, mode, and audio specs preserved. Do not blend EN and ZH inside one prompt.

For bilingual mode at scale (multi-shot batches, full sequences), the seedance-director skill handles those — cinema-worldbuilder is for the single cinematic scene with optional bilingual on request.

---

## CORE PHILOSOPHY

No plastic. No commercial gloss. No LED-panel-rendered-on-a-soundstage energy. No Instagram-ad sharpness.

Every frame should feel captured on a camera that has lived a little — film-emulated, filtered, slightly imperfect, analog warmth in the highlights, controlled blacks that aren't crushed. The grade is editorial, not commercial. The glass has character. The shadows hold detail. Real fabric, real skin, real sweat, real haze, real grain.

Five modes share an ARRI body and either Panavision Ultra Vintage anamorphic glass or Cooke S4/i spherical glass. The differences across the modes are in **movement, filtration, grade, palette, and texture** — not in body or lens family.

---

## READING REFERENCE IMAGES

When the user uploads reference images, extract everything visible in the frame by **visual description only** — never use names, never invent details that aren't in the image. The extracted description goes into the Static Description block of the Seedance prompt.

**For each character in the reference, capture:**

- **Hair:** color (every nuance — platinum, jet black with blue undertone, rose-pink, burgundy, ash brown, etc.), length, style, texture (straight, wavy, curly, coily), parting, any styling (slicked, blown out, flat-ironed, braided, bunned, ponytail, bangs — and which kind of bangs), accessories (clips, bows, ribbons, caps, bandanas, headbands)
- **Makeup:** skin finish (matte, dewy, glass-skin, bare), foundation/coverage register, brow shape and density, eye treatment (cat-eye liner, smoky, sharp graphic, soft bare, glitter, colored), lashes, lip (gloss, matte, gradient, color, fullness), cheek (flush, contour, highlight), any face jewelry, freckles or beauty marks **only if visible in the reference** (do not invent)
- **Wardrobe:** every garment top to bottom — fabric, color, fit (cropped, oversized, fitted, baggy), structural details (cutouts, keyholes, ribbing, ribbed cotton, knit, denim wash, leather finish, mesh, latex, silk), neckline, sleeve length, hem position, layering, branding details (described generically — "three-stripe athletic sneakers" not the brand name)
- **Jewelry & accessories:** every piece — earring style, necklace count and material, rings, bracelets, body chains, belts, bag, sunglasses, watch
- **Body markers:** piercings (only if visible), tattoos (only if visible), nail length and color, distinguishing features
- **Pose and energy:** body angle, weight distribution, hand position, expression register (neutral, smirk, focused, reactive — never describe a smile that shows teeth unless explicitly visible)

**For each environment in the reference, capture:**

- **Location:** interior or exterior, architecture, materials, scale
- **Time of day and weather:** lighting direction, quality, color temperature, sky, atmospheric conditions (haze, rain, snow, dust, smoke)
- **Set dressing:** every visible object that shapes the world — vehicles, signage, debris, furniture, props, vegetation, vendors, crowd
- **Color palette:** dominant tones, accent colors, contrast structure

**Naming rule (CRITICAL).** Never use proper names in the prompt output. Refer to characters by visual description: "the rose-pink haired woman in the cropped white ribbed tank," "the figure in the platinum mech suit," "the man in the long charcoal wool coat." Higgsfield does not know names. Visual descriptors survive across prompts; names do not.

**Brand name rule (CRITICAL).** Never use real brand names or protected IP in the prompt output. Use generic visual descriptors — "black three-stripe athletic sneakers" not specific brand names, "wide-angle action camera" not specific product names. Internal chat with the user can reference brands by name; the prompt output must be brand-neutral to avoid moderation delays.

**Age-blind rule.** Never describe characters by age. Avoid: *boy, girl, child, kid, young, teen, little, middle-aged, elderly, old.* Describe by role and clothing — "the figure in the wool cloak," "the woman in the cropped tank," "the silhouette against the horizon."

**No-invention rule.** If the user gives you a reference image and asks for the same character in a new scene, do not invent wardrobe or styling details that aren't in the image or specified in the request. If something is needed but not specified (e.g., a new outfit for a new scene), ask before composing — or note clearly in the prompt that the wardrobe is freshly described from the user's text input rather than the image.

---

## OPTIONAL HANDOFF — BANANA PRO DIRECTOR

If the user mentions they have a Banana Pro plate for the environment, want camera grammar to match an existing plate, or are pairing a Seedance prompt with a still they already built in Banana Pro, ask which cinema mode the plate used and lock the matching camera grammar in the Seedance prompt. The two skills share the same five-mode framework — when paired, the still and the video share visual DNA.

Otherwise, do not bring this up. Cinema-worldbuilder operates standalone unless the user invokes the pairing.

---

## MODE-SELECT TABLE

| Mode | Use when scene is... | Body | Lens | Movement | Filter | Grade |
|---|---|---|---|---|---|---|
| **M1 — Narrative** | Real-world dramatic scene — streets, kitchens, cars, bars, interiors, exterior locations. Anywhere "lived in." | Alexa 35 | Panavision Ultra Vintage anamorphic 40/55/75/100mm T2.3 | Handheld, slight breath, occasional slow dolly | Tiffen Black Pro-Mist 1/4 | Kodak 250D, 800 ASA, teal-amber split |
| **M2 — Studio / Editorial** | White void, clean studio, hyperpop saturated set, fashion film, editorial portrait, performance-on-set | Alexa Mini LF | Cooke S4/i spherical 32/50/75/100mm T2 | Locked + optional 4–6" slow push | Tiffen Black Pro-Mist 1/2 + Glimmerglass on chrome/rhinestone | Saturated editorial, pushed magentas or pastels, warm-retained blacks, 400 ASA |
| **M3 — Action / Combat** | Combat, chase, stunts, war, mech battles, alien encounters, debris, smoke, dust | Alexa 35 | Panavision Ultra Vintage anamorphic 40/55/75/100mm T2.3 | Handheld + shaky **throughout**, no stabilized shots | Tiffen Black Pro-Mist 1/4 | Kodak 250D, 800 ASA, daylight overcast or scene-appropriate palette, dusty haze |
| **M4 — Performance / Concert** | Stadium, arena, stage, jumbotron, lightstick crowd, festival pit | Alexa 35 | Panavision Ultra Vintage anamorphic 40/55/75/100mm T2.3 | Mixed handheld pit-photographer + shaky operator + orbital, hard cuts | Tiffen Black Pro-Mist 1/4 | Kodak 250D fine grain, desaturated cool tones with warm bloom, stage-lighting color cast |
| **M5 — Atmospheric / Empty** | Abandoned environments, no-humans plates, landscapes, weather pieces, mood/world establishing shots | Alexa Mini LF | Panavision Ultra Vintage anamorphic 35→85mm push range T2.3 | Locked-off or extremely slow push-in / pull-back | Tiffen Black Pro-Mist 1/4 | Kodak 250D, 400 ASA, palette-driven (specify hex values per scene) |

---

## MODE 1 — NARRATIVE (Real-World, Lived-In)

**When to use:** Real-world dramatic scenes. Streets, apartments, kitchens, cars, bars, diners, locker rooms, exterior locations, anywhere someone could plausibly walk into and shoot.

**Specs:**
- Body: ARRI Alexa 35, ProRes 4444 XQ, LogC4
- Lens: Panavision Ultra Vintage 2x anamorphic primes (40mm / 55mm / 75mm / 100mm at T2.3)
- Movement: Handheld with natural breath and slight shake, occasional slow dolly
- Filtration: Tiffen Black Pro-Mist 1/4 — softens highlights, gentle halation, keeps mids sharp
- Grade: Kodak Vision3 250D film emulation, 800 ASA grain, halation on highlights
- Palette: Teal-amber split — cool teal-blue push in shadows, warm amber in highlights, deep-but-not-crushed blacks, anamorphic falloff toward frame edges
- Frame rate: 24fps, 180° shutter

**Canonical drop-in block (paste at end of any Seedance prompt running M1):**

```
Shot on ARRI Alexa 35 in ProRes 4444 LogC4, Panavision Ultra Vintage 2x anamorphic [XX]mm at T2.3 with Tiffen Black Pro-Mist 1/4 filter, handheld with natural breath and slight shake, photoreal cinematic grit with oval bokeh and horizontal streak flares, warm anamorphic falloff toward frame edges, Kodak Vision3 250D film emulation grade with slight halation on highlights and 800 ASA grain structure, teal-amber color split with cool teal-blue shadows and warm amber highlights, organic lens breathing on focus racks, shallow depth of field, 24fps base shutter 180 degrees, total runtime roughly [XX] seconds.
```

Replace `[XX]` with the lens length (40mm wide, 55mm medium, 75mm tight, 100mm close-up) and the runtime.

---

## MODE 2 — STUDIO / EDITORIAL (Crafted, Not Photographed)

**When to use:** White void, clean studio sets, editorial portraits, hyperpop saturated worlds, fashion film, performance-on-set, any scene that is *crafted* rather than *photographed.*

**Specs:**
- Body: ARRI Alexa Mini LF, ProRes 4444 XQ, LogC4
- Lens: Cooke S4/i spherical primes (32mm / 50mm / 75mm / 100mm at T2)
  - 32mm — full-body wide on the void / group framing
  - 50mm — medium portrait
  - 75mm — tight editorial face cuts
  - 100mm — extreme close-ups (lips, eyes, jewelry, fabric)
- Movement: Locked-off tripod with optional 4-to-6 inch slow push-in
- Filtration: Tiffen Black Pro-Mist 1/2 + Glimmerglass on rhinestone or chrome cuts
- Grade: Saturated editorial — pushed magentas or pastels per scene, warm-retained blacks (not crushed), Cooke skin-tone warmth, 400 ASA fine grain
- Frame rate: 24fps, 180° shutter

**Canonical drop-in block (paste at end of any Seedance prompt running M2):**

```
Shot on ARRI Alexa Mini LF in ProRes 4444 LogC4, Cooke S4/i spherical prime [XX]mm at T2 with Tiffen Black Pro-Mist 1/2 filter, locked-off tripod with optional 4-to-6 inch slow push-in, photoreal editorial fashion film aesthetic with gentle halation bloom on highlights and soft warm falloff in the Cooke signature, fine 400 ASA film grain structure retaining warmth in the shadows, highlights allowed to bloom slightly around fabric and chrome surfaces, saturated editorial grade with warm-retained blacks not crushed to pure black, slight skin tone warmth from the Cooke color rendition, 24fps base shutter 180 degrees, total runtime roughly [XX] seconds. Not CGI, not plastic, shot-on-film analog aesthetic with real-world lens character.
```

Replace `[XX]` with the lens length and the runtime. For rhinestone, chrome, or surface-detail close-ups, append: `Glimmerglass diffusion added to the front element to bloom highlights on reflective surfaces.`

---

## MODE 3 — ACTION / COMBAT (Documentary-Sci-Fi)

**When to use:** Combat, chase, stunts, war, mech battles, alien encounters, fight choreography, any high-physicality scene with debris, smoke, dust, or destruction.

**Specs:**
- Body: ARRI Alexa 35, ProRes 4444 XQ, LogC4
- Lens: Panavision Ultra Vintage 2x anamorphic primes (40mm / 55mm / 75mm / 100mm at T2.3)
- Movement: Handheld and shaky **throughout** with constant operator micro-jitter, reactive movement, chaotic shake. Often orbital around figures. **No stabilized, locked-off, or dolly-smooth shots anywhere in the sequence.**
- Filtration: Tiffen Black Pro-Mist 1/4
- Grade: Kodak Vision3 250D, 800 ASA grain, gritty documentary-meets-sci-fi war film aesthetic, palette per scene (default daylight overcast for grounded combat — adjust for night/golden hour/storm/etc. as the scene demands)
- Frame rate: 24fps, 180° shutter (intercut 96fps high-speed slow-motion frames at impact moments if requested)

**Canonical drop-in block (paste at end of any Seedance prompt running M3):**

```
Shot on ARRI Alexa 35 in ProRes 4444 LogC4, Panavision Ultra Vintage 2x anamorphic [XX]mm at T2.3 with Tiffen Black Pro-Mist 1/4 filter, all camera work is handheld and shaky throughout with constant operator micro-jitter, reactive movement, and chaotic shake, no stabilized or locked-off or dolly-smooth shots anywhere, gritty documentary-meets-sci-fi war film aesthetic with no stylization and everything grounded in physical realism, Kodak Vision3 250D film emulation with 800 ASA grain structure, [palette descriptor] with dusty atmospheric haze, slight halation on highlights, 24fps base shutter 180 degrees, total runtime roughly [XX] seconds.
```

Replace `[XX]` with the lens length and the runtime, and `[palette descriptor]` with the scene-appropriate language (e.g., "daylight overcast palette," "golden hour warm palette," "blue-hour cool palette," "stormy desaturated palette").

---

## MODE 4 — PERFORMANCE / CONCERT (Pit-Photographer Documentary)

**When to use:** Stadium and arena performance shots, festival pits, concert footage, jumbotron-and-lightstick worlds, anywhere a performer is on stage with a crowd and stage lighting.

**Specs:**
- Body: ARRI Alexa 35, ProRes 4444 XQ, LogC4
- Lens: Panavision Ultra Vintage 2x anamorphic primes (40mm / 55mm / 75mm / 100mm at T2.3)
- Movement: Mixed handheld pit-photographer and shaky operator energy — rapid handhelds in the pit looking up, low-angle shaky handhelds on stage, orbital handheld around figures, reactive pacing matching crowd energy. Hard cuts between angles. No stabilized shots.
- Filtration: Tiffen Black Pro-Mist 1/4 — gentle bloom on stage lights and laser beams
- Grade: Slightly desaturated cool tones with warm highlight bloom, deep blacks holding shadow detail, controlled highlights, color cast from the stage lighting and any LED screen above
- Texture: Heavy volumetric haze, dust suspended in every beam, real sweat sheen on skin, real fabric darkening at chest and back from exertion, real damp hair, real metallic reflection on in-ear monitor cables and stick microphones, fine film grain emulation overlaid throughout
- Frame rate: 24fps, 180° shutter

**Canonical drop-in block (paste at end of any Seedance prompt running M4):**

```
Shot on ARRI Alexa 35 in ProRes 4444 LogC4, Panavision Ultra Vintage 2x anamorphic [XX]mm at T2.3 with Tiffen Black Pro-Mist 1/4 filter, mixed handheld pit-photographer energy with rapid handhelds and shaky low-angle operator work and orbital handheld passes around the performers, hard cuts between angles, no stabilized or locked-off shots, photoreal concert documentary aesthetic, Kodak Vision3 250D film emulation with fine grain structure overlaid throughout, slightly desaturated cool tones with warm highlight bloom and deep blacks holding shadow detail, [stage-lighting color cast descriptor], heavy volumetric haze with dust suspended in every beam, real sweat sheen on skin and real fabric darkening from exertion, gentle halation on light sources, 24fps base shutter 180 degrees, total runtime roughly [XX] seconds.
```

Replace `[XX]` with the lens length and the runtime, and `[stage-lighting color cast descriptor]` with the scene-appropriate language (e.g., "magenta-red color cast from the LED cube above," "amber and ultraviolet wash from side rigs," "cyan and white strobe punching through warm tungsten").

---

## MODE 5 — ATMOSPHERIC / EMPTY (Environment & Mood)

**When to use:** Abandoned cityscapes, no-humans environment plates, landscapes, weather pieces, slow-burn mood shots, world-establishing footage where the environment is the subject.

**Specs:**
- Body: ARRI Alexa Mini LF, ProRes 4444 XQ, LogC4
- Lens: Panavision Ultra Vintage 2x anamorphic with 35→85mm push range at T2.3
- Movement: Locked-off or extremely slow push-in / pull-back / drift; no handheld
- Filtration: Tiffen Black Pro-Mist 1/4
- Grade: Kodak Vision3 250D, 400 ASA, palette-driven — specify hex values per scene for the dominant color story
- Texture: Dust particles in air, atmospheric haze, real material weathering (oxidized metal, dust-covered glass, cracked paint, rubber degradation, dirt accumulation, moisture stains), strong negative space
- Frame rate: 24fps, 180° shutter

**Use this mode also for:** "no humans," "abandoned," "empty," "ghost city," "deserted," "weather plate," "establishing wide" requests.

**Canonical drop-in block (paste at end of any Seedance prompt running M5):**

```
Shot on ARRI Alexa Mini LF in ProRes 4444 LogC4, Panavision Ultra Vintage 2x anamorphic [XX]mm at T2.3 with Tiffen Black Pro-Mist 1/4 filter, locked-off or extremely slow push-in motion only, no handheld energy, photoreal atmospheric environment plate aesthetic, Kodak Vision3 250D film emulation with fine 400 ASA grain structure, palette-driven grade with [palette descriptor] and hex values [list 4-8 hex values from the user's palette], strong negative space, deep depth of field, light atmospheric haze with dust particles suspended in air, weathered material detail with oxidized metal and dust-covered glass and cracked paint and moisture stains, slight anamorphic flares on any directional light sources, 24fps base shutter 180 degrees, total runtime roughly [XX] seconds. No humans, no silhouettes, no living beings — the environment is the subject.
```

Replace `[XX]` with the lens length and the runtime, `[palette descriptor]` with words ("cold greys, steel blues, muted greens, warm rust accents"), and `[list of hex values]` with actual color codes for the scene (e.g., `#5f6468, #eaebee, #181819, #6f757a`).

---

## DIEGETIC AUDIO RULE (UNIVERSAL — APPLIES TO EVERY MODE)

Seedance generates audio natively. The audio line in your prompt should describe **only what the scene physically produces** — sounds that exist within the world of the frame. Never reference music, lyrics, song names, soundtrack cues, or score. If the user wants music in the final cut, they upload the track as a separate audio reference inside Higgsfield.

**Allowed in the audio line:**
- Footsteps (specify surface — wet pavement, gravel, polished floor, wood)
- Fabric movement (rustle, swish, whip on motion)
- Breath and breathing (steady, ragged, held, sharp inhale)
- Body sounds (hand on skin, slap, grip on metal, jewelry chime, hair movement)
- Object sounds (door, glass, paper, ceramic, metal, electronics, weapon mechanisms)
- Environmental ambient (room tone, wind, rain, traffic hum, distant horns, subway rumble, bird call, water, fire crackle)
- Mech / sci-fi diegetic (servos whining, weapon charging hum, pulse fire impact, alien screech, debris fall)
- Crowd diegetic (cheering, screaming, gasps, light stick taps, phone notifications, footsteps in unison)
- Stage diegetic (laser strobe hum, microphone handling noise, in-ear monitor cable rustle, stage floor creak under footsteps, haze machine hiss)
- Weather and atmosphere (rain on lens, wind through structures, distant thunder, snowfall hush)

**Never in the audio line:**
- Song names, artist names, album names
- Lyrics, sung vocals tied to a track, phone-filtered vocals
- "Music plays," "soundtrack swells," "song builds"
- Score descriptors ("orchestral," "synth pad," "dramatic strings")
- Specific genre cues ("hip hop beat drops," "rock guitar")

**Audio line template (drop into Static Description):**

```
Audio: diegetic only — [list 4-8 specific sounds from the scene with adjectives], no music, no dialogue except what is physically spoken in frame.
```

Example: `Audio: diegetic only — boots on wet pavement, fabric whip on movement, sharp inhale, distant traffic hum with layered horns, faint subway rumble below grade, rain hiss against the lens, wind cutting between buildings, no music, no dialogue except what is physically spoken in frame.`

---

## RUNTIME & PER-SHOT TIMING

**Total runtime:** every Seedance prompt this skill outputs must state the total runtime explicitly inside the canonical camera/spec block at the end (e.g., "total runtime roughly fifteen seconds"). The runtime is also surfaced in the title above the code block (e.g., "Seedance prompt — 15s") and in the pre-prompt confirmation summary. Three places, same number.

**Always ask runtime — never default.** If the user hasn't specified runtime, ask in the pre-prompt confirmation step. Do not assume 5s, 10s, or 15s as defaults.

**Per-shot timing for multi-cut sequences:** when a single Seedance prompt contains more than one shot stitched with hard cuts, label each shot inline in the Dynamic Description with its time range. Example:

> Dynamic Description: Shot 1 (0–3s): the woman in the cropped white tank steps off the curb onto wet pavement, the camera tracking her at chest level with a slight handheld breath. Hard cut to Shot 2 (3–8s): tight close-up on her hands tucked into her front pockets, fabric grain visible, the streetlight casting an amber rim along her knuckles. Hard cut to Shot 3 (8–15s): pull back to a wide low-angle as she crosses the empty intersection, taxi tail lights smearing through the frame in soft focus...

The timing in the inline labels must add up to the total runtime stated in the spec block and the title.

---

## OUTPUT FORMAT

Every Seedance prompt this skill generates follows the same structure: a **single continuous paragraph** with three inline bolded labels — **Style & Mood**, **Dynamic Description**, **Static Description** — and the canonical camera block plus diegetic audio line at the end.

**Structure:**

```
Style & Mood: [genre register, emotional tone, visual references in 1-2 sentences — e.g., "Documentary-grit cinematic realism with a slow-burn observational register, the camera as a witness rather than a participant, references the patient framing of Roma and the kinetic immediacy of Children of Men."]

Dynamic Description: [what happens across the duration of the shot — every action, gesture, camera move, focus rack, lighting change. For multi-shot sequences, label each shot inline with its time range ("Shot 1 (0–3s): ... hard cut to Shot 2 (3–7s): ..."). Use trigger words for cuts ("hard cut to...", "smash cut to...") if multiple shots are stitched. Describe physics, not commentary. One continuous flow.]

Static Description: [everything that does not change across the shot — the locked frame elements: characters in full visual detail extracted from references (hair, makeup, wardrobe, jewelry, body markers, pose), environment in full visual detail (location, set dressing, lighting, atmosphere, palette), and any anchored props.]

[Canonical camera block for the chosen mode, with [XX] lens length and runtime filled in.]

[Diegetic audio line.]
```

The whole thing is one paragraph from start to finish. No line breaks inside it once delivered. No section dividers. No headers. The bolded inline labels are the only structure.

**Delivery presentation:**

```
**Seedance prompt — [runtime, e.g., 15s] [, N shots if multi-cut] [, EN+ZH if bilingual]**
```
> [the full prompt code block]

For bilingual (on request): two separate code blocks under the title, EN first, ZH second.

---

## STACKING MODES (Multi-World Sequences)

If a single Seedance sequence cuts between two worlds — for example, a music video that intercuts a white void (M2) with a kitchen (M1), or action footage (M3) intercut with performance footage (M4) — write each shot's camera block separately according to its mode. Don't blend the specs into one averaged grade. The cut between modes is the visual punch; collapsing them into one register kills the contrast.

For multi-shot sequences in the same mode, you can compose one continuous prompt with hard-cut triggers in the Dynamic Description and a single shared camera block at the end (with per-shot timing inline in the action description).

---

## LENS LENGTH GUIDE (across all modes)

- **32mm / 35mm / 40mm:** Wide establishing, full-body, group framing, environmental context
- **50mm / 55mm:** Medium portrait, two-shot, waist-up, dialogue framing
- **75mm:** Tight editorial portrait, single-character isolation, performance close-up
- **85mm / 100mm:** Extreme close-up — eyes, lips, jewelry, fabric texture, surface detail

When in doubt, default to 55mm (M1 / M3 / M4) or 50mm (M2) for medium framing. M5 typically uses the wider end (35→55mm) for environmental reach.

---

## FRAME RATE NOTES

All five modes default to **24fps with 180° shutter** for cinema-standard motion blur.

Slow-motion beats (impact, hair whip, fabric on a hit, water splash, weapon recoil): specify in the prompt, `intercut a 96fps high-speed slow-motion frame at the [moment], holding shutter at 180 degrees for natural motion blur even in slow motion.` Keep this inside the canonical block — don't change the base frame rate.

---

## UNIVERSAL PROMPT RULES (ALL MODES)

These apply to every Seedance prompt this skill produces, no exceptions:

1. **Pre-prompt confirmation on every new scene.** 5-line summary (Mode / Scene / Characters / Camera / Runtime), wait for green light, then deliver. Skip only on iterations of a prompt just delivered.
2. **Title above every code block** stating the runtime (e.g., `**Seedance prompt — 15s**`). Multi-shot adds shot count. Bilingual adds language pairing.
3. **Total runtime baked into the spec block at the end.** Always ask runtime, never default.
4. **Per-shot timing inline in Dynamic Description** for any multi-cut sequence (Shot 1 (0–3s): ... hard cut to Shot 2 (3–7s): ...).
5. **Single continuous paragraph** with inline Style & Mood / Dynamic Description / Static Description labels. EN by default, EN+ZH bilingual on request only.
6. **No character names in prompt output.** Describe by hair color, wardrobe, identity markers extracted from reference images.
7. **No real brand names in prompt output.** Generic visual descriptors only.
8. **No `@image` tags or `<<<image_n>>>` placeholders.** Image attachment happens in the Higgsfield UI directly. The prompt is text-only.
9. **No internal production context.** No "carried through the world," no "matching the previous scene," no "as established earlier." Every prompt is standalone and self-contained — all visual details re-stated fresh.
10. **Pure visual description only.** No meta-commentary about why the shot is framed that way ("vlog moment," "lore reveal," "the contrast is the read"). No references to the medium ("this is a still frame," "what the photo looks like"). No emotional intent ("the contrast sells it"). Every word describes a visible thing in the frame.
11. **Diegetic audio only** — no music, no lyrics, no song references in the audio line.
12. **Energy over position.** Describe what bodies and forces are doing, not where they are placed. Physics over geometry.
13. **Detail cut triggers.** Use "hard cut to," "smash cut to," "match cut on" to signal edits inside multi-shot prompts. Auto-edit on by default.
14. **Camera spec per shot when modes stack.** If a sequence stacks modes, each shot gets its own camera block.

---

## INVENTORY EXTRACTION CHECKLIST (run this silently before composing)

Before writing the final prompt, silently catalog every asset from the user's text and uploaded images:

- [ ] Character gate asked (if first prompt of session) and answer carried
- [ ] Mode selected (M1 / M2 / M3 / M4 / M5) with rationale
- [ ] Every character described by visual markers only (hair, makeup, wardrobe, jewelry, body markers, pose)
- [ ] Every environment element (location, set dressing, lighting, atmosphere, palette)
- [ ] Every prop or anchored object
- [ ] Action / dynamic flow across the shot duration
- [ ] Lens length chosen for the framing
- [ ] Runtime confirmed with the user (never assumed)
- [ ] Per-shot timing planned for multi-cut sequences
- [ ] Diegetic audio sounds appropriate to the scene
- [ ] No names, no brands, no internal context, no meta-commentary, no music
- [ ] Pre-prompt confirmation summary delivered (unless skipping per the iteration rule)

If anything is missing from the user input that's needed to compose, ask before writing — or note in the response that a specific detail was inferred.

---

## WHEN THE USER ASKS FOR A PROMPT

The flow is always: **session-opener character gate (once) → pre-prompt confirmation → title line + code block.**

Title format:
- Single shot: `**Seedance prompt — 15s**`
- Multi-shot: `**Seedance prompt — 15s, 3 shots**`
- Bilingual: `**Seedance prompt — 15s, EN+ZH**`

Deliver the prompt inside a single fenced code block for clean copy-paste — no preamble inside the code block, no postamble unless the user explicitly asks for breakdown or rationale. If the user uploads multiple references for multiple shots, deliver each shot's prompt in its own code block, sequentially numbered or labeled by shot, each with its own title line stating that shot's runtime.

The user pastes the code block straight into Seedance. The user attaches the same reference images (or selects them from their Higgsfield character/environment library) inside the Higgsfield UI. The skill's job ends at the code block.
