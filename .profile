__profile__os="${__os:-$(uname -s)}"
__profile__arch="${__arch:-$(uname -m)}"

__profile__source() {
  [ -r "$1" ] && . "$1"
}

__profile__testpathcontains() {
  case ":$PATH:" in
    *:"$1":*) return 0;;
    *)        return 1;;
  esac
}

__profile__unshiftpath() {
  [ -d "$1" ] || return
  if __profile__testpathcontains "$1"; then
    WKPATH="$1"
    WKIFS="$IFS"
    IFS=:
    for e in $PATH; do
      [ "$e" = "$1" ] && continue
      WKPATH="$WKPATH:$e"
    done
    IFS="$WKIFS"
    export PATH="$WKPATH"
  else
    export PATH="$1:$PATH"
  fi
}

export LANG=en_US.UTF-8
export LESS='-R --use-color -Dd+r$Du+b'
export EDITOR=vim

#
# freedesktop.org
# https://www.freedesktop.org/
#
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"

#
# Homebrew
# https://docs.brew.sh/
#
if [ "$__profile__os" = Darwin ]; then
  if [ "$__profile__arch" = arm64 ] && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  export HOMEBREW_AUTOREMOVE=1
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  __profile__unshiftpath "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
fi

#
# Volta
# https://volta.sh/
#
export VOLTA_HOME="$HOME/.local/volta"
__profile__unshiftpath "$VOLTA_HOME/bin"

#
# rustup
# https://rust-lang.github.io/rustup/
#
export RUSTUP_HOME="$HOME/.local/rustup"
export CARGO_HOME="$HOME/.local/cargo"
__profile__unshiftpath "$CARGO_HOME/bin"

#
# GHCup
# https://www.haskell.org/ghcup/
#
export GHCUP_USE_XDG_DIRS=1

__profile__source "$HOME/.profile.local"
__profile__unshiftpath "$HOME/.local/bin"

unset -f __profile__unshiftpath __profile__testpathcontains __profile__source
unset -v e WKPATH WKIFS __profile__arch __profile__os
