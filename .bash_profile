__source_file() {
  [[ -r $1 ]] && . "$1"
}

__source_file "$HOME/.profile"
__source_file "$HOME/.bashrc"

if type brew &> /dev/null; then
  __source_file "$(brew --caskroom)/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi
__source_file "$HOME/.sdkman/bin/sdkman-init.sh"

unset -f __source_file
