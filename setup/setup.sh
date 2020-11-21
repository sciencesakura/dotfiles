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
# .config/git
if [ -n "$XDG_CONFIG_HOME" ]; then
  __rmifexist "$XDG_CONFIG_HOME/git"
  ln -s "$(realpath "$curdir/../.config/git")" "$XDG_CONFIG_HOME/"
else
  __rmifexist "$HOME/.config/git"
  __mkdirifnotexist "$HOME/.config"
  ln -s "$(realpath "$curdir/../.config/git")" "$HOME/.config/"
fi
# .vim
__mkdirifnotexist "$HOME/.vim"
for e in $(ls "$curdir/../.vim"); do
  __rmifexist "$HOME/.vim/$e"
  ln -s "$(realpath "$curdir/../.vim/$e")" "$HOME/.vim/"
done
# others
for e in bin .bash_profile .bashrc .inputrc .npmrc .tmux.conf; do
  __rmifexist "$HOME/$e"
  ln -s "$(realpath "$curdir/../$e")" "$HOME/"
done

# setup vim
sh "$curdir/setup-vim.sh"
