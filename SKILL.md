# Log Everything Workflow

Use this workspace skill whenever Codex should leave a clear project trail: what changed, why it changed, how it was checked, and what future sessions should read first.

## Scope

- Workspace-scoped for `/Users/demir/Desktop/Flutter/pro1`.
- Keep durable project context in `.codex/project-memory.md`.
- Keep chronological Codex history in `.codex/project-log.md`.
- Keep session-level skill activity in `memories/session/skill_log.md`.

## Required Artifacts

- `SKILL.md`: this workflow.
- `memories/session/skill_log.md`: timestamped session actions and verification notes.
- `memories/skill_instruction.md`: persistent handoff instruction for future Codex sessions.
- `.codex/project-memory.md`: curated facts, commands, conventions, decisions, and pitfalls.
- `.codex/project-log.md`: concise chronological work log.

## Workflow

1. Read `SKILL.md`, `.codex/project-memory.md`, and `.codex/project-log.md` before making project changes.
2. Inspect the relevant workspace files and existing logs before writing anything new.
3. Record meaningful actions in `memories/session/skill_log.md` with local timestamps.
4. Record durable project facts in `.codex/project-memory.md` when they will help future sessions.
5. Record completed session milestones in `.codex/project-log.md`.
6. Avoid saving secrets, credentials, tokens, or unrelated personal information.
7. When code changes are made, run the smallest useful project check and log the result.
8. If a check cannot run, log the blocker and tell the user.

## Decision Points

- For Flutter code edits, prefer `dart format`, `flutter analyze`, and focused tests when practical.
- For documentation or memory-only edits, verify the expected files exist and are readable; full Flutter checks are optional.
- If project facts already belong in `.codex/project-memory.md`, update that file instead of creating a parallel memory location.
- If a future user asks for a global Codex skill, create or update `~/.codex/skills/<skill-name>/SKILL.md` instead of this workspace file.

## Quality Checks

- `SKILL.md` exists at the repository root and describes the current workflow.
- `memories/session/skill_log.md` exists and contains chronological entries.
- `memories/skill_instruction.md` clearly tells future agents what to read and how to log.
- `.codex/project-memory.md` and `.codex/project-log.md` remain readable and consistent with this workflow.
- Verification results or blockers are written to the session log.

## Helpful Commands

```bash
cd /Users/demir/Desktop/Flutter/pro1
bash scripts/run_analyze.sh
flutter test
```

## Example Prompts

- "Log each step I request into the session log and create/update persistent memory."
- "Append this result to the project log and session log."
- "Update the workspace SKILL.md from this debugging session."
- "Run the project checks and log the results."
