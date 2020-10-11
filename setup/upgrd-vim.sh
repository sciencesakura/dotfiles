#!/bin/sh

find "$HOME/.vim/pack/plugins/start" -mindepth 1 -maxdepth 1 -type d -exec \
  sh -c "cd {} && git pull --ff-only origin master" \;
