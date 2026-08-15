#!/bin/sh

type realpath >/dev/null 2>&1 \
    && REPO_ROOT="$(realpath "$(dirname "$0")")" \
    || REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/backup/dotfiles/$(date +%Y%m%d%H%M%S)"
ENTRIES=".bash_aliases \
    .bash_profile \
    .bashrc \
    .config/alacritty \
    .config/git \
    .config/tig \
    .config/tmux \
    .config/tmux-powerline \
    .config/vim \
    .inputrc \
    .profile"

for i in $ENTRIES; do
  [ -e "$REPO_ROOT/$i" ] || continue
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
