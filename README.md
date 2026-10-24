# token-disciplinarian

Plugin for Claude Code, Codex CLI, and Gemini CLI. Enforces aggressive, zero-bloat token reduction rules: surgical file reading, strict terminal/log filtering, caveman-concise output, subagent delegation for exploration, and context-window hygiene.

## Install

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
