# Wrap-up (end of a session)
Short: a few hundred tokens of writing, no re-reading of the project.
1. now.md: overwrite with what's in progress, what's next, what waits on the owner; today's date in the title.
2. Log: a ≤1 KB note in `agents/context/log/YYYY-MM-DD.md` (append if today's exists): what changed and why,
   what's open. Delete the oldest notes beyond 5.
3. todo.md: delete the items this session fixed; add new small ones (one line each).
4. map.md / docs-index.md: only if a command, entry file or doc moved.
5. `sh <this skill>/scripts/check-sizes.sh` and `sh <this skill>/scripts/check-secrets.sh`: fix any OVER or hit.
6. Commit the context with the session's work (ask first if the owner hasn't said to commit); then suggest
   clearing the context.
