# Suno Music Prompt

Cinema-worldbuilder explicitly forbids music language inside Seedance prompts — Seedance audio is diegetic only. The score is built separately in Suno and layered in post. This template is for that separate step.

## Workflow

1. Fill in the style prompt (the production / instrumentation brief).
2. Write the lyric sheet.
3. Paste both into Suno → generate 2 variations.
4. Pick the better one. Save filename + style prompt + lyric in `generation-log.md`.
5. To sync vocals to character lip movement: chop the chosen track into 12–15s clips and upload each as an element inside Higgsfield. Reference the element in the relevant shot's Seedance prompt.

## Style prompt structure (single line, comma-separated, dense)

The breakdown's working K-pop example, annotated:

```
[genre + subgenre] [tempo BPM] [key mood — dark minor key / bright major]
[rhythm spine — kick pattern, snare, hat pattern]
[bass character — sub bass / reverse bass / detuned saw]
[hook elements — air horn stabs, sirens, vocal chops]
[lead instruments — synth lead, vocal range]
[vocalist count + character — four female vocalists korean idol style]
[arrangement notes — rap verses, sung pre-choruses, group chant hook]
[mix character — dirty low end, tight snare, hi-hat triplets]
[reference register — production reference K-pop, Pop, Dance-pop, EDM, Hip Hop]
[energy descriptors — hardstyle, baile funk, trap, reggaeton]
[texture words — saturated, gritty, pristine, lo-fi, hyperpop]
```

Working K-Pop example from the breakdown:

> aggressive k pop girl group track 150 bpm dark minor key hardstyle kick pattern with reverse bass baile funk air horn stabs in the chorus detuned saw synth sirens four female vocalists korean idol style mix of rap verses and sung pre choruses group chant hook dirty low end tight snare hi hat triplets dance edm pop hip hop reggae trap energy production reference k-pop pop dance-pop edm hip hop electropop horn stabs

## Style prompt — fill in

```
[paste your style prompt here]
```

## Lyric sheet structure

Suno reads structural tags. Use these literally:

```
[Intro]
[Verse 1]
[Pre-Chorus]
[Chorus]
[Verse 2]
[Pre-Chorus]
[Chorus]
[Bridge]
[Chorus]
[Outro]
```

Per section:

- Keep lines short. Suno phrases short lines well; long lines slur.
- Repeated hooks are gold for sync — same hook each chorus = same lip pattern when you chop and reuse.
- Mixed-language is fine. Korean ad-libs or English hook over Korean verse, etc.
- One vocalist per line by default — Suno is smarter when you don't tell it to layer harmonies in the lyric itself. Use the style prompt for vocalist count.

## Lyric sheet — fill in

```
[Intro]


[Verse 1]


[Chorus]


[Verse 2]


[Bridge]


[Outro]

```

## Sync notes

| Shot # | Lyric line / section | Track timestamp | Notes |
|---|---|---|---|
| Shot 05 | Chorus L1 — "we got, we got, we got control" | 0:32–0:36 | crowd POV close-up, exaggerated mouth shape |
| Shot 06 | Chorus L2 | 0:36–0:40 | finger heart on the downbeat |
