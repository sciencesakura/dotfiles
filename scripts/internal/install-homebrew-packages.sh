#!/bin/sh

packages="${1:?}"

type brew >/dev/null 2>&1
if [ $? != 0 ]; then
  printf "command not found: brew\n" 2>&1
  exit 1
fi

tail -n +2 "$packages" | while read line; do
  user="$(printf "$line\n" | cut -f 1)"
  repo="$(printf "$line\n" | cut -f 2)"
  formula="$(printf "$line\n" | cut -f 3)"
  brew install "$user/$repo/$formula"
done
