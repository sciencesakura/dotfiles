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

# add gcloud components to PATH
type brew &> /dev/null && \
  __bash_profile__source "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"

unset -f __bash_profile__source
