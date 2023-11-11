#!/bin/sh

packages="${1:?}"

type brew >/dev/null 2>&1
if [ $? != 0 ]; then
  printf "command not found: brew\n" 2>&1
  exit 1
fi

while read line; do
  brew install "$line"
done < "$packages"
