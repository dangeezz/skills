---
name: agent-context
description: Set up (or audit) lean, git-tracked agent context in a project — AGENTS.md with the rules, CLAUDE.md importing it, an agents/ folder (context/, memory/, skills/) with now/map/docs-index/todo/log, .claude/ entries symlinked into agents/, and token-saving habits. Use when starting a project, when sessions spend many tokens getting oriented, when the user wants to continue work on another machine, or asks to reuse this "agent context" architecture.
---

# Agent context: lean, tracked, shared with subagents

Goal: any session (or subagent, any machine, any coding agent) learns what the project is, what's going on and
how to work in about 2–3k tokens, instead of reading the docs; and every change to that context is in git.

## Layout (inside the git repo)
```
<repo>/
  AGENTS.md            rules for any coding agent (Codex, Cursor… read it directly)
  CLAUDE.md            one line: @AGENTS.md   (Claude Code imports it; subagents get it too)
  agents/
    context/           now.md, map.md, docs-index.md, todo.md, README.md, log/YYYY-MM-DD.md
    memory/            lasting notes for agents (why an approach was dropped…), when first needed
    skills/            project skills, when first needed
  .claude/skills -> ../agents/skills     symlinks only: agents/ stays the one source
```
If sessions may start one folder up (a product folder holding the repo and an untracked scratch folder), put an
`AGENTS.md` there that says where the repo is and ends with `@<repo>/AGENTS.md`, and a `CLAUDE.md` of `@AGENTS.md`.

## Steps
1. Look first: `git status`; existing AGENTS.md / CLAUDE.md (never overwrite a non-empty one: merge); doc sizes
   (`wc -c` on the .md files); the package layout and the scripts in package.json (or the build file).
2. Copy the templates from this skill's `templates/` into the repo and fill them from the code, the docs and
   the conversation. Keep only current truth; caps: AGENTS.md ≤3.5 KB, now ≤2 KB, map ≤3 KB, docs-index ≤2 KB,
   todo ≤3 KB, each log note ≤1 KB (last 5 kept). Total ≤12 KB.
3. Move the user's standing rules out of the agent's local memory into AGENTS.md (local memory doesn't travel);
   leave memory a single note pointing at the repo.
4. docs-index: one row per topic → `file § heading`, so a session reads a section, not a whole doc. If the plan
   doc is large, move finished phases to `docs/archive/` (or the project's docs folder) and leave a short
   "open from earlier phases" list.
5. Retire loose notes files (fixes.txt, hand-over.md…): open items into todo.md, done ones dropped; ask before
   deleting anything untracked.
6. Commit it all in one commit. From then on, context changes go in the same commit as the work.
7. Check: `wc -c AGENTS.md CLAUDE.md agents/context/*.md`; a fresh session can say what we're on and what's next
   from now.md alone.

## Token habits (write them into AGENTS.md; adjust to the project)
- One task per session; at the end update now.md and the log, commit, `/clear`.
- Listings with the Glob tool or `command ls -1` (shells with eza/colour aliases flood output).
- Output through `tail`/`grep`; long runs to a file, read the summary and failures.
- Big files: `grep -n`, read the range, change with small Edits; never rewrite or paste over a large file.
- Screenshots only when a number can't answer; clipped; one per check.
- Tests as background commands read by summary; a tester subagent only when the run needs judgement.
- Subagents: point at agents/context and the doc section; ask for ≤20-line reports with file:line refs; big
  output to a file. Worktrees copy the last commit: commit context first. Cheap models for tests and lookups.
- Split large single-file prototypes/pages into html + css/ + scripts/ so edits touch less.
- Turn off connectors (MCP servers) the project doesn't use: their tools ride along on every turn.
