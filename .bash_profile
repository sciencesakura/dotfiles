__source_file() {
  [[ -r $1 ]] && . "$1"
}

#
# common profile
#
__source_file "$HOME/.profile"

#
# environment variables for bash
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=ll:ls:q:s
export HISTTIMEFORMAT="%F %T "
export PROMPT_DIRTRIM=4
export PS1="\[\e[33m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\] \[\e[36m\]\w\[\e[0m\]\$ "

#
# for interactive
#
__source_file "$HOME/.bashrc"

#
# others
#
if type brew &> /dev/null; then
  __source_file "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi
__source_file "$HOME/.sdkman/bin/sdkman-init.sh"

unset -f __source_file
