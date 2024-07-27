__os="$(uname -s)"
__arch="$(uname -m)"

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
# others
#
__bash_profile__source "$HOME/.bash_profile.local"

unset -f __bash_profile__source
unset -v __arch __os
