#!/bin/sh
# Look for secrets in agent context before committing. Run from the repo root.
# Usage: sh <skill>/scripts/check-secrets.sh [files...]
# Default: AGENTS.md, CLAUDE.md, GEMINI.md and everything under agents/ (or the folder given as $CONTEXT_DIR).
root="${CONTEXT_DIR:-agents}"
if [ $# -eq 0 ]; then
  set -- $(ls AGENTS.md CLAUDE.md GEMINI.md 2>/dev/null) $(find "$root" -type f -name '*.md' 2>/dev/null)
fi
[ $# -eq 0 ] && { echo "no files to check"; exit 0; }
pat='AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY|gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|sk-[A-Za-z0-9_-]{20,}|xox[abprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{35}|(api[_-]?key|secret|token|passw(or)?d)["'"'"' ]*[:=] *["'"'"']?[A-Za-z0-9_/+=.-]{12,}|[a-z]+://[^ /:@]+:[^ /@]+@'
hits=$(grep -nIE "$pat" "$@" 2>/dev/null)
mails=$(grep -nIoE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$@" 2>/dev/null | grep -v 'noreply@')
[ -n "$mails" ] && { echo "WARN  email addresses (fine if meant to be public):"; echo "$mails"; }
if [ -n "$hits" ]; then echo "HIT   possible secrets:"; echo "$hits"; exit 1; fi
echo "ok    no secrets found in $# file(s)"
