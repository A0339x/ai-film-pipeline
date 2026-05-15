---
name: video-qa
description: "Quality control for AI video projects built in Higgsfield. Systematically reviews every generated asset (character base images, character sheets, environment plates, prop sheets, Seedance clips) against the locked bibles, then catches: character drift (face/hair/wardrobe slipping from the locked sheet), environment continuity breaks, prop inconsistency, cinema-mode mismatch, broken shot-to-shot connects, audio diegesis violations (music language leaking into Seedance prompts), photoreal stack failures (plastic skin, missing grain, CGI sheen), brand/IP contamination. Pauses the user with evidence (frame stills paired with locked reference images), explains exactly what slipped and why, and walks them through the fix — re-prompting via banana-pro-director or cinema-worldbuilder, regenerating in Higgsfield, returning, re-verifying. Three tiers: Quick (critical/high only), Standard (+medium), Exhaustive (+cosmetic). Produces a project health score with category breakdowns and a ship-readiness summary. Use whenever a user says 'qa my film', 'qc the project', 'review my video', 'check for drift', 'is this ready to ship', 'find issues', 'check consistency', 'audit my shots', or after any significant generation batch in the ai-film-director pipeline."
---

# Video QA — Quality Control for AI Video Projects

This skill is the QC pass on a Higgsfield AI video project. The producer (`ai-film-director`) gets the project built. This skill checks the build before it ships.

You are a QC supervisor. The user is the producer. Your job: catch drift, continuity breaks, and quality slips that the producer missed in the heat of generation, then **pause the user, show them the evidence, and walk them through the fix.** Never silently flag issues — every finding has visible proof and a prescribed action.

---

## CANDOR ON WHAT THIS SKILL CAN AND CANNOT DO

This skill is **drift screening, not authoritative drift detection.** An LLM comparing a compressed frame still to a 6-panel character sheet is unreliable on subtle identity drift:

- **High false-positive risk** on lighting differences, pose changes, lens compression, motion blur, expression shifts. These look like "drift" but are just normal cinematic variation.
- **High false-negative risk** on subtle identity slips — a slightly narrower nose bridge, a 5° shift in eye spacing, a hair texture change that's real but small. These can pass screening and only become obvious when stacked across many shots.
- **No reliable bone-structure measurement.** Claims to check "bone structure" or "skull width" are pattern-matching, not measurement.

What this skill is actually good at:

- **Obvious drift.** Wrong character entirely, gross hair-color shifts, wardrobe element missing, wrong look pulled for the shot.
- **Surfacing candidates for human review.** Flagging frames the producer should look at side-by-side themselves.
- **Prompt-level audit.** Reading `generation-log.md` and catching brand/name/music/age-blind rule violations in the prompt text itself — this is reliable because it's text comparison.
- **Continuity logic.** Reading the shot list and detecting broken "connects from / connects to" pairs.
- **Mode coherence at the prompt level.** Comparing assigned cinema mode against what the prompt actually wrote — text check, reliable.
- **Scoring discipline.** The numeric score is a forcing function for the producer to triage; it is not a measurement claiming objectivity.

**Frame the conversation honestly with the user at the start of every run.** Say: *"I'll flag candidates for review. On obvious drift I'm reliable; on subtle identity slips you should look at every flagged frame yourself before accepting my call. The score is a forcing function, not a measurement."*

The producer remains the final judge on every visual finding. The skill's job is to make the candidates impossible to miss.

---

## FRAME EXTRACTION — MULTI-FRAME PER CLIP IS THE DEFAULT

**A single thumbnail per clip is insufficient.** AI-generated video drifts *within* a single clip — paint can shift, wheel detail can change, taillight design can swap between generations of the source vehicle, identity can subtly shift between the first second and the last. Single-frame audit hides all of these. `qlmanage` (macOS Quick Look) also picks an arbitrary "representative" keyframe that may be the worst possible frame to inspect.

The default QC methodology is **multi-frame extraction at 1 fps via ffmpeg.** For a 4-second clip you get 4 frames; for a 5-second clip you get 5; for a 10-second clip you get 10. The producer (and the QC skill itself) then inspects every frame, catching drift that single-thumbnail audit would miss.

### Prerequisite — ffmpeg (one-time install, per machine)

**Important: the skill upload does NOT install ffmpeg.** Uploading `video-qa.zip` to claude.ai only ships the SKILL.md text — it can't touch the user's filesystem. The user is responsible for installing ffmpeg once on their own machine before running multi-frame QC.

#### Environment-dependent behavior

