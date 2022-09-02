__put_path() {
  [ -d "$1" ] || return
  WKPATH="$1"
  WKIFS="$IFS"
  IFS=:
  for e in $PATH; do
    [ -z "$e" -o "$e" = "$1" ] && continue
    WKPATH="$WKPATH:$e"
  done
  IFS="$WKIFS"
  PATH="$WKPATH"
}

#
# POSIX
#
export HISTSIZE=1048576
export LANG=C
export PS1='\u@\h \w \$ '

#
# freedesktop.org
#
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"

#
# Homebrew
#
if [ "$(uname)" = 'Darwin' ]; then
  if [ "$(uname -m)" = 'arm64' ]; then
    __put_path '/opt/homebrew/bin'
  fi
  if type brew > /dev/null 2>&1; then
    __put_path "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  fi
fi

if type vim > /dev/null 2>&1; then
  export EDITOR=vim
elif type vi > /dev/null 2>&1; then
  export EDITOR=vi
fi

if type nodebrew > /dev/null 2>&1; then
  [ -z "$NODEBREW_ROOT" ] && export NODEBREW_ROOT="$HOME/.nodebrew"
  [ -d "$NODEBREW_ROOT/src" ] || mkdir -p "$NODEBREW_ROOT/src"
  __put_path "$NODEBREW_ROOT/current/bin"
fi

if type pyenv > /dev/null 2>&1; then
  [ -z "$PYENV_ROOT" ] && export PYENV_ROOT="$HOME/.pyenv"
  __put_path "$PYENV_ROOT/bin"
fi

__put_path "$HOME/bin"

export PATH
unset -f __put_path
unset -v WKIFS WKPATH

if type pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -z "$SDKMAN_DIR" ] && export SDKMAN_DIR="$HOME/.sdkman"
[ -r "$SDKMAN_DIR/bin/sdkman-init.sh" ] && . "$SDKMAN_DIR/bin/sdkman-init.sh"
