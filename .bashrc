[[ "$-" != *i* ]] && return

__source_if_readable() {
  [[ -r $1 ]] && . "$1"
}

__source_if_readable /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
__source_if_readable ~/.sdkman/bin/sdkman-init.sh

alias q='exit'
alias ls='ls --color=auto'
alias ll='ls -lA'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias tree='tree -C'
alias rename='rename -v'
alias grep='grep --color=auto'
alias g='git'
alias s='git status'

mkcd() {
  mkdir "$@" && cd "$1"
}

path() {
  printf "$PATH\n" | tr ":" "\n"
}

ticks() {
  if [[ $1 = "-r" ]]; then
    local tticks="${2:?}"
    local epoc=$(((tticks - 621355968000000000) / 10000000))
    date -u -d "@$epoc" +%FT%T
  else
    local epoc=`date -u -d "${1:-now}" +%s`
    local tticks=$((epoc * 10000000 + 621355968000000000))
    printf "$tticks\n"
  fi
}

unset -f __source_if_readable
