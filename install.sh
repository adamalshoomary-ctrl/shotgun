#!/bin/sh
# Installs the handoff kit for every coding agent on this machine that reads the Agent
# Skills standard.
#
# The skill needs its whole directory, not just SKILL.md. VERSION, MIGRATIONS.md,
# SETUP.md, CONTINUE.md, LEARNING.md, ORCHESTRATION.md, VOICE.md and templates/ all
# travel with it, and every command fails without them.
#
# Most people should use the ecosystem installer instead:
#
#   npx skills add adamalshoomary-ctrl/shotgun
#
# This script exists for anyone without node, or who would rather read the thing
# before running it:
#
#   sh install.sh                           from a clone
#   curl -fsSL <raw url>/install.sh | sh    without one
set -e

REPO="https://github.com/adamalshoomary-ctrl/shotgun"
SRC="$(cd "$(dirname "$0")" && pwd)"

# Files the skill reads at runtime. Keep this list in step with SKILL.md.
FILES="SKILL.md VERSION MIGRATIONS.md SETUP.md CONTINUE.md LEARNING.md ORCHESTRATION.md VOICE.md"

TMP=""
if [ ! -f "$SRC/VERSION" ] || [ ! -d "$SRC/templates" ]; then
  command -v git >/dev/null 2>&1 || {
    echo "This script needs either a full clone or git on PATH." >&2
    echo "Install with: npx skills add adamalshoomary-ctrl/shotgun" >&2
    exit 1
  }
  TMP="$(mktemp -d)"
  git clone --depth 1 --quiet "$REPO" "$TMP/shotgun"
  SRC="$TMP/shotgun"
fi

# Claude Code reads ~/.claude/skills. Codex, Gemini CLI, Copilot, Cursor and the rest
# of the Agent Skills adopters read ~/.agents/skills.
for DEST in "$HOME/.claude/skills/handoff" "$HOME/.agents/skills/handoff"; do
  mkdir -p "$DEST"
  for F in $FILES; do
    cp "$SRC/$F" "$DEST/$F"
  done
  rm -rf "$DEST/templates"
  cp -R "$SRC/templates" "$DEST/templates"
  echo "installed: $DEST"
done

[ -n "$TMP" ] && rm -rf "$TMP"

cat <<'DONE'

Restart your agent so it picks the skill up, then open a project folder and run:

  /handoff setup     Claude Code
  $handoff setup     Codex

DONE
