[[ "$-" != *i* ]] && return

[[ -z $__OS_NAME ]] && export __OS_NAME="$(uname -s)"

__bashrc__source() {
  [[ -r $1 ]] && . "$1"
}

alias ls='ls --color=auto'
alias ll='ls -lA'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias tree='tree -C'
alias rename='rename -v'
alias grep='grep --color=auto'
alias jobs='jobs -l'

alias :q=exit
alias gs='git status'
alias kc=kubectx
alias kn=kubens

if type nkf &> /dev/null; then
  #
  # Replace CRLF with LF
  #
  crlf2lf() {
    nkf --overwrite -Lu "$@"
  }

  #
  # Replace LF with CRLF
  #
  lf2crlf() {
    nkf --overwrite -Lw "$@"
  }

  #
  # Add BOM to the specified UTF-8 file
  #
  utf8bom() {
    nkf --overwrite --ic=UTF-8 --oc=UTF-8-BOM "$@"
  }

  #
  # Remove BOM from the specified UTF-8 file
  #
  rmutf8bom() {
    nkf --overwrite --ic=UTF-8-BOM --ic=UTF-8 "$@"
  }
fi

#
# `mkdir` and `cd`
#
mkcd() {
  mkdir "$@" && cd "$1"
}

#
# Print the `PATH` environment variable
#
path() {
  printf "$PATH\n" | tr : \\n
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

if [[ $__OS_NAME = 'Darwin' ]]; then
  type brew &> /dev/null && \
    __bashrc__source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

unset -f __bashrc__source
