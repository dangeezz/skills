#!/bin/sh
# Check a fixture after /lean-context ran in scratch/<fixture>.
# Usage (from the repo root): sh tests/lean-context/check.sh <fixture>|all
repo=$(cd "$(dirname "$0")/../.." && pwd)
skill="$repo/skills/lean-context"
[ "$1" = all ] && set -- $(command ls -1 "$repo/scratch")
total=0
for name in "$@"; do
  d="$repo/scratch/$name"; [ -d "$d" ] || { echo "not prepared: $name"; total=1; continue; }
  cd "$d"; fail=0
  ok()  { echo "  ok    $1"; }
  bad() { echo "  FAIL  $1"; fail=1; }
  has() { grep -rqF --exclude-dir=.git --exclude-dir=.agents "$1" ${2:-.} && ok "$3" || bad "$3"; }
  echo "== $name"
  # context folder: agents/context, or the renamed one for agents-app
  ctx=$(find . -path ./.git -prune -o -path ./.agents -prune -o -name now.md -print | head -1 | xargs dirname 2>/dev/null)
  [ -n "$ctx" ] && ok "context folder: $ctx" || bad "no now.md anywhere"
  [ -f AGENTS.md ] && ok "AGENTS.md" || bad "no AGENTS.md"
  head -1 CLAUDE.md 2>/dev/null | grep -q '^@AGENTS.md' || [ -L CLAUDE.md ] && ok "CLAUDE.md imports AGENTS.md" || bad "CLAUDE.md doesn't start with @AGENTS.md"
  [ -n "$ctx" ] && { sh "$skill/scripts/check-sizes.sh" "$ctx" >/tmp/lc-sizes.$$ 2>&1 && ok "sizes" || { bad "sizes"; grep OVER /tmp/lc-sizes.$$; }; rm -f /tmp/lc-sizes.$$; }
  CONTEXT_DIR="${ctx#./}" sh "$skill/scripts/check-secrets.sh" >/dev/null 2>&1; [ $? -eq 0 ] && ok "no secrets" || bad "secrets"
  [ -L .claude/skills/lean-context ] && ok "CLI link kept" || bad ".claude/skills/lean-context is no longer the CLI's link"
  git diff --quiet HEAD -- skills-lock.json 2>/dev/null; [ -f skills-lock.json ] && ok "skills-lock.json kept" || bad "skills-lock.json gone"
  grep -q 'Co-Authored-By\|AI attribution' AGENTS.md 2>/dev/null && bad "a global preference leaked into AGENTS.md" || ok "no global preferences copied"
  case $name in
    full-claude-md)
      has MARKER-RULE-1 AGENTS.md "rule 1 moved to AGENTS.md"; has MARKER-RULE-2 AGENTS.md "rule 2 moved to AGENTS.md"
      grep -q '@docs/claude-extra.md' CLAUDE.md && ok "Claude-only import kept in CLAUDE.md" || bad "Claude-only import lost" ;;
    other-agents)
      has MARKER-GEMINI AGENTS.md "Gemini rule moved to AGENTS.md"
      grep -q '@AGENTS.md' GEMINI.md && ok "GEMINI.md points at AGENTS.md" || bad "GEMINI.md doesn't import AGENTS.md"
      has MARKER-CURSOR . "Cursor rule kept somewhere" ;;
    agents-app)
      grep -q MARKER-APP-CODE agents/planner.py && ok "app code untouched" || bad "agents/planner.py changed"
      [ -d agents/context ] && bad "context mixed into the app's agents/" || ok "context kept out of agents/"
      grep -rq 'agents/context' --exclude-dir=.git --exclude-dir=.agents . && bad "stray agents/context path" || ok "no stray agents/context paths" ;;
    big-agents-md)
      has MARKER-BIG-LAST . "last rule still in the repo"
      has 'Rule 60' . "rule 60 still in the repo" ;;
  esac
  [ $fail -eq 0 ] && echo "  PASS" || { echo "  FAILED"; total=1; }
  cd "$repo"
done
exit $total
