# claude-skills

My Claude Code skills, as one plugin. Each skill is a folder in `skills/`: `skills/<name>/SKILL.md` plus its
templates or scripts.

| Skill | What it does |
| --- | --- |
| [agent-context](skills/agent-context/SKILL.md) | Sets up or audits lean, git-tracked agent context for a project: `AGENTS.md` with the rules, `CLAUDE.md` importing it, and `agents/context/` (now, map, docs index, todo, log), with token-saving habits. |

## Install
```
/plugin marketplace add dangeezz/claude-skills
/plugin install claude-skills@claude-skills
```
Or link one skill without the plugin system: `ln -s <this repo>/skills/<name> ~/.claude/skills/<name>`.

## Add a skill
A new folder `skills/<name>/` with a `SKILL.md` (frontmatter `name` and `description`), a row in the table above,
and a version bump in `.claude-plugin/plugin.json`.
