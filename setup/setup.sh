#!/bin/sh

curdir="$(dirname "$0")"

__mkdirifnotexist() {
  [ -d "$1" ] || mkdir -p "$1"
}

__rmifexist() {
  [ -e "$1" ] && rm -rf "$1"
}

# install SDKMAN!
curl -s https://get.sdkman.io | /bin/bash

# create symlink for dotfiles
# .config
if [ -z "$XDG_CONFIG_HOME" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi
for e in git tmux; do
  __rmifexist "$XDG_CONFIG_HOME/$e"
  ln -s "$(realpath "$curdir/../.config/$e")" "$XDG_CONFIG_HOME/"
done
# .vim
__mkdirifnotexist "$HOME/.vim"
for e in $(ls "$curdir/../.vim"); do
  __rmifexist "$HOME/.vim/$e"
  ln -s "$(realpath "$curdir/../.vim/$e")" "$HOME/.vim/"
done
# others
for e in bin .bash_profile .bashrc .inputrc .profile; do
  __rmifexist "$HOME/$e"
  ln -s "$(realpath "$curdir/../$e")" "$HOME/"
done

# setup vim
sh "$curdir/setup-vim.sh"
