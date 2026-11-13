---
name: lean-context
description: Keep coding agents' context window small. Sets up, audits or wraps up lean, git-tracked project context so any session or subagent gets oriented in about 2–3k tokens instead of reading the docs — AGENTS.md with the rules, CLAUDE.md importing it, an agents/ folder (context/, memory/, agents/, skills/) with size-capped now/map/docs-index/todo/log, .claude/ entries symlinked into agents/ — plus token-saving habits. Use when starting a project, when sessions spend many tokens getting oriented or fill the context window, when work continues on another machine, at the end of a session to wrap up, or when the user asks for this "lean context" setup.
---

# Lean context: a small context window, tracked in git, shared with subagents

Goal: any session (or subagent, any machine, any coding agent) learns what the project is, what's going on and
how to work in about 2–3k tokens, instead of reading the docs; and every change to that context is in git.
Paths below are relative to this skill's folder (`references/`, `scripts/`, `templates/`) or to the repo root.

## Layout (inside the git repo)
```
<repo>/
  AGENTS.md            rules for any coding agent (Codex, Cursor… read it directly)
  CLAUDE.md            one line: @AGENTS.md   (Claude Code imports it; subagents get it too)
  agents/
    context/           now.md, map.md, docs-index.md, todo.md, README.md, log/YYYY-MM-DD.md
    memory/            lasting notes for agents (why an approach was dropped…), when first needed
    agents/            subagent definitions (*.md), when first needed
    skills/            project skills, when first needed
  .claude/agents -> ../agents/agents     relative symlinks: agents/ stays the one source
  .claude/skills -> ../agents/skills
```

## Modes
- **Setup**: no `agents/context/` yet → Steps below.
- **Audit**: `agents/context/` exists → same Steps, but update the files in place; never copy templates over them.
- **Wrap-up**: end of a session, or the user says "wrap up" → follow `references/wrap-up.md` only.

## Steps
1. Look first: `git status`; doc sizes (`wc -c` on the .md files, skipping `.agents/`, `node_modules/`, build
   output); the package layout and the scripts in package.json (or the build file). Then check for each of
   these, and if any exists read `references/edge-cases.md` before going on:
   AGENTS.md or CLAUDE.md with content · `.claude/CLAUDE.md` · CLAUDE.local.md · AGENTS.md in subfolders ·
   GEMINI.md, `.github/copilot-instructions.md`, `.cursor/rules/`, `.windsurfrules` · a real `.claude/agents`
   or `.claude/skills` folder · `.agents/skills/` or `skills-lock.json` · an `agents/` folder used for something
   else · Windows · sessions that start one folder above the repo.
2. Copy `templates/` into the repo and fill them from the code, the docs and the conversation. Keep only current
   truth, but never drop the owner's text: ask before removing a rule that looks stale. Caps: AGENTS.md ≤3.5 KB,
   now ≤2 KB, map ≤3 KB, docs-index ≤2 KB, todo ≤3 KB, each log note ≤1 KB (last 5 kept); total ≤12 KB.
   Create `memory/`, `agents/`, `skills/` and their links when first needed, or now if the owner asks.
3. Owner rules: under "Rules (from the owner)" put only rules the owner gave for this project, moved out of the
   agent's local memory (it doesn't travel; leave it one note pointing at the repo). Not the owner's global
   preferences (~/.claude/CLAUDE.md, user-level memory) unless they ask; not this skill's own conventions;
   nothing personal or secret. Ask if unsure. No rules yet → leave the placeholder.
4. docs-index: one row per topic → `file § heading`, so a session reads a section, not a whole doc. If the plan
   doc is large, move finished phases to `docs/archive/` and leave a short "open from earlier phases" list.
5. Retire loose notes files (fixes.txt, hand-over.md…): open items into todo.md, done ones dropped; ask before
   deleting anything untracked.
6. Check, and fix until clean: `sh scripts/check-sizes.sh` (no OVER lines) and `sh scripts/check-secrets.sh`
   (no hits in the files you wrote). A fresh session can say what we're on and what's next from now.md alone.
7. Ask the owner before committing: show the file list and the before/after of any AGENTS.md / CLAUDE.md that
   existed. Then one commit, staging only the files this skill touched; no push unless asked. Tell the owner
   the undo: `git revert <that commit>` (the old files come back, the links go).
   From then on, context changes go in the same commit as the work.

## Token habits
The AGENTS.md template carries the core habits; keep them, adjust to the project. Add from
`references/token-habits.md` the ones that fit (subagents, tests, screenshots, big files, connectors).
