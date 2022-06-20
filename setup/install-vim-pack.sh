#!/bin/sh

curdir="$(dirname "$0")"
packroot="$HOME/.vim/pack"

while read line; do
  kind="$(printf "$line\n" | cut -f 1)"
  rurl="$(printf "$line\n" | cut -f 2)"
  [ -d "$packroot/plugins/$kind" ] || mkdir -p "$packroot/plugins/$kind"
  cd "$packroot/plugins/$kind"
  git clone --depth 1 "$rurl"
done < "$curdir/vim-pack.tsv"
