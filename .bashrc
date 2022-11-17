[[ $- = *i* ]] || return

__bashrc__source() {
  [[ -f $1 ]] && . "$1"
}

if type dircolors >/dev/null 2>&1; then
  [[ -r $HOME/.dircolors ]] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
  alias diff='diff --color=auto'
  alias grep='grep --color=auto'
  alias ls='ls --color=auto'
  alias tree='tree -C'
fi

alias :q=exit
alias cp='cp -i'
alias gs='git status'
alias jobs='jobs -l'
alias kc=kubectx
alias kn=kubens
alias l.='ls -dF .*'
alias ll='ls -lF'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias rename='rename -v'

alias path='printf "$PATH\n" | tr : \\n'
alias crlf2lf='nkf --overwrite -Lu'
alias lf2crlf='nkf --overwrite -Lw'
alias bom-utf8='nkf --overwrite --ic=UTF-8 --oc=UTF-8-BOM'
alias unbom-utf8='nkf --overwrite --ic=UTF-8-BOM --ic=UTF-8'

# bash-completiion
type brew >/dev/null 2>&1 && __bashrc__source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

#
# environment variables for interactive shell
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=gs:kc:kn:l.:ll:ls
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=131072
export PROMPT_DIRTRIM=4
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
