# token-disciplinarian

Plugin for Claude Code, Codex CLI, Gemini CLI, and Antigravity. Enforces aggressive, zero-bloat token reduction rules: surgical file reading, strict terminal/log filtering, caveman-concise output, subagent delegation for exploration, and context-window hygiene.

## Features

- **Zero-context subagent firewall:** subagent briefs under 150 tokens: objective, exact `file:line` targets, output schema. No history.
- **Receipt-only returns:** subagents reply in a fixed under-80-token `STATUS / TOUCHED / FINDINGS / SCRATCHPAD` receipt.
- **Blackboard file-bus:** large subagent payloads go to `/tmp/td-scratch-<id>.md`; the parent reads only the slices it needs.
- **Disjoint parallel swarms:** one shared repo map, mutually exclusive `ALLOWED_WRITES` per worker, 3–4 workers per wave.
- **Fail-fast circuit breakers:** mandatory bail/quiet flags, a 2-strike stop on repeated failures, and checkpoints at task boundaries.
- **Output truncation hook:** `scripts/td-exec-wrapper.sh` strips ANSI codes and progress bars, collapses repeated lines, and keeps only the first and last 20 lines of long output (full log saved to `/tmp/td-last-cmd.log`). Claude Code and Codex run it as a `PreToolUse` hook for build/test commands. The hook steps aside when [`rtk`](https://github.com/rtk-ai/rtk) is installed; set `TD_HOOK_FORCE=1` to run it anyway. Other hosts can pipe output through it: `<cmd> 2>&1 | scripts/td-exec-wrapper.sh`.

## Install

### Any agent, via npx
Installs the skill into Claude Code, Codex, Gemini CLI, Cursor, and other agents supported by [`skills`](https://www.npmjs.com/package/skills):
```
npx skills add shadowhelper93/token-disciplinarian
```
Global, all agents, no prompts:
```
npx skills add shadowhelper93/token-disciplinarian -g --all
```

### Antigravity
CLI (`agy`):
```
agy plugin install https://github.com/shadowhelper93/token-disciplinarian
```
Antigravity IDE (skill only):
```
npx skills add shadowhelper93/token-disciplinarian -g -y --agent antigravity
```

### Claude Code
```
/plugin marketplace add shadowhelper93/token-disciplinarian
/plugin install token-disciplinarian@token-disciplinarian
```

### Codex CLI
```
codex plugin marketplace add shadowhelper93/token-disciplinarian
codex plugin add token-disciplinarian@token-disciplinarian
```

### Gemini CLI
```
gemini extensions install https://github.com/shadowhelper93/token-disciplinarian
```

## Contents

- `skills/token-disciplinarian/SKILL.md`: the token-efficiency protocol (shared by every target).
- `.claude-plugin/`: Claude Code plugin + marketplace manifests.
- `.codex-plugin/plugin.json`, `.agents/plugins/marketplace.json`: Codex plugin + marketplace.
- `gemini-extension.json`: Gemini CLI extension (loads the skill as context).
- `.antigravity-plugin/plugin.json`: Antigravity CLI plugin.
- `scripts/td-exec-wrapper.sh`: POSIX output filter (no dependencies).
- `hooks/hooks.json`, `hooks/td-pretool.sh`: Claude Code + Codex `PreToolUse` hook (needs `jq`).

## License

MIT. See [CHANGELOG.md](CHANGELOG.md) for release notes.
