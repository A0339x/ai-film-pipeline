#!/usr/bin/env bash
# new-project.sh — scaffold a new AI Film Pipeline project workspace
#
# Usage:
#   ./scripts/new-project.sh <project-name>
#
# Example:
#   ./scripts/new-project.sh bmw-m5-spot
#   ./scripts/new-project.sh kpop-music-video-2026
#
# Creates projects/<project-name>/ with the full template structure ready
# for the orchestrator to lead a producer through. Idempotent — won't
# overwrite an existing project folder.

set -euo pipefail

# --- arg check ---
if [ $# -lt 1 ]; then
  echo "Usage: $0 <project-name>"
  echo ""
  echo "Project names should be lowercase-with-hyphens, no spaces."
  echo "Examples:"
  echo "  $0 bmw-m5-spot"
  echo "  $0 kpop-music-video"
  echo "  $0 perfume-brand-30s"
  exit 1
fi

PROJECT_NAME="$1"

# --- validate name ---
if [[ ! "$PROJECT_NAME" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
  echo "Error: project name must be lowercase letters, numbers, and hyphens only."
  echo "Got: '$PROJECT_NAME'"
  echo "Try something like: ${PROJECT_NAME// /-} or $(echo "$PROJECT_NAME" | tr '[:upper:] ' '[:lower:]-')"
  exit 1
fi

# --- locate repo root (script lives in scripts/, so repo is one level up) ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_DIR="$REPO_ROOT/projects/$PROJECT_NAME"

# --- check it doesn't already exist ---
if [ -d "$PROJECT_DIR" ]; then
  echo "Error: project '$PROJECT_NAME' already exists at:"
  echo "  $PROJECT_DIR"
  echo ""
  echo "Either pick a different name or remove the existing folder first."
  exit 1
fi

# --- verify templates exist ---
if [ ! -d "$REPO_ROOT/templates" ]; then
  echo "Error: can't find templates/ at repo root."
  echo "Are you running this script from inside the ai-film-pipeline repo?"
  echo "Expected location: $REPO_ROOT/templates/"
  exit 1
fi

# --- create folder structure ---
mkdir -p "$PROJECT_DIR"/{references/characters,references/environments,references/props,references/titles,clips,audio,prompts,qc-reports}

# --- copy templates with placeholder names ---
cp "$REPO_ROOT/templates/character-bible.md"    "$PROJECT_DIR/character-bible-CHARACTER.md"
cp "$REPO_ROOT/templates/environment-bible.md"  "$PROJECT_DIR/environment-bible-LOCATION.md"
cp "$REPO_ROOT/templates/prop-bible.md"         "$PROJECT_DIR/prop-bible.md"
cp "$REPO_ROOT/templates/shot-list.md"          "$PROJECT_DIR/shot-list.md"
cp "$REPO_ROOT/templates/generation-log.md"     "$PROJECT_DIR/generation-log.md"
cp "$REPO_ROOT/templates/suno-music-prompt.md"  "$PROJECT_DIR/suno-music-prompt.md"
cp "$REPO_ROOT/templates/title-card-prompt.md"  "$PROJECT_DIR/title-card-prompt.md"

# --- stub a per-project README ---
cat > "$PROJECT_DIR/README.md" <<EOF
# $PROJECT_NAME

Project workspace scaffolded $(date '+%Y-%m-%d') by \`scripts/new-project.sh\`.

## Get started

1. **Rename the placeholder bibles.** Currently you have:
   - \`character-bible-CHARACTER.md\` — rename to \`character-bible-<your-character-working-name>.md\` (one file per recurring character, copy this stub for each)
   - \`environment-bible-LOCATION.md\` — rename to \`environment-bible-<your-location-working-name>.md\` (one file per recurring location)
2. **Open this folder** in Claude Code, or open claude.ai with the four skills installed.
3. **Tell the orchestrator:** *"Working on $PROJECT_NAME"* (or just describe what you're making — \`ai-film-director\` will pick up from there).

## Folder map

| Path | Purpose |
|---|---|
| \`character-bible-*.md\` | Per-character locked spec (visual descriptor, looks, prompts used, reference filenames) |
| \`environment-bible-*.md\` | Per-location locked spec (description, lighting, set dressing, plate filename, prompt used) |
| \`prop-bible.md\` | Shared file with one entry per hero prop/creature/vehicle |
| \`shot-list.md\` | The film mapped beat by beat — every shot's runtime, mode, characters, references, what-happens, connects-from/to |
| \`generation-log.md\` | Every generation attempt — prompt, refs, result, kept/wasted, credits, why |
| \`suno-music-prompt.md\` | Suno music style + lyric template (filled in during Phase 6) |
| \`title-card-prompt.md\` | Title card creative brief for banana-pro-director (filled in during Phase 6 if title needed) |
| \`references/characters/<name>/\` | Locked character sheets and look variants |
| \`references/environments/<location>/\` | Locked environment plates and alternate angles |
| \`references/props/<name>/\` | Locked prop sheets (vehicle, creature, hero object) |
| \`references/titles/\` | Title card images if generated |
| \`clips/\` | Generated Seedance video clips |
| \`audio/\` | Suno track + diegetic SFX from libraries |
| \`prompts/\` | Saved prompt text per shot (optional, for traceability) |
| \`qc-reports/\` | Saved video-qa reports for this project |

## What's gitignored

This entire \`projects/$PROJECT_NAME/\` folder is gitignored by default. Project content (bibles, references, clips) is personal — it doesn't get committed to the public repo. If you ever want to share a project as an example, add it explicitly to git with \`git add -f\`.

## Notes for this project

(Replace this section with anything project-specific you want to remember — client, deadline, deliverable specs, etc.)
EOF

# --- summary output ---
echo "✓ Created project '$PROJECT_NAME' at:"
echo "  $PROJECT_DIR"
echo ""
echo "Folder structure:"
echo "  projects/$PROJECT_NAME/"
echo "  ├── README.md (project notes)"
echo "  ├── character-bible-CHARACTER.md   ← rename per character"
echo "  ├── environment-bible-LOCATION.md  ← rename per location"
echo "  ├── prop-bible.md"
echo "  ├── shot-list.md"
echo "  ├── generation-log.md"
echo "  ├── suno-music-prompt.md"
echo "  ├── title-card-prompt.md"
echo "  ├── references/{characters,environments,props,titles}/"
echo "  ├── clips/"
echo "  ├── audio/"
echo "  ├── prompts/"
echo "  └── qc-reports/"
echo ""
echo "Next:"
echo "  1. cd projects/$PROJECT_NAME"
echo "  2. Rename the placeholder bibles to match your project's working names"
echo "  3. Open Claude Code in this folder, or open claude.ai — start the orchestrator"
