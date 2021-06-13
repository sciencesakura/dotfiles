#!/bin/sh

curdir="$(dirname "$0")"

# install homebrew packages
brew tap homebrew/cask-fonts
while read e; do
  repo="$(echo $e | cut -d : -f 1)"
  form="$(echo $e | cut -d : -f 2)"
  case "$repo" in
    core)
      brew install "$form";;
    cask)
      brew install --cask "$form";;
  esac
done < "$curdir/brew-formulas"

# use homebrew's bash as a login shell
if [ -x /usr/local/bin/bash ]; then
  echo /usr/local/bin/bash | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash
fi

# common
sh "$curdir/setup.sh"
