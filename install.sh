#!/bin/sh
# Installs the handoff skill for every coding agent on this machine that reads the
# Agent Skills standard. One SKILL.md, copied to each platform's own directory.
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

REPO="https://raw.githubusercontent.com/adamalshoomary-ctrl/shotgun/main"
SRC="$(dirname "$0")/SKILL.md"

TMP=""
if [ ! -f "$SRC" ]; then
  TMP="$(mktemp -d)"
  SRC="$TMP/SKILL.md"
  curl -fsSL "$REPO/SKILL.md" -o "$SRC"
fi

# Claude Code reads ~/.claude/skills. Codex, Gemini CLI, Copilot, Cursor and the rest
# of the Agent Skills adopters read ~/.agents/skills.
for DEST in "$HOME/.claude/skills/handoff" "$HOME/.agents/skills/handoff"; do
  mkdir -p "$DEST"
  cp "$SRC" "$DEST/SKILL.md"
  echo "installed: $DEST/SKILL.md"
done

[ -n "$TMP" ] && rm -rf "$TMP"

cat <<'DONE'

Restart your agent so it picks the skill up, then open a project folder and run:

  /handoff setup     Claude Code
  $handoff setup     Codex

DONE
