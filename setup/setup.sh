#!/bin/sh

curdir="$(dirname "$0")"

# install SDKMAN!
curl -s https://get.sdkman.io | /bin/bash

# create symlink for dotfiles
for e in .vim bin .bash_profile .bashrc .gitconfig .gitignore_global .inputrc .npmrc .tmux.conf .vimrc; do
  [ -e "$HOME/$e" ] && rm -rf "$HOME/$e"
  ln -s "$(realpath "$e")" "$HOME/"
done

# setup vim
sh "$curdir/setup-vim.sh"
