[[ "$-" != *i* ]] && return

__bashrc__source() {
  [[ -r $1 ]] && . "$1"
}

__bashrc__source /etc/bashrc

alias :q=exit
alias cp='cp -i'
alias grep='grep --color=auto'
alias gs='git status'
alias jobs='jobs -l'
alias kc=kubectx
alias kn=kubens
alias l.='ls -d .*'
alias ll='ls -l'
alias ls='ls -F --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias path='printf "$PATH\n" | tr : \\n'
alias rename='rename -v'
alias tree='tree -C'

type brew &> /dev/null && \
  __bashrc__source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

__bashrc__source "$HOME/.sdkman/bin/sdkman-init.sh"

#
# mkdir and cd
#
mkcd() {
  mkdir -p "$@" && cd "$1"
}

#
# replace CRLF with LF
#
crlf2lf() {
  nkf --overwrite -Lu "$@"
}

#
# replace LF with CRLF
#
lf2crlf() {
  nkf --overwrite -Lw "$@"
}

#
# add BOM to the specified UTF-8 file
#
utf8bom() {
  nkf --overwrite --ic=UTF-8 --oc=UTF-8-BOM "$@"
}

#
# remove BOM from the specified UTF-8 file
#
rmutf8bom() {
  nkf --overwrite --ic=UTF-8-BOM --ic=UTF-8 "$@"
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
