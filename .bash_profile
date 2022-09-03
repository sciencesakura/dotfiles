__bash_profile__source() {
  [[ -r $1 ]] && . "$1"
}

export __OS_NAME="$(uname -s)"

#
# common profile
#
__bash_profile__source "$HOME/.profile"

#
# for interactive
#
__bash_profile__source "$HOME/.bashrc"

#
# environment variables for bash
#
export HISTCONTROL=ignorespace:erasedups
export HISTIGNORE=gs:kc:kn:ll:ls:pwd
export HISTTIMEFORMAT='%F %T '
export PROMPT_DIRTRIM=4
if type __git_ps1 &> /dev/null; then
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[1;31m\]$(__git_ps1)\[\e[m\]$ '
else
  export PS1='\[\e[33m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\]$ '
fi

if [[ $__OS_NAME = 'Darwin' ]]; then
  type brew &> /dev/null && \
    __bash_profile__source "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

unset -f __bash_profile__source
