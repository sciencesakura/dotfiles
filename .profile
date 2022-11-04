__IS_DARWIN=0
case "$(uname -s)" in
  Darwin)
    __IS_DARWIN=1;;
esac

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
  export PATH="$WKPATH"
}

#
# freedesktop.org
#
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"

# homebrew
if [ "$__IS_DARWIN" = 1 -a "$(uname -m)" = arm64 ]; then
  __profile__putpath /opt/homebrew/bin
fi
if type brew > /dev/null 2>&1; then
  export HOMEBREW_NO_AUTO_UPDATE=1
  if [ "$__IS_DARWIN" == 1 ]; then
    # prefer GNU coreutils to preinstalled one
    __profile__putpath "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  fi
fi

# nodebrew
if type nodebrew > /dev/null 2>&1; then
  [ -d "$HOME/.nodebrew/src" ] || mkdir -p "$HOME/.nodebrew/src"
  __profile__putpath "$HOME/.nodebrew/current/bin"
fi

# pyenv
if type pyenv > /dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  __profile__putpath "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

__profile__putpath "$HOME/bin"

#
# other environment variables
#
if type vim > /dev/null 2>&1; then
  export EDITOR=vim
fi
export HISTSIZE=1048576
export LANG=C
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

unset -f __profile__putpath
unset -f __profile__source
unset -v WKIFS WKPATH __IS_DARWIN
