[[ $- = *i* ]] || return

__profile__os="$(uname -s)"

__bashrc__source() {
  [[ -f $1 ]] && . "$1"
}

shopt -s checkwinsize
shopt -s histappend

if type dircolors >/dev/null 2>&1; then
  [[ -r $HOME/.dircolors ]] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
  alias ls='\ls --color=auto'
  alias grep='\grep --color=auto'
fi

alias :q=exit
alias ..='\cd ..'
alias ll='ls -lAF'
alias mkdir='\mkdir -p'
if [[ $__profile__os = Darwin ]]; then
  alias cp='/bin/cp -ci'
else
  alias cp='\cp -i'
fi
alias mv='\mv -i'
alias rename='\rename -v'
alias jobs='\jobs -l'
alias mvn='\mvn -e'
alias mvnw='./mvnw -e'

alias gs='git status'
alias kc=kubectx
alias kn=kubens
if [[ -e /etc/debian_version ]]; then
  alias dateadd=dateutils.dadd
  alias dateconv=dateutils.dconv
  alias datediff=dateutils.ddiff
  alias dategrep=dateutils.dgrep
  alias dateround=dateutils.dround
  alias dateseq=dateutils.dseq
  alias datesort=dateutils.dsort
  alias datetest=dateutils.dtest
  alias datezone=dateutils.dzone
  alias strptime=dateutils.strptime
fi

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias path='printf "$PATH\n" | tr : \\n'
alias jgrep='grep -n -r --include=*.java --exclude-dir={build,target,test}'
alias tsgrep='grep -n -r --include={*.ts,*.tsx} --exclude-dir={dist,node_modules}'

if [[ "$__profile__os" != Darwin ]]; then
  if type xclip >/dev/null 2>&1; then
    alias pbcopy='xclip -r -selection clipboard'
    alias pbpaste='xclip -o -r -selection clipboard'
  fi
fi

__bashrc__source "$HOME/.bash_aliases"

# bash-completiion
if ! shopt -oq posix; then
  if type brew >/dev/null 2>&1; then
    __bashrc__source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# environment variables for interactive shell
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=date:gs:jobs:kc:kn:ll:ls:pwd:tig:top:tree
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=131072
export PROMPT_DIRTRIM=2

# prompt
if [[ $TERM = xterm-color ]] || [[ $TERM = *-256color ]]; then
  if type __git_ps1 >/dev/null 2>&1; then
    export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ '
  else
    export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
  fi
fi

# sdkman
if [[ -n $SDKMAN_DIR ]]; then
  __bashrc__source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

# mkdir and cd
mkcd() {
  mkdir -p "$@" && cd "$1"
}

unset -f __bashrc__source
unset -v __profile__os
