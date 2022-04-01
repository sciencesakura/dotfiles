#
# POSIX
#
export HISTSIZE=1024
export LANG=en_US

#
# freedesktop.org
#
[ -z "$XDG_CACHE_HOME"  ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME"   ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME"  ] && export XDG_STATE_HOME="$HOME/.local/state"

#
# others
#
if type vim > /dev/null 2>&1; then
  export EDITOR=vim
fi
export NODEBREW_ROOT="$HOME/.nodebrew"

#
# PATH
#
WKIFS="$IFS"
IFS=:

__put_path() {
  [ -d "$1" ] || return
  WKPATH=""
  for e in $PATH; do
    [ -z "$e" -o "$e" = "$1" ] && continue
    WKPATH="$WKPATH:$e"
  done
  PATH="$1$WKPATH"
}

__put_path "$NODEBREW_ROOT/current/bin"
__put_path /usr/local/opt/grep/libexec/gnubin
__put_path /usr/local/opt/gnu-sed/libexec/gnubin
__put_path /usr/local/opt/findutils/libexec/gnubin
__put_path /usr/local/opt/coreutils/libexec/gnubin
__put_path "$HOME/bin"

IFS="$WKIFS"
export PATH
unset -f __put_path
unset -v WKIFS WKPATH
