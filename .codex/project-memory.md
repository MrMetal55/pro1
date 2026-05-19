# Project Memory

Durable facts for future Codex sessions. Keep this curated and update stale entries.

## Overview

- Flutter project at `/Users/demir/Desktop/Flutter/pro1`.
- This repository uses a project-local "log everything" workflow documented in `SKILL.md`.

## Architecture And Entry Points

- Main app entry point: `lib/main.dart`.
- Calculator expression evaluation lives in `CalculatorEvaluator` in `lib/main.dart`.
- Widget test entry point: `test/widget_test.dart`.

## Commands

- Run static analysis and append output to the skill session log: `bash scripts/run_analyze.sh`.
- Standard Flutter checks for code edits: `flutter analyze` and focused `flutter test` commands when practical.

## Conventions

- Read `SKILL.md`, `.codex/project-memory.md`, and `.codex/project-log.md` before project changes.
- Log meaningful work in `memories/session/skill_log.md` with local timestamps.
- Keep chronological Codex milestones in `.codex/project-log.md`.
- Keep durable project facts in `.codex/project-memory.md`.

## Decisions

- Use `.codex/project-memory.md` and `.codex/project-log.md` as the primary durable project context.
- Also keep `memories/session/skill_log.md` and `memories/skill_instruction.md` for compatibility with the `log-everything-workflow` skill.

## Pitfalls And Follow-Ups

- Do not store secrets, credentials, tokens, or unrelated personal information in memory files.
- For documentation-only edits, verifying file existence/readability is enough; full Flutter checks are optional.
- Calculator tests cover operator precedence, powers, parentheses, decimals, division by zero, leading negative values, clear behavior, and error recovery.
- Long-pressing the equals button runs a random built-in surprise expression and shows a SnackBar.
- After pressing `=`, the top display should keep the last equation while the bottom display shows the result. Pressing an operator after a result should start a new equation with that result.
- `C` deletes the last input on tap and resets the calculator on long press.
- App icons are generated from the user-provided source image at `assets/app_logo_source.png` by `scripts/generate_app_icons_from_source.py`; the 1024 master output is `assets/logo_rose_equal_1024.png`.

## Codex handoff

- This repository uses .codex/project-log.md for chronological Codex work history and .codex/project-memory.md for durable project facts future agents should read first.
- The repository also has `memories/skill_instruction.md`, which instructs future agents to log meaningful work and follow this workspace workflow.
