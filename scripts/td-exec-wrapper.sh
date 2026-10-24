#!/bin/sh
# Filter command output for agent context: strip ANSI/progress bars, collapse
# repeated lines, and truncate long output (full log kept on disk).
# Usage: <cmd> 2>&1 | td-exec-wrapper.sh
#    or: td-exec-wrapper.sh <cmd> [args...]   (exit status preserved)
LOG="${TD_LOG:-/tmp/td-last-cmd.log}"
MAX=60
KEEP=20

filter() {
  esc=$(printf '\033')
  cr=$(printf '\r')
  # Drop ANSI sequences, keep only text after the last CR (progress bars), dedupe.
  sed -e "s/${esc}\[[0-9;?]*[A-Za-z]//g" -e "s/${esc}][^\a]*\a//g" -e "s/.*${cr}//" | uniq > "$LOG"
  n=$(wc -l < "$LOG" | tr -d ' ')
  if [ "$n" -le "$MAX" ]; then
    cat "$LOG"
  else
    head -n "$KEEP" "$LOG"
    echo "[TRUNCATED: $((n - 2 * KEEP)) lines hidden. Full log at $LOG. Use rg/sed to inspect.]"
    tail -n "$KEEP" "$LOG"
  fi
}

if [ "$#" -eq 0 ]; then
  filter
  exit 0
fi

status_file=$(mktemp)
{ "$@" 2>&1; echo $? > "$status_file"; } | filter
status=$(cat "$status_file")
rm -f "$status_file"
exit "${status:-1}"
