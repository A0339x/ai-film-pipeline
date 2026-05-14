# Title Card — Creative Brief for Banana Pro

A title card is a **photorealistic still** — and that's exactly what `banana-pro-director` is for. This template doesn't write the prompt; it captures the creative choices, then you hand them to banana-pro-director and let the specialist write it.

## When you need this

- Hero title reveal (opening or closing card)
- Logo / wordmark for the project
- Transformer-esque mechanical letterform compositions
- Any text-as-hero-image piece (chapter cards, episode cards, lower-third overlays)

## What banana-pro-director needs from you

Fill this in, paste it into the conversation, and ask banana-pro-director to compose the prompt. The specialist knows the photoreal stack, lighting language, and visual grammar — you just need to lock the creative direction.

### The brief

- **String (exact):** [every letter, every space, e.g. "CTRL"]
- **Aesthetic reference:** [Gundam mech / cyberpunk / Art Deco / brutalist / hyperpop / utility / what the letterforms should *feel* like]
- **Letterform construction:** [armored plating / glass / neon tubing / liquid mercury / woven metal / wet clay / etc. — what the letters are *made of*]
- **Silhouette character:** [sharp + angular / soft + organic / handwritten flowing / mechanical segmented]
- **Primary surface material + color:** [e.g. "high-gloss bubblegum pink lacquer with glass-smooth wet-look sheen" — give hex if precise]
- **Secondary hardware layer:** [chrome / brass / matte black / exposed circuitry / hidden / etc. — the *embedded detail*]
- **Rim / glow treatment:** [color of the rim light, or "no rim" — often a saturated accent like pink, cyan, electric blue]
- **Perspective:** [straight-on / subtle three-quarter / dramatic low-angle]
- **Background:** [pure deep black void / pure white / void with subtle texture]
- **Aspect ratio (set in Higgsfield UI, don't write into prompt):** [16:9 / 1:1 / 9:16 / etc.]

### Handoff phrasing

Once filled, paste into the chat and say something like:

> *"Title card brief above. Have banana-pro-director compose it — photorealistic still, product-render quality, single image."*

banana-pro-director will run its standard pre-prompt confirmation, then deliver the prompt in a fenced code block. Run it in Banana Pro. Save the locked result to `references/titles/title_card_v01.png`.

## Reference: what a finished brief produced for CTRL: Hunters

For texture only — to show what locked creative choices look like when filled in. Not a template to copy literally.

- **String:** "CTRL"
- **Aesthetic reference:** Aespa + Gundam — futuristic K-pop, sharp, mechanical, candy-bright
- **Letterform construction:** Segmented armored plating locked together, engineered like high-fashion robotics
- **Silhouette character:** Sharp, angular, geometric — thin aggressive stems and cuts, no rounded curves
- **Primary surface:** High-gloss bubblegum pink lacquer with glass-smooth wet-look sheen
- **Secondary hardware:** Polished chrome — tiny hinges, rivets, segmented plate lines, exposed bolts, hydraulic joints, articulation seams
- **Rim treatment:** Subtle soft pink rim light tracing the edges and inner cuts
- **Perspective:** Slight three-quarter, balanced and symmetrical
- **Background:** Pure deep black void, no gradient, no texture, no other elements
- **Aspect ratio (UI):** 16:9

That brief got handed to banana-pro-director and produced the finished CTRL title card. Yours follows the same pattern — different creative choices, same handoff shape.

## Animation handoff (optional)

To animate the locked title card in Seedance: pass the still as a reference image, then ask `cinema-worldbuilder` for an M2 Studio mode prompt with:

- Locked tripod or 4–6" slow push-in
- *"Letter plates unfolding into final position"* (or whatever the motion is) as the dynamic action
- Diegetic audio: mechanical clicks, plate locks, low hum

M2 Studio's locked camera grammar (Cooke spherical, Black Pro-Mist 1/2, saturated editorial grade) is exactly right for a product-style reveal — the specialist handles all of that.
