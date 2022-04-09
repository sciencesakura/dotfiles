__source_file() {
  [[ -r $1 ]] && . "$1"
}

#
# common profile
#
__source_file "$HOME/.profile"

#
# for interactive
#
__source_file "$HOME/.bashrc"

#
# environment variables for bash
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=ll:ls:q:s
export HISTTIMEFORMAT='%F %T '
export PROMPT_DIRTRIM=4
if type __git_ps1 &> /dev/null; then
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ '
else
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
fi

#
# others
#
if type brew &> /dev/null; then
  __source_file "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi
__source_file "$HOME/.sdkman/bin/sdkman-init.sh"

unset -f __source_file
