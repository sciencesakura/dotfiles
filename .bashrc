[[ "$-" != *i* ]] && return

__bashrc_source_file() {
  [[ -r $1 ]] && . "$1"
}

alias q=exit
alias ls='ls --color=auto'
alias ll='ls -lA'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias tree='tree -C'
alias rename='rename -v'
alias grep='grep --color=auto'
alias s='git status'

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

if type brew &> /dev/null; then
  __bashrc_source_file "$(brew --prefix)/etc/bash_completion.d/docker"
  __bashrc_source_file "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
  __bashrc_source_file "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
  __bashrc_source_file "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
fi

unset -f __bashrc_source_file
