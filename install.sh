#!/bin/sh

REPO_ROOT="${1:?}"
BACKUP_DIR="$HOME/backup/dotfiles/$(date +%Y%m%d%H%M%S)"
ENTRIES=".bash_profile \
  .bashrc \
  .config/alacritty \
  .config/git/config \
  .config/tig \
  .config/tmux/tmux.conf \
  .config/tmux-powerline \
  .inputrc \
  .profile \
  .vim"

for i in $ENTRIES; do
  printf "Installing %s\n" "$i"
  if [ -e "$HOME/$i" ]; then
    destdir="$BACKUP_DIR/$(dirname "$i")"
    [ -d "$destdir" ] || mkdir -p "$destdir"
    mv -f "$HOME/$i" "$destdir/"
  fi
  destdir="$HOME/$(dirname "$i")"
  [ -d "$destdir" ] || mkdir -p "$destdir"
  ln -s "$REPO_ROOT/$i" "$destdir/"
done

unset -v destdir i BACKUP_DIR ENTRIES REPO_ROOT
