# Token habits (pick what fits; write them into AGENTS.md)
- One task per session; at the end wrap up (update now.md and the log, commit), then clear the context
  (`/clear` in Claude Code).
- Listings with the agent's file-search tool or `command ls -1` (shells with eza/colour aliases flood output).
- Output through `tail`/`grep`; long runs to a file, read the summary and failures.
- Big files: `grep -n`, read the range, change with small Edits; never rewrite or paste over a large file.
- Screenshots only when a number can't answer; clipped; one per check.
- Tests as background commands read by summary; a tester subagent only when the run needs judgement.
- Subagents: point at agents/context and the doc section; ask for ≤20-line reports with file:line refs; big
  output to a file. Worktrees copy the last commit: commit context first. Cheap models for tests and lookups.
- Split large single-file prototypes/pages into html + css/ + scripts/ so edits touch less.
- Turn off connectors (MCP servers) the project doesn't use: their tools ride along on every turn.
