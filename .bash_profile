[[ -f ~/.bashrc ]] && . ~/.bashrc

__pushpath() {
  local entry="$1"
  [[ -d $entry ]] || return
  local TMPIFS="$IFS" newpath i
  IFS=':'
  for i in $PATH; do
    [[ $i != $entry ]] && newpath="$newpath:$i"
  done
  export PATH="${entry}${newpath}"
  IFS="$TMPIFS"
}

export EDITOR=vim
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
export HISTIGNORE=ll:ls:s
export HISTSIZE=10000
export HISTTIMEFORMAT='%F %T '
export LANG=en_US
export PROMPT_DIRTRIM=4
export PS1="\[\e[33m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\] \[\e[36m\]\w\[\e[0m\]\$ "

case "$(uname)" in
  Darwin)
    __pushpath /usr/local/opt/coreutils/libexec/gnubin
    __pushpath /usr/local/opt/findutils/libexec/gnubin
    __pushpath /usr/local/opt/gnu-sed/libexec/gnubin
    __pushpath /usr/local/opt/grep/libexec/gnubin
    ;;
esac

if [[ -d ~/.nodebrew ]]; then
  export NODEBREW_ROOT=~/.nodebrew
  __pushpath $NODEBREW_ROOT/current/bin
fi

unset -f __pushpath
