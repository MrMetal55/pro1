#!/usr/bin/env bash
set -euo pipefail

# Run from repository root. Appends flutter analyze output to session log.
WORKSPACE_DIR="/Users/demir/Desktop/Flutter/pro1"
LOG_FILE="$WORKSPACE_DIR/memories/session/skill_log.md"
mkdir -p "$(dirname "$LOG_FILE")"

TS=$(date '+%Y-%m-%d %H:%M:%S')
printf "- [%s] Running flutter analyze...\n" "$TS" >> "$LOG_FILE"

TMP_OUT=$(mktemp)
if flutter analyze > "$TMP_OUT" 2>&1; then
  printf "- [%s] flutter analyze: SUCCESS\n" "$TS" >> "$LOG_FILE"
else
  printf "- [%s] flutter analyze: FAILURE\n" "$TS" >> "$LOG_FILE"
fi
printf "  Output (first 500 lines):\n" >> "$LOG_FILE"
head -n 500 "$TMP_OUT" >> "$LOG_FILE"
printf "\n" >> "$LOG_FILE"
rm -f "$TMP_OUT"

echo "Analysis results appended to $LOG_FILE"
