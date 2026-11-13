#!/bin/sh
# Copy a fixture into scratch/<fixture>, make it a git repo, install lean-context from this checkout.
# Usage (from the repo root): sh tests/lean-context/prepare.sh <fixture>|all
set -e
repo=$(cd "$(dirname "$0")/../.." && pwd)
fixtures="$repo/tests/lean-context/fixtures"
[ "$1" = all ] && set -- $(command ls -1 "$fixtures")
for name in "$@"; do
  [ -d "$fixtures/$name" ] || { echo "no fixture: $name"; exit 1; }
  dest="$repo/scratch/$name"
  rm -rf "$dest"; mkdir -p "$repo/scratch"; cp -R "$fixtures/$name" "$dest"
  cd "$dest"
  git init -q && git add -A && git -c user.name=test -c user.email=test@example.com commit -qm fixture
  npx -y skills add "$repo" --skill lean-context --yes >/dev/null 2>&1
  echo "ready: scratch/$name   (cd there, start the agent, run /lean-context; then: sh tests/lean-context/check.sh $name)"
  cd "$repo"
done
