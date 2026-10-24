# Changelog

## 1.2.0 - 2026-10-24
- Skill: subagent firewall (briefs under 150 tokens, receipt-only returns, `/tmp/td-scratch-<id>.md` file-bus).
- Skill: parallel swarm rules (shared repo map, disjoint `ALLOWED_WRITES`, 3–4 workers per wave).
- Skill: fail-fast flags per tool, 2-strike circuit breaker, task-boundary checkpoints, cache-prefix rules.
- Skill: merged and reorganized into 8 protocols, duplicate rules removed.
- `scripts/td-exec-wrapper.sh`: strips ANSI codes and progress bars, collapses repeated lines, truncates output over 60 lines.
- `hooks/`: `PreToolUse` hook for Claude Code and Codex that routes build/test commands through the wrapper (skipped when `rtk` is installed).
- MIT license.

## 1.1.0
- Codex plugin, Gemini CLI extension, and Antigravity CLI plugin manifests.
- Install steps for `npx skills`.

## 1.0.0
- Initial Claude Code plugin and marketplace.
