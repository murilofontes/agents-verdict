#!/usr/bin/env bash
# Installs the agents-verdict skill to ~/.claude/skills/ (Claude Code personal skills)

set -e

SKILL_SRC="$(cd "$(dirname "$0")/skill" && pwd)/SKILL.md"
SKILL_DST="$HOME/.claude/skills/agents-verdict"

mkdir -p "$SKILL_DST"
cp "$SKILL_SRC" "$SKILL_DST/SKILL.md"

echo "Skill installed: $SKILL_DST/SKILL.md"
echo "Reload in Claude Code with: /reload-skills"
