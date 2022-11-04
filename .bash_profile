__bash_profile__source() {
  [[ -r $1 ]] && . "$1"
}

#
# common profile
#
__bash_profile__source "$HOME/.profile"

#
# for interactive shell
#
__bash_profile__source "$HOME/.bashrc"

#
# environment variables for bash
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=gs:kc:kn:l.:ll:ls:pwd:top:tree
export HISTTIMEFORMAT='%F %T '
export PROMPT_DIRTRIM=4
if type __git_ps1 &> /dev/null; then
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ '
else
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
fi

# add gcloud components to PATH
type brew &> /dev/null && \
  __bash_profile__source "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"

unset -f __bash_profile__source
