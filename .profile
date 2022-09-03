[ -z "$__OS_NAME" ] && export __OS_NAME="$(uname -s)"

__profile__source() {
  [ -r "$1" ] && . "$1"
}

__profile__putpath() {
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

[ "$__OS_NAME" = 'Darwin' -a "$(uname -m)" = 'arm64' ] && \
  __profile__putpath '/opt/homebrew/bin'

if type vim > /dev/null 2>&1; then
  export EDITOR=vim
elif type vi > /dev/null 2>&1; then
  export EDITOR=vi
fi

if type nodebrew > /dev/null 2>&1; then
  [ -z "$NODEBREW_ROOT" ] && export NODEBREW_ROOT="$HOME/.nodebrew"
  [ -d "$NODEBREW_ROOT/src" ] || mkdir -p "$NODEBREW_ROOT/src"
  __profile__putpath "$NODEBREW_ROOT/current/bin"
fi

if type pyenv > /dev/null 2>&1; then
  [ -z "$PYENV_ROOT" ] && export PYENV_ROOT="$HOME/.pyenv"
  __profile__putpath "$PYENV_ROOT/bin"
fi

if [ "$__OS_NAME" = 'Darwin' ]; then
  if type brew > /dev/null 2>&1; then
    __profile__putpath "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  fi
fi

# ----------------------------------------------------------------
export PATH

if type pyenv > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -z "$SDKMAN_DIR" ] && \
  export SDKMAN_DIR="$HOME/.sdkman" && \
  __profile__source "$SDKMAN_DIR/bin/sdkman-init.sh"
# ----------------------------------------------------------------

__profile__putpath "$HOME/bin" && export PATH

unset -f __profile__putpath
unset -f __profile__source
unset -v WKIFS WKPATH
