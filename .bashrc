[[ "$-" != *i* ]] && return

[[ -f ~/.sdkman/bin/sdkman-init.sh ]] && . ~/.sdkman/bin/sdkman-init.sh

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

pdfview() {
  if [[ -z $1 ]]; then
    nohup evince &> /dev/null &
  else
    nohup evince "$1" &> /dev/null &
  fi
}
