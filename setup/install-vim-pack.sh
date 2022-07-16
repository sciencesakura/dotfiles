#!/bin/sh

curdir="$(dirname "$0")"
packroot="$HOME/.vim/pack"

while read line; do
  kind="$(printf "$line\n" | cut -f 1)"
  url="$(printf "$line\n" | cut -f 2)"
  name="${url##*/}"
  name="${name%.git}"
  repodir="$packroot/plugins/$kind/$name"
  if [ -d "$repodir" ]; then
    printf "warning! $url is already cloned.\n"
    continue
  fi
  options="--depth 1"
  branch="$(printf "$line\n" | cut -f 3)"
  if [ -n "$branch" ]; then
    options="$options --branch $branch"
  fi
  git clone $options "$url" "$repodir"
done < "$curdir/vim-pack.tsv"
