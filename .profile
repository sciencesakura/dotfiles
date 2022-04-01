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
# for shell
#
case "$SHELL" in
  */bash)
    export HISTCONTROL=ignorespace:erasedups
    export HISTIGNORE=ll:ls:q:s
    export HISTTIMEFORMAT="%F %T "
    export PROMPT_DIRTRIM=4
    export PS1="\[\e[33m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\] \[\e[36m\]\w\[\e[0m\]\$ "
    ;;
esac

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
  if [ -z "$WKPATH" ]; then
    PATH="$1"
  else
    PATH="$1$WKPATH"
  fi
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
