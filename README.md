# token-disciplinarian

Plugin for Claude Code, Codex CLI, and Gemini CLI. Enforces aggressive, zero-bloat token reduction rules: surgical file reading, strict terminal/log filtering, caveman-concise output, subagent delegation for exploration, and context-window hygiene.

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

### Antigravity (IDE and CLI)
Antigravity does not load Gemini CLI extensions; install the skill directly:
```
npx skills add shadowhelper93/token-disciplinarian -g -y --agent antigravity antigravity-cli
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

- `skills/token-disciplinarian/SKILL.md`: the token-efficiency protocol (shared by all three).
- `.claude-plugin/`: Claude Code plugin + marketplace manifests.
- `.codex-plugin/plugin.json`, `.agents/plugins/marketplace.json`: Codex plugin + marketplace.
- `gemini-extension.json`: Gemini CLI extension (loads the skill as context).
