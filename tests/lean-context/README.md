# lean-context tests
Small projects for the tricky cases, run by hand: the skill asks the owner questions, so a person answers.

| Fixture | Checks |
| --- | --- |
| fresh | plain setup: files, caps, no secrets, the `npx skills` link left alone |
| full-claude-md | CLAUDE.md rules moved to AGENTS.md; its Claude-only `@import` kept |
| other-agents | GEMINI.md points at AGENTS.md; Gemini rule moved; Cursor rule kept |
| agents-app | the app's `agents/` folder untouched; context under another name, no stray paths |
| big-agents-md | AGENTS.md brought under 3.5 KB without losing a rule |

Every fixture is installed with `npx skills add`, so each also checks the CLI case.

```
sh tests/lean-context/prepare.sh all          # or one fixture name
cd scratch/<fixture> && claude                # run /lean-context, answer its questions
sh tests/lean-context/check.sh all            # from the repo root
rm -rf scratch                                # when done
```
Change the skill → re-run the fixtures it touches. A new tricky case → a new fixture and a `case` in check.sh.