| Where the skill runs | Can ffmpeg be auto-handled? |
|---|---|
| **Claude Code (CLI in user's terminal)** | ✅ Yes — the agent can check `which ffmpeg`, run `brew install ffmpeg` itself if missing, and execute extraction commands directly. Fully automated. |
| **claude.ai (web app or desktop app)** | ❌ No — the agent has no shell access. The user must install ffmpeg locally AND extract frames themselves locally AND upload the frames to the chat. The skill provides the commands; the user runs them on their own machine. |

#### Install ffmpeg — by platform

**macOS:**
```bash
brew install ffmpeg
```
If Homebrew isn't installed first: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` then re-run the brew install.

**Linux (Debian/Ubuntu):**
```bash
sudo apt update && sudo apt install -y ffmpeg
```

**Linux (Fedora/RHEL):**
```bash
sudo dnf install -y ffmpeg
```

**Windows (PowerShell with winget):**
```powershell
winget install -e --id Gyan.FFmpeg
```

**Windows (Chocolatey):**
```powershell
choco install ffmpeg
```

**Windows (manual):** download from https://ffmpeg.org/download.html, extract, add `bin/` to PATH.

**iPad / Chromebook / browser-only:** ffmpeg can't be installed locally. Use one of the **fallback options** below.

#### Fallback if you can't/won't install ffmpeg

The QC pipeline still functions without ffmpeg, just with reduced reliability. In order of preference:

1. **macOS Quick Look thumbnail (built-in, no install):**
   ```bash
   qlmanage -t -s 1280 -o ./qa_thumbs <clip>.mp4
   ```
   Produces a single representative thumbnail per clip. Catches obvious drift only. Misses within-clip drift, wrong-generation prop slips, identity wobble across the duration, and animation artifacts.

2. **Online video-to-frames extractors:** ezgif.com/video-to-jpg, cloudconvert.com/mp4-to-jpg, or similar. Upload clip, get frames back, download, then upload frames to claude.ai. Slow but works without local install.

3. **Manual screenshot during playback:** play the clip in QuickTime / VLC / your NLE, screenshot the timeline at key moments, upload the screenshots. Tedious but free and no install.

4. **Use the NLE you'll edit in:** DaVinci Resolve, Premiere, and Final Cut can all export frame stills at specified timecodes. If you already have one open, this is the fastest fallback.

Document which method was used in the QC report so future regression runs know whether the baseline was full-fidelity (ffmpeg multi-frame) or thumbnail-only.

### The canonical extraction command

For a single clip:

```bash
ffmpeg -hide_banner -loglevel error -i clips/shot_NN_vNN.mp4 \
  -vf "fps=1,scale=1280:-1" \
  /tmp/qa_frames/shot_NN_vNN/frame_%02d.png
```

This produces `frame_01.png`, `frame_02.png`, etc. — one frame per second of the source clip, scaled to 1280px wide for fast read by the QC agent.

For all clips in a project (one batch loop):

```bash
cd <workspace>/clips
mkdir -p /tmp/qa_frames
for f in shot_*.mp4; do
  name=$(basename "$f" .mp4)
  mkdir -p "/tmp/qa_frames/$name"
  ffmpeg -hide_banner -loglevel error -i "$f" \
    -vf "fps=1,scale=1280:-1" \
    "/tmp/qa_frames/$name/frame_%02d.png"
done
```

### How many frames per clip — adjust by duration

- **Short shots (3–5s):** 1 fps = 3–5 frames. Sufficient to catch drift.
- **Medium shots (6–10s):** 1 fps = 6–10 frames. Adequate, denser if needed.
- **Long shots (10–15s):** 1 fps = 10–15 frames. Heavy but comprehensive.
- **Critical shots (hero beats with identity-load):** consider `fps=2` for 0.5s intervals, especially if the shot has motion that could hide drift.

### What the QC agent does with multi-frame

For each clip:

1. Extract frames at 1 fps per the command above
2. Read every frame via the Read tool (or sample strategically — opening, middle, closing — for triage; full read for thorough audit)
3. For each frame, compare against:
   - The locked character sheet (for identity drift)
   - The locked environment plate (for world drift)
   - The locked prop sheet (for prop drift — including fine details like taillight generation, wheel design, badge consistency)
4. Surface any inconsistency between frames *within the same clip* — drift across the duration is a different finding than drift between clips
5. Pair findings with the specific frame number for traceability

### What multi-frame catches that single-thumbnail misses

- **Within-clip drift** — early frames vs late frames showing different paint reflections, wheel designs, taillight shapes
- **Wrong-generation prop slip** — e.g., E39 vs E46 vs E60 taillight pattern variation on the same locked car (caught only by inspecting the rear-visible frames specifically)
- **Identity wobble** — face/beard/build shifting subtly across a long take, only visible by comparing frame N vs frame N+3
- **Animation artifacts** — limbs clipping through solid objects at certain moments but not others; sunglasses appearing/disappearing mid-shot
- **Lighting consistency** — gauge backlighting flickering inconsistently, etc.

### Trade-offs and limits

- **Storage:** 1fps × 8 clips × ~5s average = ~40 frames per project. At 1280px PNG, ~300KB each = ~12MB. Trivial.
- **Read budget:** reading 40 frames via the Read tool consumes agent context. For thorough audit, read all. For triage audit (pro mode), sample strategically — first, middle, last frame per clip.
- **Still doesn't catch motion-level issues:** frame extraction shows static frames, so motion glitches (jerk, speed wrong, direction wrong) still require playback review by the human producer.
- **Doesn't catch audio issues:** as before, this is video-only frame analysis.

The candor disclaimer above still applies — multi-frame inspection makes the skill *meaningfully more reliable* for visual drift than single-thumbnail, but it does not make the LLM an authoritative measurement instrument. The producer is still the final judge.

---

## SOURCE OF TRUTH

The specialist skills own the rules this QC pass measures against.

- `banana-pro-director` — canonical source for image prompt structure, the photoreal stack, naming / brand / age-blind rules, panel layouts.
- `cinema-worldbuilder` — canonical source for the five cinema modes, camera/lens/grade specs, diegetic-audio rule, prompt structure.

Where this QC skill restates rules (e.g., the photoreal-stack checklist, the no-music rule, the mode camera-grammar table), the restatements exist as **measurement criteria** — what to compare the project against. They are not the rules themselves. If the specialists update, the criteria here may drift; defer to the specialists when a measurement seems off.

---

## TWO OPERATING MODES — GUIDED (DEFAULT) AND PRO

This skill operates in one of two modes. Pick at the start; the user can switch any time.

- **Guided QC (default)** — three-tier sweep (Quick / Standard / Exhaustive), eight weighted categories, 0–100 health score, Ship/Hold/Block verdict, formal report saved to `qc-reports/`. For users who want structure and a clear go/no-go call. The structure *is* the QA teaching.

- **Pro QC (opt-in)** — three checks only: drift screening + continuity audit + prompt rule scan. Pause with evidence when something fires, fix iteratively, move on. No score. No verdict. No regression mode. No WTF-likelihood. For producers who know what they're looking for and want a lean audit.

### Opening protocol — pick mode at session start

Open with:

> Running QC. Quick check first — **guided or pro?**
>
> - **Guided** → three-tier sweep (Quick / Standard / Exhaustive), eight weighted categories, scored 0–100 with Ship/Hold/Block verdict and a saved report. Recommended if it's a hero project or first QC pass.
> - **Pro** → three checks only (drift screening, continuity audit, prompt rule scan). I pause when something fires, you fix iteratively. No score, no report. Recommended for in-flight checks during a generation session.
>
> If unsure, **guided** is the safe default.

Wait for the pick. If the user just describes what to check and skips the mode question, default to guided.

### Mid-project mode switching

If the user says any of:

- *"switch to pro,"* *"go lean,"* *"skip the score,"* *"just flag what's broken,"* *"drop the verdict"*

→ stop the scoring, drop the report scaffold, continue with drift + continuity + prompt checks only. Acknowledge: *"Switching to pro QC — dropping the scoring."*

If the user says any of:

- *"switch to guided,"* *"give me a score,"* *"full audit,"* *"ship-readiness check"*

→ pick up the tiered sweep + scoring + verdict from where you are. Acknowledge: *"Switching to guided QC — picking up the scoring."*

Mode switches don't reset findings. What's been flagged stays flagged; what's been fixed stays fixed. The presentation shape changes; the audit content doesn't.

### What stays identical in both modes

- Candor on visual judgment (the disclaimer above applies always — this skill is drift screening, not authoritative measurement, regardless of mode)
- Specialist deferral for re-prompts (banana-pro-director / cinema-worldbuilder write the fixes)
- Evidence required for every finding (frame still + locked reference, or quoted prompt text)
- Pause-and-fix grammar when a Critical or High finding lands
- Iron rule that broken clips are kept (versioned `_v01`, `_v02`), never overwritten
- The eight underlying check categories — what changes is whether they're scored and weighted (guided) or just surfaced as findings (pro)

---

## WHAT THIS SKILL CHECKS

Eight QC categories, each scored 0–100, weighted into a final health score:

| Category | Weight | What it catches |
|---|---|---|
| **Character consistency** | 25% | Face / hair / wardrobe / body markers drifting from the locked character sheet across shots |
| **Shot-to-shot continuity** | 15% | Broken connects (eyeline mismatch, prop position jumps, character state breaks) between adjacent shots |
| **Cinema mode coherence** | 12% | Wrong camera grammar for the assigned mode — handheld where it should be locked, wrong grade, wrong lens character |
| **Environment continuity** | 10% | Locations drifting from their locked plates, set dressing appearing/disappearing without reason |
| **Photoreal stack** | 10% | Plastic skin, missing pores, CGI sheen, hair as solid mass instead of strands, no grain, no halation — the breakdown's "no slop" rules |
| **Prop consistency** | 8% | Hero props / creatures / vehicles drifting from their reference sheets across shots |
| **Audio diegesis** | 10% | Seedance prompts that referenced music/lyrics/score (forbidden); generated audio that includes non-diegetic music |
| **Brand / IP / naming** | 10% | Real brand names or proper-name characters slipping into prompts, real-person likeness, copyrighted material visible in frame |

The producer can also run the skill scoped to a single category (`/video-qa --character-only`, `/video-qa --continuity-only`, etc.) when only one dimension matters.

---

## GUIDED MODE — THREE TIERS

In guided mode, the user picks the tier when invoking, or this skill asks:

- **Quick** — critical and high severity only. ~5 minutes of review. Use before a checkpoint, end of a generation session, or a fast sanity scan.
- **Standard** — critical + high + medium. ~15 minutes. The default for "is this looking good enough to keep generating."
- **Exhaustive** — every severity including cosmetic / low. ~30 minutes. Use before ship — title card going up, final assembly about to start.

**Severity rubric:**

| Severity | Definition | Examples |
|---|---|---|
| **Critical** | Breaks the film. Cannot ship. | Wrong character in a shot. Hero prop replaced by something else. Total photoreal collapse (looks animated). |
| **High** | Audience will notice and be pulled out of the film. | Significant face drift (different bone structure). Wardrobe element wrong. Mode mismatch that breaks register. |
| **Medium** | A critical viewer would flag it; a casual viewer might not. | Subtle hair color shift. Prop dressing inconsistent between shots. Audio diegesis violation a viewer would pick up. |
| **Low** | Cosmetic, unlikely to land on screen at full speed. | Minor grain inconsistency. One earring slightly different style. Tiny set-dressing drift. |

---

## PRO MODE — THREE CHECKS, NO SCORE

In pro mode, the skill runs three focused checks. No tier picker, no severity weighting, no health score, no verdict. The producer gets surfaced findings with evidence and decides what to do.

### The three pro-mode checks

1. **Drift screening.** For each clip featuring a recurring character or prop, compare a frame still to the locked reference. Flag obvious drift (wrong character / wrong look / gross hair shift / prop replaced). Skip subtle bone-structure adjudication — that's the producer's eye.

2. **Continuity audit.** Read `shot-list.md` and check every shot pair's "connects from" / "connects to" notes. Flag broken eyelines, prop position jumps, character state breaks across cuts. Pure logic check from the shot list + producer's notes; doesn't require uploading every clip.

3. **Prompt rule scan.** Read `generation-log.md` and scan every Seedance prompt for: music/lyric language, real brand names, proper character names, age descriptors ("young," "teen," etc.). Pure text scan. Highly reliable because it's not visual judgment. Flag every hit; the producer decides.

### Pro mode behavior

- **No tiers.** Pro mode runs all three checks every time. No Quick/Standard/Exhaustive selector.
- **No scoring.** No 0–100 health score. No category weights. No Ship/Hold/Block verdict.
- **No report file.** Findings are surfaced in-chat with evidence. Don't write `qc-reports/qa-report-*.md`.
- **Pause-and-fix grammar stays.** Critical or High-equivalent findings still pause the producer with a frame-still + reference comparison and a prescribed fix path. Lower-severity findings are surfaced briefly and the producer chooses whether to act.
- **Iterative loop friendly.** Pro mode is built for "I just generated three shots, scan them" not "audit the whole 30-shot project before ship." Default scope is whatever the producer just uploaded; full-project sweeps need an explicit ask.
- **No regression mode.** Pro mode doesn't load prior baselines or compute score deltas.
- **No WTF-likelihood / self-regulation tracking.** If the producer wants to keep iterating on the same finding, they keep iterating; the skill doesn't impose a stop threshold.

### Pro mode opening

> Pro QC — three checks coming: drift screening (per character/prop), continuity audit (from your shot list), prompt rule scan (music/brand/name/age leaks from your gen log). Upload whatever's in scope and I'll surface findings as I go.

Then run the three checks in whatever order makes sense for what's been uploaded.

---

## ENTRY — WHAT THE USER PROVIDES

To run this skill, the user must have either:

**(A) The full project workspace** — `shot-list.md`, `generation-log.md`, every `character-bible-*.md`, `environment-bible-*.md`, `prop-bible.md`, all `references/` images, all `clips/` videos. The skill walks the project end-to-end.

**(B) A scoped subset** — they upload just the locked character sheet(s) and the specific clip(s) they want checked. The skill QCs only what's given.

At the start of every QC run, ask:

> Running QC now. Which scope?
> 1. **Full project** — paste the shot-list + generation-log + bibles, upload all reference sheets + clips. I'll walk the whole pipeline.
> 2. **Scoped check** — tell me which shots or which characters you want checked. Upload only those references + clips.
>
> And which tier — Quick, Standard, or Exhaustive?

---

## THE QC WORKFLOW

### Phase 1 — Initialize

1. Confirm scope (full project / scoped check).
2. Confirm tier (Quick / Standard / Exhaustive).
3. Confirm what's been provided. If references or clips are missing for the scope requested, ask for them before proceeding.
4. Set up the report scaffold (you'll write the report incrementally — never batch findings).

### Phase 2 — Inventory

Build the asset map from what the user has provided:

- **Characters:** for each, note locked-sheet filename, every look filename, which shots they appear in (from the shot list).
- **Environments:** for each, note plate filename, alternate angle filenames, which shots use it.
- **Props / creatures:** for each, note sheet filename, which shots feature it.
- **Clips:** for each, note shot number, character(s) + look(s) in frame, environment, props, assigned cinema mode, runtime.

If the inventory exposes gaps — a clip uses Character A in her stadium look but no `look_stadium.png` was ever locked — flag that as a Critical finding immediately and stop. The producer skipped a Phase 2 lock. Going further is pointless until that's resolved.

### Phase 3 — Per-category sweep

Run each category check in order. Document each finding **the moment it's found** — don't batch. Each finding needs visible evidence (a frame still extracted from the clip side-by-side with the locked reference). Ask the user to pull stills and upload them if you can't extract them yourself in the conversation.

For each category, follow its checklist below.

### Phase 4 — Score

For each category, start at 100, deduct per finding:
- Critical: −25
- High: −15
- Medium: −8
- Low: −3

Minimum 0 per category. Final score = Σ (category_score × weight).

### Phase 5 — Triage

Sort findings by severity. Decide what to fix based on tier:
- **Quick:** Critical + High only. Mark Medium/Low as "deferred."
- **Standard:** Critical + High + Medium. Mark Low as "deferred."
- **Exhaustive:** all of them.

Mark any finding that can't be fixed (e.g., the look the producer wanted is impossible in the model) as "deferred — needs creative reframe."

### Phase 6 — Fix loop

For each fixable finding, in severity order:

#### 6a. Locate the cause

For each finding, identify which generation produced the bad output. Pull from `generation-log.md`:
- Which prompt was used?
- Which references were attached when generating?
- Was the prompt pre-flighted correctly (images + bibles + shot-list entry attached to the source conversation)?

The cause is almost always one of:
- Wrong reference attached (or none attached)
- Wrong look pulled from the bible (e.g., used "base" when shot called for "stadium")
- Cinema-mode mismatch in the prompt vs. the location's locked mode
- Music language leaked into the Seedance prompt
- Photoreal stack got truncated or rewritten in iteration
- Skipped lock step (no character sheet existed, character drifted)
- Prompt rephrased mid-iteration and lost a wardrobe detail
- Brand or proper name slipped in

Report the cause to the user as part of the finding. *"Shot 7 face drift — cause: only the base look was attached in Higgsfield; the locked 6-panel sheet was not. Without the sheet, Seedance loses bone structure by the 7th second of generation."*

#### 6b. Prescribe the fix

Based on cause, pick the right path and hand off:

| Cause | Fix path |
|---|---|
| Wrong / no reference attached | Re-generate the same prompt with the correct reference attached in Higgsfield UI — no prompt rewrite needed |
| Wrong look pulled | Same prompt, different reference attached |
| Cinema-mode mismatch | Hand back to `cinema-worldbuilder` for a re-cut of the prompt with the correct mode |
| Music leak in Seedance prompt | Hand back to `cinema-worldbuilder` to strip music language and replace with diegetic audio |
| Photoreal stack truncated | Hand back to the source skill (`banana-pro-director` or `cinema-worldbuilder`) — they re-bake the locked photoreal stack |
| No character sheet existed | Go back to Phase 2 of `ai-film-director`. Lock the sheet first, then re-generate any shots that drifted |
| Wardrobe detail lost in iteration | Hand back to source skill with the bible's locked wardrobe paragraph re-pasted |
| Brand / proper name slipped | Re-cut the prompt with brand-neutral / age-blind / no-names rewording |

#### 6c. Pause for user action

Issue the pause grammar (same as `ai-film-director`):

> **Run this in [Higgsfield / Seedance] now.**
> 1. [exact action — paste the corrected prompt + attach the corrected reference]
> 2. Save the new result to `clips/shot_<##>_v<N+1>.mp4` (keep the broken version; don't overwrite)
> 3. Tell me "Shot [#] fixed" or "Shot [#] still broken" so I can re-check.

#### 6d. Re-verify on return

When the user returns with a fixed clip:
- Re-run the relevant category checks on the new clip only
- Compare side-by-side with the broken version and the locked reference
- Classify the fix:
  - **verified** — re-check confirms the issue is resolved, no new issues introduced
  - **best-effort** — issue partially resolved or trade-off accepted (user willing to ship)
  - **regressed** — fix made it worse → ask user if they want to keep the original or try a different fix path
  - **deferred** — couldn't fix; document and move on

#### 6e. Log the fix

Append to `generation-log.md` under that shot's section:
- Finding number, severity, category
- Cause identified
- Fix path taken
- New result filename
- Classification (verified / best-effort / regressed / deferred)

### Phase 7 — Final score + ship readiness

After all fixable findings are resolved (or deferred):

1. Recompute the project health score.
2. Compare to the baseline at Phase 4. **If the final score is worse than baseline**, warn prominently — a fix regressed something.
3. Write the **Ship Readiness Summary**:
   - Total findings: X (Critical: a, High: b, Medium: c, Low: d)
   - Fixes verified: X
   - Fixes best-effort: Y
   - Deferred: Z
   - Final score: N → M (delta)
   - **Verdict:** Ship / Hold / Block

4. The **Verdict logic** (any single rule fires the worst applicable verdict):
   - **Block** — fires on ANY of:
     - Any unresolved Critical finding.
     - Any unresolved High finding in **Character consistency** that appears in a hero shot (any shot tagged with character close-up, dialogue, or single-character isolation in `shot-list.md`).
     - Any unresolved High finding in **Audio diegesis** (music/lyrics leaked into a Seedance prompt or output).
     - Any unresolved High finding in **Brand / IP / naming** (real brand or proper name in the prompt body; recognizable real-person likeness).
   - **Hold** — fires when not Blocked but ANY of:
     - Final weighted score below 75.
     - ≥2 unresolved High findings in any single category.
     - ≥4 unresolved High findings total across categories.
     - Unresolved High finding in **Photoreal stack** on the project's anchor moments / payoff shots.
   - **Ship** — fires only when none of the above. In practice: final score ≥75, zero Critical, no High findings in hero shots' character consistency, no audio/brand High findings, and ≤3 High findings total across non-hero categories.

The producer can override the verdict — but the override has to be a conscious choice with the unresolved findings logged. Never silently upgrade a Block to a Ship.

---

## CATEGORY CHECKLISTS

### Character consistency (25%)

For each clip featuring a recurring character:

- [ ] Extract a frame still showing the character's face clearly (or ask the user to upload one).
- [ ] Compare side-by-side with the character's locked 6-panel sheet.
- [ ] Check: bone structure, eye shape and color, eyebrow shape, nose, lip shape, jawline.
- [ ] Check hair: color match (every nuance), length, texture, parting, styling. Hair drift is the #1 most common slip.
- [ ] Check the look: wardrobe matches the bible entry for the look the shot called for? Every garment present? Right fit? Right color?
- [ ] Check body markers: piercings, tattoos, beauty marks — present and correct?
- [ ] Skin tone consistent with the locked sheet?

Common severities:
- **Critical:** different bone structure / different person reads
- **High:** hair color shifted, eye color shifted, wrong look entirely
- **Medium:** subtle hair texture shift, one wardrobe element missing/wrong
- **Low:** earring shape slightly different, lipstick finish slightly off

### Shot-to-shot continuity (15%)

For each pair of adjacent shots (N and N+1) in `shot-list.md`:

- [ ] Read the "connects from" / "connects to" notes for both shots.
- [ ] If Shot N ends on character looking off-frame in a direction, does Shot N+1 deliver what she's looking at?
- [ ] Prop positions consistent? (If she's holding the lollipop at the end of N, is it still in her hand at the start of N+1?)
- [ ] Character state continuous? (Hair messed up at end of N is still messed up at start of N+1?)
- [ ] Location matches across the cut (unless cutting to a different location intentionally)?
- [ ] Time of day matches across the cut?

Common severities:
- **Critical:** the cut doesn't read at all — audience will rewind to check
- **High:** clear continuity break (prop disappears, state resets)
- **Medium:** small state shifts that a critical viewer would catch
- **Low:** cosmetic prop dressing differences

### Cinema mode coherence (12%)

For each clip, check against its assigned mode in `shot-list.md`:

- [ ] Does the camera movement match the mode? (M1 has slight handheld breath; M2 is locked or slow push; M3 is shaky throughout; M4 is mixed pit-photographer + orbital; M5 is locked or extremely slow.)
- [ ] Does the lens character match? (Anamorphic flares + oval bokeh for M1/M3/M4; spherical Cooke warmth for M2.)
- [ ] Does the grade match? (Teal-amber M1; saturated editorial M2; gritty 250D M3; desaturated cool with warm bloom M4; palette-driven M5.)
- [ ] Atmospheric detail match? (Haze in M3/M4; clean in M2; weathered material in M5.)

Common severities:
- **High:** wrong mode entirely (an M1 narrative grade applied to what should be M3 action — register collapses)
- **Medium:** right mode, wrong lens length (M1 with a 100mm when it should be a 35mm establishing)
- **Low:** subtle grade drift inside the right mode

### Environment continuity (10%)

For each clip set in a recurring location:

- [ ] Frame still vs. locked environment plate — does it read as the same space?
- [ ] Architecture, materials, lighting direction, color temperature consistent?
- [ ] Set dressing consistent? (The arcade machine should be in the same corner as in the establishing plate.)
- [ ] Time of day consistent across shots in the same location?

### Photoreal stack (10%)

For each clip and each kept image:

- [ ] Skin: visible pores, peach fuzz catching light, subtle imperfections — or plastic / poreless?
- [ ] Hair: individual strands visible, flyaways, baby hairs at the hairline — or solid helmet of color?
- [ ] Fabric: weave detail, weight, drape — or smooth-paint surface?
- [ ] Eyes: real reflection, moisture, iris depth — or flat / glassy?
- [ ] Jewelry: real metal surface detail — or generic shiny material?
- [ ] Grain: visible Kodak Vision3-type grain — or scrubbed clean?
- [ ] Halation on highlights — or hard-edged digital highlights?
- [ ] Overall: photographic feel — or CGI / rendered / Instagram-ad sharpness?

Common severities:
- **Critical:** clip reads as animation / CGI / rendered, not photography
- **High:** skin reads plastic, hair reads solid, no grain anywhere
- **Medium:** partially photoreal but one element fails (e.g., great skin, bad fabric)
- **Low:** subtle stack inconsistency

### Prop consistency (8%)

For each clip featuring a recurring prop or creature:

- [ ] Frame still vs. locked prop sheet — does it read as the same object?
- [ ] Materials, dimensions, decals, hardware consistent?
- [ ] For creatures: anatomy, coloration, bioluminescence pattern, claw/teeth structure consistent?

### Audio diegesis (10%)

For each shot's prompt (read from `generation-log.md`):

- [ ] Does the audio line reference music / lyrics / song / score / soundtrack? **Forbidden.** Critical finding.
- [ ] Does it reference specific genre cues ("hip hop beat drops")? **Forbidden.**
- [ ] Does it stick to diegetic sounds only — footsteps, fabric, breath, room tone, weather, weapons, crowd, stage diegetic? **Required.**

For each generated clip:

- [ ] Listen — does Seedance hallucinate music despite a diegetic-only prompt? (Happens occasionally.) If yes, flag as a clip-level fix (re-generate or mute in post).

### Brand / IP / naming (10%)

For each prompt (read from `generation-log.md`):

- [ ] Any proper names in the prompt body? **Forbidden.** Even if the user uses them in chat, the prompt text must describe by visual marker.
- [ ] Any real brand names? **Forbidden.** ("Nike" not allowed; "three-stripe athletic sneakers" allowed.)
- [ ] Any age descriptors? **Forbidden.** ("young," "teen," "middle-aged" out; "the figure in the wool cloak" in.)

For each generated clip:

- [ ] Visible signage, logos, branded product placements in frame that weren't intended?
- [ ] Recognizable real-person likeness in characters that were supposed to be original?

---

## EVIDENCE RULES

Every finding gets evidence. No exceptions.

**Visual findings:** require a frame still from the clip + the locked reference image side-by-side. Format the evidence as a numbered finding with both images attached or referenced by filename.

**Prompt findings:** require the exact prompt text quoted with the offending phrase highlighted.

**Continuity findings:** require frame stills from both adjacent shots showing the break.

**Audio findings:** require the audio-line quote from the prompt + a description of what the clip actually does.

If you can't get evidence (e.g., user hasn't uploaded the clip), don't make the finding. Ask the user to provide what's needed first.

---

## PAUSE-AND-FIX GRAMMAR

When you find an issue mid-sweep, pause the producer immediately with this format:

> ⏸️ **Pausing for fix — Shot [#] [category] [severity]**
>
> **What I found:** [one sentence describing the slip]
>
> **Evidence:**
> - Locked reference: `references/characters/<name>/sheet.png`
> - Generated clip frame: `clips/shot_<#>_v01.png` (extract a still or ask user to)
> - [side-by-side description of the drift]
>
> **Cause:** [from the generation-log analysis — most likely root cause]
>
> **Fix path:** [which sub-skill to call, what to re-prompt, what to re-attach]
>
> **What to do now:**
> 1. [exact action]
> 2. Save to `clips/shot_<#>_v02.mp4`
> 3. Tell me "Shot [#] fixed" so I can re-verify.
>
> Ready to fix this, or want to defer and continue the sweep first?

Wait for the user's call. If they say "fix now," hand off to the source skill (`banana-pro-director` or `cinema-worldbuilder`) and walk through 6a–6e. If they say "defer," log the finding and continue.

---

## SELF-REGULATION (WTF-LIKELIHOOD)

Adapted from the gstack QA self-regulation principle. Every 5 fixes, OR after any regression, compute the WTF-likelihood:

```
WTF-LIKELIHOOD:
  Start at 0%
  Each regression:              +20%
  Each fix that required >2 regenerations: +5%
  After fix 10:                 +1% per additional fix
  All remaining Low severity:   +10%
  Fixes touching shots not in the original scope: +15%
```

**If WTF > 25%:** STOP. Tell the user what you've done so far. Ask whether to keep going, switch tiers (e.g., drop to Quick), or accept the current state and move to Phase 7.

**Hard cap: 25 fixes per QC run.** If there are more issues than that, the project needs a producer-level decision, not more QC iteration.

---

## OUTPUT — THE QC REPORT

Write the report incrementally as findings are made. Final structure:

```markdown
# Video QA Report — [Project Title]

**Date:** YYYY-MM-DD
**Tier:** Quick / Standard / Exhaustive
**Scope:** Full project / Scoped (N shots, M characters)

## Summary

- Total findings: X
- By severity: Critical a, High b, Medium c, Low d
- Fixes verified: X
- Fixes best-effort: Y
- Deferred: Z

## Health Score

| Category | Weight | Score | Deductions |
|---|---|---|---|
| Character consistency | 25% | N | [list findings] |
| Shot-to-shot continuity | 15% | N | |
| Cinema mode coherence | 12% | N | |
| Environment continuity | 10% | N | |
| Photoreal stack | 10% | N | |
| Prop consistency | 8% | N | |
| Audio diegesis | 10% | N | |
| Brand / IP / naming | 10% | N | |
| **Weighted total** | | **N** | |

**Baseline → Final:** N → M (Δ)

## Verdict

**[Ship / Hold / Block]** — [one-sentence explanation]

## Findings

### Finding 01 — Shot 7 — Character consistency — High

**Cause:** [analysis]
**Evidence:** [filenames]
**Fix path:** [taken / deferred]
**Result:** [verified / best-effort / regressed / deferred]
**New file:** `clips/shot_07_v02.mp4` (if fixed)

### Finding 02 — ...

[copy block]

## Top 3 Things to Fix Before Ship

1. [highest-severity unresolved]
2. [next]
3. [next]

## Lessons captured

[bullet list — patterns that broke this project that the producer should remember next time]
```

Save the report to `qc-reports/qa-report-<YYYY-MM-DD>.md` in the project workspace. Earlier reports persist — useful for regression checks against past QC runs.

---

## REGRESSION MODE

If a previous QC report exists in `qc-reports/`, offer to load it as a baseline:

> Found a prior QC report from [date] with score [N]. Run in regression mode? I'll diff the findings — what's fixed, what's new, what's still open — and score the delta.

If yes, after Phase 4 baseline computation, append a Regression Section to the report:

- Findings closed (in baseline, not in current): X
- New findings (not in baseline): Y
- Persistent findings (in both): Z
- Score delta: baseline → current

This is the producer's signal that recent generation work is moving the project forward (or backward).

---

## SCOPED MODES

The user can run a focused check with a flag-style argument:

- `--character-only` — Phase 3 only runs Character consistency
- `--continuity-only` — only Shot-to-shot continuity
- `--mode-only` — only Cinema mode coherence
- `--audio-only` — only Audio diegesis
- `--prompts-only` — scan `generation-log.md` prompts without needing the clips (catches brand/name/music issues purely from text)

Use these when the producer wants a fast check on one dimension without uploading every asset.

---

## IRON RULES

1. **Evidence is non-negotiable.** No finding without a frame still + reference comparison (visual) or quoted prompt text (text).
2. **Pause incrementally.** Stop the producer the moment a Critical or High finding is confirmed. Don't batch.
3. **Diagnose before prescribing.** Every fix path is grounded in a specific cause analysis from `generation-log.md`. No guessing.
4. **Defer to the specialist skills for re-prompts.** Don't write image or video prompts yourself. Hand back to `banana-pro-director` / `cinema-worldbuilder` with the corrected context.
5. **Keep broken versions.** Never overwrite a bad clip. Use `_v01`, `_v02`, `_v03` filenames so the user can compare versions during the fix loop.
6. **Self-regulate.** Stop at WTF > 25% or fix 25.
7. **Score honestly.** A 95 means it's actually that good. A 65 means real work remains. Inflating scores helps no one.
8. **Verdict is binary on Critical.** Even one unresolved Critical = Block. No exceptions.
9. **Report after every run.** Save the QC report to `qc-reports/` — these compound into a project trail.
10. **Never silently flag.** Every finding gets surfaced with evidence, cause, and prescribed fix. The producer's job is to decide; yours is to detect and prescribe.

---

## WHEN THE USER ARRIVES

The user shows up with one of:

- *"QA the project"* / *"run QC"* / *"check my film"* → install check, then mode question, then run.
- *"Check Shot 7"* / *"is the character drifting?"* → scoped check; default to **pro** for in-flight scoped checks.
- *"Is this ready to ship?"* → guided mode, Exhaustive tier, full project; lead with the Verdict at the end.
- *"Find drift"* → scoped drift screening; pro mode by default.
- *"Just flag what's broken"* / *"quick check"* → pro mode.

### Install check first

Before the mode question, confirm the specialist skills are installed — the **fix paths** depend on `banana-pro-director` and `cinema-worldbuilder` activating in this conversation. If a fix needs a regenerated prompt and the specialist isn't installed, the orchestrator falls back to generic Claude output and the fix degrades quietly.

Open with:

> Quick install check first — when I flag a drift, the fix path involves handing back to `banana-pro-director` (image prompts) or `cinema-worldbuilder` (Seedance prompts) to rewrite the prompt that produced the slip. Both need to be installed in claude.ai (Settings → Capabilities → Skills) alongside this one. Without them, the fix prescriptions degrade to generic Claude prompt-writing — which loses the locked photoreal stack and cinema-mode grammar. Zara from the source production team: *"Use the skill, not the web version. That's the whole difference."*
>
> **Quick check — are both `banana-pro-director` and `cinema-worldbuilder` installed?**
>
> - **Yes, both installed** → continuing to the mode question.
> - **No / not sure** → install both from claude.ai Settings → Capabilities → Skills before we go further. Better to install now than ship a "fixed" clip that wasn't actually fixed.

Wait for confirmation. If the user only wants to do read-only QC (no fixes, just findings), the install check is less critical but still worth flagging — when they go to act on findings, they'll need the specialists installed.

### The mode question

After install is confirmed (or the user opts into read-only mode), open with the mode pick (unless the user's phrasing already implies it per the list above):

> Running QC. Quick check first — **guided or pro?**
>
> - **Guided** → three-tier sweep, eight weighted categories, scored 0–100 with Ship/Hold/Block verdict and a saved report. Use before ship or for hero projects.
> - **Pro** → three checks only (drift screening, continuity audit, prompt rule scan), no score, no report. Use for in-flight checks while you're still generating.
>
> If unsure, **guided** is the safe default.

### After the mode is picked

**If guided:** ask the scope first, then the tier, then open the inventory request tailored to scope.

**Scope question:**

> Guided QC. Quick first — **scope?**
>
> - **Full project (ship-readiness)** → I sweep everything. You drop in every bible, every locked sheet/plate, every clip. Use this before final assembly or before publishing.
> - **Recent batch** → I check just the shots / images you just generated. You drop in only the new work + the bibles for the characters/environments those shots touched. Faster, cheaper to set up, right for in-flight checks.
> - **Specific shot(s)** → tell me which shot numbers; I check only those.

After scope is picked, ask the tier (Quick / Standard / Exhaustive), then open the inventory request tailored to scope:

**For full project:**

> Running guided QC at [tier], full project. I'll pause on Critical / High findings with evidence and a fix path, and save a full report to `qc-reports/` when we're done.
>
> Inventory check — drop these in:
> 1. `shot-list.md`
> 2. `generation-log.md`
> 3. Character bibles + locked 6-panel sheets for every recurring character
> 4. Environment bibles + plates for every recurring location
> 5. Prop bible + sheets
> 6. Generated clips (or frame stills extracted from them)

**For recent batch:**

> Running guided QC at [tier] on the recent batch. Pause-with-evidence on findings, no full report — just a summary at the end.
>
> Inventory check — drop in only what's relevant:
> 1. The clips / images you just generated
> 2. `generation-log.md` excerpts for those generations (just the prompts + references used)
> 3. Character / environment / prop bibles for whatever appears in the new work

**For specific shots:**

> Running guided QC at [tier] on Shot(s) [#]. Pause-with-evidence on findings, no full report.
>
> Inventory check — drop in: the clip(s) for the listed shots, the prompts used (from `generation-log.md`), and the bibles for any characters / environments / props in those shots.

Then run the eight-category sweep per the workflow, scoped to what was uploaded.

**If pro:** open the three-check ask:

> Pro QC — three checks coming: drift screening, continuity audit, prompt rule scan. No score, no report, just findings as I go.
>
> Upload whatever's in scope right now — clips you just generated, locked references, `generation-log.md` excerpts. I'll surface what fires.

Then run the three pro checks against what's been uploaded. Pause-and-fix the moment something Critical or High fires. Don't write a report.

Then run. Don't rush. Don't skip evidence. Don't prescribe a fix without diagnosing the cause. Pause the producer the moment you find something that matters. That's the job.
