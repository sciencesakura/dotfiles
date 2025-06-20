#!/bin/sh

CURRENT_DIR="$(dirname "$0")"
GITHUB_GITIGNORE_DIR="${1%/}"

[ -d "$GITHUB_GITIGNORE_DIR" ] || {
  echo "Error: $GITHUB_GITIGNORE_DIR is not a directory."
  exit 1
}

OUTPUT_IGNORE_FILE="$CURRENT_DIR/../.config/git/ignore"
[ -f "$OUTPUT_IGNORE_FILE" ] && {
  echo "Error: ignore file already exists."
  exit 1
}

while read -r entry; do
  entry="${entry%%#*}"
  [ -z "$entry" ] && continue
  path="$GITHUB_GITIGNORE_DIR/$entry"
  [ -f "$path" ] || {
    echo "Error: $entry file does not exist. skipping."
    continue
  }
  printf "# $entry\n" >> "$OUTPUT_IGNORE_FILE"
  cat "$path" >> "$OUTPUT_IGNORE_FILE"
  printf "\n" >> "$OUTPUT_IGNORE_FILE"
done < "$CURRENT_DIR/gen-gitignore.txt"
