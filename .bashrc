[[ "$-" != *i* ]] && return

[[ -f ~/.sdkman/bin/sdkman-init.sh ]] && . ~/.sdkman/bin/sdkman-init.sh

alias q='exit'
alias ls='ls --color'
alias ll='ls -lA'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias tree='tree -C'
alias rename='rename -v'
alias grep='grep --color'
alias g='git'
alias s='git status'

mkcd() {
  mkdir "$@" && cd "$1"
}
