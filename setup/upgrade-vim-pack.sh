#!/bin/sh

find "$HOME/.vim/pack" -mindepth 3 -maxdepth 3 -type d -exec \
  sh -c "cd {} && git pull" \;
