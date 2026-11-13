#!/bin/sh
# Check lean-context files against their size caps. Run from the repo root.
# Usage: sh <skill>/scripts/check-sizes.sh [context-dir]   (default: agents/context)
dir="${1:-agents/context}"
fail=0; total=0
check() { # file cap_bytes
  [ -f "$1" ] || return 0
  n=$(wc -c < "$1" | tr -d ' '); total=$((total + n))
  if [ "$n" -gt "$2" ]; then echo "OVER  $1: $n > $2"; fail=1; else echo "ok    $1: $n / $2"; fi
}
check AGENTS.md 3584
check CLAUDE.md 1024
check "$dir/now.md" 2048
check "$dir/map.md" 3072
check "$dir/docs-index.md" 2048
check "$dir/todo.md" 3072
if [ -d "$dir/log" ]; then
  for f in "$dir"/log/*.md; do check "$f" 1024; done
  logs=$(ls "$dir"/log/*.md 2>/dev/null | wc -l | tr -d ' ')
  [ "$logs" -gt 5 ] && { echo "OVER  $dir/log: $logs notes > 5 (drop the oldest)"; fail=1; }
fi
if [ "$total" -gt 12288 ]; then echo "OVER  total: $total > 12288"; fail=1; else echo "ok    total: $total / 12288"; fi
# Staleness: warn (don't fail) when now.md hasn't changed for many commits.
if [ -f "$dir/now.md" ] && git rev-parse --git-dir >/dev/null 2>&1; then
  last=$(git log -1 --format=%H -- "$dir/now.md" 2>/dev/null)
  if [ -n "$last" ]; then
    behind=$(git rev-list --count "$last"..HEAD)
    [ "$behind" -gt 10 ] && echo "WARN  $dir/now.md: unchanged for $behind commits (wrap up: update it)"
  fi
fi
exit $fail
