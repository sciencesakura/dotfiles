[[ -f ~/.bashrc ]] && . ~/.bashrc

declare -a __pathary
declare -A __pathset

__init_path() {
  local TMPIFS="$IFS" index=0 entry
  IFS=:
  for entry in $PATH; do
    __pathary[$index]="$entry"
    __pathset["$entry"]=$((index++))
  done
  IFS="$TMPIFS"
}

__put_path() {
  local entry="$1"
  [[ -n ${__pathset["$entry"]} ]] && return
  local next=${#__pathary[@]}
  __pathary[$next]="$entry"
  __pathset["$entry"]=$next
}

__export_path() {
  local TMPPATH item
  for item in "${__pathary[@]}"; do
    TMPPATH="$TMPPATH:$item"
  done
  export PATH="${TMPPATH:1}"
}

__init_path

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
    __put_path /usr/local/opt/coreutils/libexec/gnubin
    __put_path /usr/local/opt/findutils/libexec/gnubin
    __put_path /usr/local/opt/gnu-sed/libexec/gnubin
    __put_path /usr/local/opt/grep/libexec/gnubin
    ;;
esac

if [[ -d ~/.nodebrew ]]; then
  export NODEBREW_ROOT=~/.nodebrew
  __put_path "$NODEBREW_ROOT/current/bin"
fi

__put_path ~/bin

__export_path

unset -f __init_path __put_path __export_path
unset -n __pathary __pathset
