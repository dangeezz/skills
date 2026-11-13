# Edge cases (read only the ones that apply)

## AGENTS.md or CLAUDE.md already has content
Merge; never drop the owner's text.
- CLAUDE.md beyond `@AGENTS.md`: move what applies to any agent into AGENTS.md. Keep below the `@AGENTS.md` line
  only what is Claude-Code-only (its own `@imports`, Claude-specific settings).
- CLAUDE.md that is already a symlink to AGENTS.md, or `.claude/CLAUDE.md` doing the import: fine, leave it.
- Over a cap: shorten by moving detail into `agents/context/` or the docs and linking it, never by deleting.
- The files (or the code) disagree, or a rule is unclear: ask the owner, don't pick one.
- Show the owner the before/after of both files before committing.

## Other agents' instruction files
GEMINI.md, `.github/copilot-instructions.md`, `.cursor/rules/`, `.windsurfrules`… that exist: move the shared
rules into AGENTS.md; leave each a short pointer to it plus only its tool-specific bits (GEMINI.md: `@AGENTS.md`).
Don't create files for agents the project doesn't use.

## CLAUDE.local.md, AGENTS.md in subfolders (monorepos)
- CLAUDE.local.md is personal and untracked: leave it.
- A subfolder AGENTS.md (a package in a monorepo) is read on top of the root one when an agent works there.
  Keep the root for repo-wide rules; each package file only adds what is specific to that package and never
  repeats the root. Cap each at 2 KB. List them in map.md. Don't create new ones unless a package has its own
  build, rules or commands.

## A real `.claude/agents` or `.claude/skills` folder
Move the project's own files into `agents/agents/` or `agents/skills/` first, then link
(`ln -s ../agents/agents .claude/agents`, relative so it works on any machine).

## Skills installed with `npx skills add` (`.agents/skills/`, `skills-lock.json`)
The CLI owns `.agents/skills/` and links each skill from `.claude/skills/<name>`: leave those as they are.
`.claude/skills` then stays a real folder, and each project skill gets its own link:
`ln -s ../../agents/skills/<name> .claude/skills/<name>`. `agents/skills/` holds only the project's own skills.

## An `agents/` folder that is something else
App code, an agents package…: don't mix in. Ask the owner for another name (suggest `agent-notes/`), then use it
everywhere: the folders, the links, every `agents/context` path inside the templates (AGENTS.md,
context/README.md), the `scripts/check-sizes.sh <dir>` argument and `CONTEXT_DIR=<name> sh scripts/check-secrets.sh`. Grep the result for a stray `agents/context`.

## Windows
Symlinks need Developer Mode and `git config core.symlinks true`; without them git checks links out as small
text files and `.claude/agents` silently stops working. Ask the owner: enable them, or copy the folders into
`.claude/` and note in AGENTS.md that `agents/` is the source to edit.

## Sessions that start one folder up
A product folder holding the repo and an untracked scratch folder: put an `AGENTS.md` there that says where the
repo is and ends with `@<repo>/AGENTS.md`, and a `CLAUDE.md` of `@AGENTS.md`.
