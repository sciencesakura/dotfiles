#!/bin/sh

REPODIR="$HOME/github.com/sciencesakura/dotfiles"
BACKUPDIR="$HOME/backup/dotfiles/$(date +%Y%m%d%H%M%S)"
ENTRIES=".config/ .vim/ .bash_profile .bashrc .inputrc .profile"

backup_if_exists() {
  [ -e "$HOME/$1" ] || return 0
  destdir="$BACKUPDIR/$(dirname "$1")"
  [ -d "$destdir" ] || mkdir -p "$destdir"
  mv -f "$HOME/$1" "$destdir/"
}

make_symlink() {
  destdir="$HOME/$(dirname "$1")"
  [ -d "$destdir" ] || mkdir -p "$destdir"
  ln -s "$REPODIR/$1" "$destdir/"
}

for i in $ENTRIES; do
  case $i in
    */)
      for j in $(ls -A "$REPODIR/$i"); do
        backup_if_exists "$i$j" && make_symlink "$i$j"
      done
      ;;
    *)
      backup_if_exists "$i" && make_symlink "$i"
      ;;
  esac
done
