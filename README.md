# agent-context

A Claude Code plugin with one skill, `agent-context`: it sets up (or audits) lean, git-tracked context for a
project, so any session, subagent or coding agent gets oriented in about 2–3k tokens, on any machine.

- `AGENTS.md`: the rules, for any coding agent; `CLAUDE.md` is one line, `@AGENTS.md`.
- `agents/context/`: `now.md`, `map.md`, `docs-index.md`, `todo.md`, `log/`, kept current in the same commit as the work.
- `.claude/` entries are symlinks into `agents/`, so `agents/` stays the one source.
- Token habits: one task per session, trimmed output, read by range, small edits, fewer screenshots.

## Install
```
/plugin marketplace add dangeezz/agent-context
/plugin install agent-context@agent-context
```
Or, without the plugin system, link the skill: `ln -s <this repo>/skills/agent-context ~/.claude/skills/agent-context`.

## Use
"Set up agent context for this project", or "audit the agent context". The skill and its templates are in
`skills/agent-context/`.
