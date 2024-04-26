[[ $- = *i* ]] || return

__profile__os="${__os:-$(uname -s)}"

__bashrc__source() {
  [[ -r $1 ]] && . "$1"
}

shopt -s checkwinsize
shopt -s histappend

#
# colors
#
if type dircolors &>/dev/null; then
  [[ -r $HOME/.dircolors ]] && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
fi

#
# aliases
#
if [[ $__profile__os = Darwin ]]; then
  alias cp='/bin/cp -civ'
  type ggrep &>/dev/null && alias grep='ggrep --color=auto' || alias grep='grep --color=auto'
  type gfind &>/dev/null && alias find=gfind
  type gsed &>/dev/null && alias sed=gsed
  type gxargs &>/dev/null && alias xargs=gxargs
else
  alias cp='cp -iv'
  alias grep='grep --color=auto'
  alias pbcopy='xclip -r -selection clipboard'
  alias pbpaste='xclip -o -r -selection clipboard'
fi

alias ..='cd ..'
alias :q=exit
alias df='df -h'
alias du='du -h'
alias gs='git status'
alias ip='ip --color=auto'
alias jobs='jobs -l'
alias kc=kubectx
alias kn=kubens
alias ls='ls --color=auto'
alias ll='ls -lAF'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias path='printf "$PATH\n" | tr : \\n'
alias rename='rename -v'
alias rm='rm -iv'

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

__bashrc__source "$HOME/.bash_aliases"

#
# functions
#
mkcd() {
  \mkdir -p "$@" && \cd "$1"
}

#
# completiion
#
if [[ -z $BASH_COMPLETION_VERSINFO ]]; then
  __bashrc__source /usr/share/bash-completion/bash_completion \
    || __bashrc__source /etc/bash_completion \
    || __bashrc__source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

#
# prompt
#
if [[ $TERM = xterm-color ]] || [[ $TERM = *-256color ]]; then
  type __git_ps1 &>/dev/null \
    && export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ ' \
    || export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
fi
export PROMPT_DIRTRIM=2

#
# history
#
export HISTCONTROL=ignoreboth
export HISTIGNORE=date:gs:jobs:kc:kn:ll:ls:pwd:tig:top:tree
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=131072

#
# fzf
#
export FZF_DEFAULT_OPTS='--cycle'
if [[ $TERM = xterm-color ]] || [[ $TERM = *-256color ]]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#1e2132,bg:#161821,spinner:#84a0c6,hl:#6b7089,fg:#c6c8d1,header:#6b7089,info:#b4be82,pointer:#84a0c6,marker:#84a0c6,fg+:#c6c8d1,prompt:#84a0c6,hl+:#84a0c6"
fi
export FZF_TMUX_OPTS='-p 80%'
__bashrc__source "$XDG_CONFIG_HOME/fzf/fzf.bash" \
  || __bashrc__source /usr/share/doc/fzf/examples/key-bindings.bash

#
# others
#
type pyenv &>/dev/null && eval "$(pyenv init -)"
__bashrc__source "$SDKMAN_DIR/bin/sdkman-init.sh"
__bashrc__source "$HOME/.bashrc.local"

unset -f __bashrc__source
unset -v __profile__os
