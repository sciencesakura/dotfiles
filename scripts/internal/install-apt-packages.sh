#!/bin/sh

packages="${1:?}"

type apt-get >/dev/null 2>&1
if [ $? != 0 ]; then
  printf "command not found: apt-get\n" 2>&1
  exit 1
fi

while read line; do
  apt-get install -y --no-install-recommends "$line"
done < "$packages"
