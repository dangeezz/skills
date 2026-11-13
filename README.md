# skills

My agent skills, for any coding agent that reads `SKILL.md` skills (Claude Code, Codex, Cursor, Gemini CLI,
OpenCode…). Each skill is a folder in `skills/`: `skills/<name>/SKILL.md` plus its templates or scripts.

| Skill | What it does |
| --- | --- |
| [lean-context](skills/lean-context/SKILL.md) | Keeps agents' context window small by setting up or auditing lean, git-tracked project context: `AGENTS.md` with the rules (plus a one-line `CLAUDE.md` import for Claude Code), and `agents/context/` (now, map, docs index, todo, log), with token-saving habits. |

## Install
With the [skills](https://github.com/vercel-labs/skills) CLI, for any supported agent (`-g` installs globally,
leave it out for the current project):
```
npx skills add dangeezz/skills --skill lean-context -g
```

As a Claude Code plugin (all skills at once):
```
/plugin marketplace add dangeezz/skills
/plugin install skills@skills
```

Or link one skill by hand into your agent's skills folder, e.g. `ln -s <this repo>/skills/<name> ~/.claude/skills/<name>`.

## Add a skill
A new folder `skills/<name>/` with a `SKILL.md` (frontmatter `name` and `description`), a row in the table above,
and a version bump in `.claude-plugin/plugin.json`. Tests for a skill go in `tests/<name>/` (not shipped with
the skill); see [tests/lean-context](tests/lean-context/README.md).

## Licence
MIT, see [LICENSE](LICENSE).
