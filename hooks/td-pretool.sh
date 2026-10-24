#!/bin/sh
# PreToolUse hook (Claude Code / Codex): route noisy Bash commands through
# td-exec-wrapper.sh. No-op when jq is missing, when rtk is installed (rtk owns
# output compression; set TD_HOOK_FORCE=1 to override), or when the command
# already pipes, chains, or changes directory.
command -v jq >/dev/null 2>&1 || exit 0
if [ -z "$TD_HOOK_FORCE" ] && command -v rtk >/dev/null 2>&1; then exit 0; fi

cmd=$(jq -r '.tool_input.command // empty')
[ -n "$cmd" ] || exit 0
case "$cmd" in *'|'*|*'&&'*|*';'*|*'>'*|cd\ *|*td-exec-wrapper*) exit 0 ;; esac
first=${cmd%% *}
case "$first" in
  npm|pnpm|yarn|bun|npx|pytest|cargo|go|jest|vitest|tsc|eslint|ruff|mypy|make|gradle|./gradlew|mvn|pip|pip3|uv|docker|dotnet|swift|xcodebuild) ;;
  *) exit 0 ;;
esac

wrapper="$(cd "$(dirname "$0")/.." && pwd)/scripts/td-exec-wrapper.sh"
quoted=$(printf '%s' "$cmd" | sed "s/'/'\\\\''/g")
jq -n --arg c "'$wrapper' sh -c '$quoted'" \
  '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecisionReason:"token-disciplinarian output filter",updatedInput:{command:$c}}}'
