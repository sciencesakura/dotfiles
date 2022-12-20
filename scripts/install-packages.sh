#!/bin/sh

REPODIR="$HOME/github.com/sciencesakura/dotfiles"

pmname="$1"
if [ -z "$pmname" ]; then
  printf "Usage: install-package <package_manager> [name ...]\n" 1>&2
  exit 1
fi

ostype="$(uname -a)"
case "$ostype" in
  Darwin*) ostype=osx;;
  *) ;;
esac

packdir="$REPODIR/packages/$pmname/$ostype"
if [ ! -d "$packdir" ]; then
  printf "directory not found: $packdir\n" 1>&2
  exit 1
fi

do_install() {
  if [ ! -r "$1" ]; then
    printf "file not found: $1\n" 1>&2
    return 1
  fi
  "$REPODIR/scripts/internal/install-$pmname-packages.sh" "$1"
}

if [ -z "$2" ]; then
  for e in $(ls "$packdir"/*.tsv); do
    do_install "$e"
  done
else
  for e in $@; do
    [ "$e" = "$pmname" ] && continue
    do_install "$packdir/$e.tsv"
  done
fi
