# <Project>: how to work here

For any coding agent (Claude Code reads it through `CLAUDE.md`). Paths are relative to the repo root.

<One or two lines: what this is, the stack, the deployables.>

## Start here
- Read `agents/context/now.md` (what we're on, what's next) and `agents/context/map.md` (where things are). Nothing else until needed.
- Never read big docs whole: find the section in `agents/context/docs-index.md`, read only that.
- Don't read `node_modules/`, build output or scratch folders unless asked for a specific file.

## Keep the context current (in the same commit as the work)
- Doing / next / blocked → `agents/context/now.md` (overwrite, keep it short).
- A small bug or fix → `agents/context/todo.md` (one line; delete when done).
- A decision or plan item → <the plan doc § section>.
- A doc moved → `docs-index.md`; a command or entry file changed → `map.md`.
- End of a session: a ≤1 KB note in `agents/context/log/YYYY-MM-DD.md`; keep the last 5.
- `.claude/` entries (skills, agents, commands) live in `agents/` and are symlinked from `.claude/`.

## Rules (from the owner)
- <The owner's standing rules: testing, commits, merges, UI conventions…>

## Keep tokens low
- One task per session: update now.md and the log, commit, then `/clear`.
- Listings: the Glob tool or `command ls -1`. Output: `| tail -n 20` / `| grep`; long runs to a file.
- Big files: `grep -n`, read the range, small Edits; never rewrite a large file.
- Screenshots only when a number can't answer; clipped; one per check.
- Tests as background commands read by summary; a tester subagent only when a run needs judgement.

## Subagents
- Point them at `agents/context/` and the doc section; ask for a ≤20-line report with file:line refs; big output to a file.
- Worktrees copy the last commit: commit context changes first.
