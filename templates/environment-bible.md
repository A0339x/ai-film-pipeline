# Environment Bible — [Location Name]

> Location name is for your notes only. Prompts describe by visual content, never by your shorthand.

## Type

- [ ] Interior  [ ] Exterior
- [ ] Day  [ ] Dusk  [ ] Night  [ ] Golden hour  [ ] Blue hour  [ ] Stormy
- **Cinema mode default:** M1 / M2 / M3 / M4 / M5
- **Reusable across multiple shots?** Yes / No

## Locked description

A single paragraph that any future prompt can paste in. Use the structure from the breakdown:

- **Location & architecture:** materials, scale, era, condition
- **Lighting:** sources, direction, color temperature, contrast structure
- **Set dressing:** every visible object that shapes the world — furniture, vehicles, signage, debris, vegetation, props
- **Atmosphere:** haze, dust, rain, snow, smoke, particulate
- **Color palette:** dominant tones, accent colors, contrast structure (give hex values if M5)
- **Negative space rules:** where nothing should clutter
- **No-humans rule:** strict "no humans, no silhouettes, no living beings" line if it's a pure plate

## Establishing plate

- **Wide angle reference:** `references/environments/<location-name>/wide.png`
- **Prompt used:**
  ```
  [paste the pure environment plate prompt]
  ```

## Additional angles — fill in as you build them

`banana-pro-director` is explicit that scene plates are *"Never proposed proactively. Only built when the user asks."* Don't preemptively generate every angle this location *might* need. When a specific shot calls for a medium / reverse / tight-detail / etc., build it then, and add a row below.

| Angle | Reason built (which shot) | Reference file | Prompt |
|---|---|---|---|

> **POV-flip warning:** Higgsfield can be stubborn flipping POV inside an existing space — expect 2–3 attempts and consider a manual transform-flip in post if prompt iteration doesn't crack the reverse angle.

## Shots using this environment

- Shot ## — [one-line shot purpose]
- Shot ## — [one-line shot purpose]
