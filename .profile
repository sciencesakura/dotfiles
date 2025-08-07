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

__profile__testmanpathcontains() {
  case ":$MANPATH:" in
    *:"$1":*) return 0;;
    *)        return 1;;
  esac
}

__profile__unshiftmanpath() {
  [ -d "$1" ] || return
  if __profile__testmanpathcontains "$1"; then
    WKPATH="$1"
    WKIFS="$IFS"
    IFS=:
    for e in $MANPATH; do
      [ "$e" = "$1" ] && continue
      WKPATH="$WKPATH:$e"
    done
    IFS="$WKIFS"
    export MANPATH="$WKPATH"
  else
    export MANPATH="$1:$MANPATH"
  fi
}

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
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
if [ -n "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  __profile__unshiftpath "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
  __profile__unshiftpath "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"
  __profile__unshiftpath "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"
  __profile__unshiftpath "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"

  __profile__unshiftmanpath "$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman"
  __profile__unshiftmanpath "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman"
fi

export LANG=en_US.UTF-8
export LESS='-R --use-color -Dd+r$Du+b'
type vim >/dev/null 2>&1 && export EDITOR=vim

#
# GHCup
# https://www.haskell.org/ghcup/
#
export GHCUP_USE_XDG_DIRS=1

#
# opam
# https://opam.ocaml.org/
#
[ -z "$OPAMROOT" ] && export OPAMROOT="$HOME/.local/opam"
__profile__source "$OPAMROOT/opam-init/init.sh"

#
# pyenv
# https://github.com/pyenv/pyenv
#
[ -z "$PYENV_ROOT" ] && export PYENV_ROOT="$HOME/.local/pyenv"
type pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"

#
# rbenv
# https://github.com/rbenv/rbenv
#
[ -z "$RBENV_ROOT" ] && export RBENV_ROOT="$HOME/.local/rbenv"
type rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

#
# rustup
# https://rust-lang.github.io/rustup/
#
[ -z "$RUSTUP_HOME" ] && export RUSTUP_HOME="$HOME/.local/rustup"
[ -z "$CARGO_HOME"  ] && export CARGO_HOME="$HOME/.local/cargo"
__profile__unshiftpath "$CARGO_HOME/bin"

#
# SDKMAN!
# https://sdkman.io/
#
[ -z "$SDKMAN_DIR" ] && export SDKMAN_DIR="$HOME/.local/sdkman"
__profile__source "$SDKMAN_DIR/bin/sdkman-init.sh"

#
# Volta
# https://volta.sh/
#
[ -z "$VOLTA_HOME" ] && export VOLTA_HOME="$HOME/.local/volta"
__profile__unshiftpath "$VOLTA_HOME/bin"

#
# Others
#
__profile__source "$HOME/.profile.local"
__profile__unshiftpath "$HOME/.local/bin"

unset -f __profile__unshiftpath __profile__testpathcontains __profile__source
unset -v e WKPATH WKIFS
