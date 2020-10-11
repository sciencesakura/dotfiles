#!/bin/sh

curdir="$(dirname "$0")"

pluginroot="$HOME/.vim/pack/plugins/start"
[ -d "$pluginroot" ] || mkdir -p "$pluginroot"

while read repourl; do
  repodir="${repourl##*/}"
  repodir="$pluginroot/${repodir%.git}"
  [ -d "$repodir" ] || git clone "$repourl" "$repodir"
done < "$curdir/vim-plugins"
