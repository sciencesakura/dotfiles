#!/bin/sh

curdir="$(dirname "$0")"

__mkdirifnotexist() {
  [ -d "$1" ] || mkdir -p "$1"
}

pluginroot="$HOME/.vim/pack/plugins/start"
__mkdirifnotexist "$pluginroot"

while read repourl; do
  repodir="${repourl##*/}"
  repodir="$pluginroot/${repodir%.git}"
  [ -d "$repodir" ] || git clone --depth 1 "$repourl" "$repodir"
done < "$curdir/vim-plugins"
