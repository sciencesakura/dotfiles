__profile__os="$(uname -s)"
__profile__arch="$(uname -m)"

__profile__source() {
  [ -r "$1" ] && . "$1"
}

__profile__testpathcontains() {
  case ":$PATH:" in
    *:"$1":*) return 0;;
    *)        return 1;;
  esac
}

__profile__pushpath() {
  [ -d "$1" ] || return
  __profile__testpathcontains "$1" && return
  export PATH="$PATH:$1"
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

#
# freedesktop.org
#
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"

# homebrew
if [ "$__profile__os" = Darwin -a "$__profile__arch" = arm64 ]; then
  __profile__unshiftpath /opt/homebrew/sbin
  __profile__unshiftpath /opt/homebrew/bin
fi
if type brew >/dev/null 2>&1; then
  export HOMEBREW_AUTOREMOVE=1
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  if [ "$__profile__os" = Darwin ]; then
    # prefer GNU coreutils & findutils to preinstalled one
    __profile__unshiftpath "$(brew --prefix)/opt/coreutils/libexec/gnubin"
    __profile__unshiftpath "$(brew --prefix)/opt/findutils/libexec/gnubin"
  fi
fi

# pyenv
if type pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  __profile__unshiftpath "$PYENV_ROOT/bin"
  eval "$(pyenv init -)"
fi

# volta
if [ -d "$XDG_CONFIG_HOME/volta" ]; then
  export VOLTA_HOME="$XDG_CONFIG_HOME/volta"
  __profile__unshiftpath "$VOLTA_HOME/bin"
fi

# sdkman
if [ -d "$XDG_CONFIG_HOME/sdkman" ]; then
  export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
  __profile__source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

__profile__unshiftpath "$HOME/bin"
__profile__unshiftpath "$HOME/.local/bin"

#
# other environment variables
#
if type vim >/dev/null 2>&1; then
  export EDITOR=vim
fi
export LANG=C
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

#
## extensions
#
for e in "$HOME"/etc/profile.d/*.sh; do
  __profile__source "$e"
done

unset -f __profile__unshiftpath __profile__pushpath __profile__testpathcontains __profile__source
unset -v e WKPATH WKIFS __profile__arch __profile__os
