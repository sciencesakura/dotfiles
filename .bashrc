[[ $- = *i* ]] || return

__profile__os="$(uname -s)"

__bashrc__source() {
  [[ -f $1 ]] && . "$1"
}

if [[ $__profile__os = Darwin ]]; then
  alias cp='/bin/cp -ci'
else
  alias cp='\cp -i'
fi

if type dircolors >/dev/null 2>&1; then
  [[ -r $HOME/.dircolors ]] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
  alias ls='\ls --color=auto'
  alias grep='\grep --color=auto'
fi

alias :q=exit
alias ..='\cd ..'
alias ll='ls -lAF'
alias mkdir='\mkdir -p'
alias mv='\mv -i'
alias rename='\rename -v'
alias jobs='\jobs -l'
alias mvn='\mvn -e'
alias mvnw='./mvnw -e'

alias gs='git status'
alias kc=kubectx
alias kn=kubens

alias path='printf "$PATH\n" | tr : \\n'
alias jgrep='grep -n -r --include=*.java --exclude-dir={build,target,test}'
alias tsgrep='grep -n -r --include={*.ts,*.tsx} --exclude-dir={dist,node_modules}'

# bash-completiion
type brew >/dev/null 2>&1 && __bashrc__source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

#
# environment variables for interactive shell
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=date:gs:kc:kn:ll:ls:pbpaste:pwd:tig:top:tree
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=131072
export PROMPT_DIRTRIM=2
if type __git_ps1 >/dev/null 2>&1; then
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ '
else
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
fi
 
#
# mkdir and cd
#
mkcd() {
  mkdir -p "$@" && cd "$1"
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

unset -f __bashrc__source
unset -v __profile__os
