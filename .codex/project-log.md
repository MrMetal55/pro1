# Project Log

Chronological work log for Codex sessions. Keep entries concise and factual.

## 2026-05-12 11:55 CEST

- Created the project-memory-log Codex skill in /Users/demir/.codex/skills/project-memory-log and initialized project context files under .codex/.

## 2026-05-12 12:03 CEST

- Applied the log-everything workflow to this workspace: updated `SKILL.md`, created `memories/session/skill_log.md`, created `memories/skill_instruction.md`, and refreshed `.codex/project-memory.md`.

## 2026-05-12 12:12 CEST

- Reviewed and fixed the Flutter calculator: corrected calculation edge cases, resolved widget-test layout overflow, replaced stale counter tests with calculator tests, and verified with `flutter analyze` plus `flutter test`.

## 2026-05-12 12:19 CEST

- Updated the calculator keypad layout, added parentheses buttons and expression parsing for parentheses, made the equals button smaller, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 12:31 CEST

- Changed number buttons to black, made the equals button orange, added a long-press equals surprise calculation, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 13:43 CEST

- Repositioned the bottom keypad row to `.`, `0`, `^`, `=`, added exponent support, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 13:46 CEST

- Restyled the calculator keypad with circular buttons, light-gray numbers, dark-gray decimal, orange parentheses and power, larger symbols, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 17:16 CEST

- Changed calculator result display behavior so the previous equation remains above the result after `=`, and continuing with an operator starts from the result; verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 17:21 CEST

- Changed `C` to delete one input on tap and reset all on long press, restyled it dark gray, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 17:26 CEST

- Increased calculator keypad label sizes without changing circular button dimensions, and verified with `flutter test` plus `flutter analyze`.

## 2026-05-12 17:50 CEST

- Replaced the default Flutter app icons with a generated cream-background rose/equal logo for iOS, Android, Web, macOS, and Windows; added a reproducible icon generation script.

## 2026-05-12 18:00 CEST

- Replaced the generated logo with the user's provided rose/equal image, stored it as `assets/app_logo_source.png`, regenerated all platform app icons, and verified icon dimensions.

## 2026-05-12 18:05 CEST

- Cleaned up app icon generation so it only uses the user-provided source image, regenerated icons, uninstalled the cached simulator app, ran `flutter clean` and `flutter pub get`, and verified with `flutter analyze`.
