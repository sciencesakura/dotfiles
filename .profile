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
export LANG=en_US

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
    __put_path "$(brew --prefix)/opt/grep/libexec/gnubin"
    __put_path "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
    __put_path "$(brew --prefix)/opt/findutils/libexec/gnubin"
    __put_path "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  fi
fi

#
# others
#
if type vim > /dev/null 2>&1; then
  export EDITOR=vim
fi

[ -z "$NODEBREW_ROOT" ] && export NODEBREW_ROOT="$HOME/.nodebrew"
__put_path "$NODEBREW_ROOT/current/bin"

__put_path "$HOME/bin"

export PATH

unset -f __put_path
unset -v WKIFS WKPATH
