[[ $- = *i* ]] || return

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
if [[ "$(uname -s)" = Darwin ]]; then
  alias cp='/bin/cp -civ'
else
  alias cp='cp -iv'
  alias pbcopy='xclip -r -selection clipboard'
  alias pbpaste='xclip -o -r -selection clipboard'
fi

alias ..='cd ..'
alias :q=exit
alias grep='grep --color=auto'
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
fbr() {
  local branches branch
  branches="$(\git --no-pager branch -vv)" \
    && branch="$(\echo "$branches" | \fzf-tmux -p 80% -- +m)" \
    && \git switch "$(\echo "$branch" | \sed -E "s/^\s*\*\s*//" | \awk '{print $1}')"
}

mkcd() {
  \mkdir -p "$@" && \cd "$1"
}

#
# completiion
#
if [[ -z $BASH_COMPLETION_VERSINFO ]]; then
  [[ -n $HOMEBREW_PREFIX ]] && __bashrc__source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" || \
    __bashrc__source /usr/share/bash-completion/bash_completion || \
    __bashrc__source /etc/bash_completion
fi

#
# prompt
#
export PROMPT_DIRTRIM=2
type __git_ps1 &>/dev/null && \
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ ' || \
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '

#
# history
#
export HISTCONTROL=ignoreboth
export HISTIGNORE=gs:htop:jobs:kc:kn:ll:ls:tig:top
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=131072

#
# fzf
#
export FZF_DEFAULT_OPTS='--cycle --color=fg:#c6c8d1,bg:#161821,hl:#6b7089,fg+:#d2d4de,bg+:#1e2131,hl+:#84a0c6,prompt:#84a0c6,pointer:#91acd1'
export FZF_TMUX_OPTS='-p 80%'
__bashrc__source "$XDG_CONFIG_HOME/fzf/fzf.bash" || __bashrc__source /usr/share/doc/fzf/examples/key-bindings.bash

#
# others
#
__bashrc__source "$HOME/.bashrc.local"

unset -f __bashrc__source
