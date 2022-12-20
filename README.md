# dotfiles

## Installation on macOS

```sh
# Install the Command Line Tools for Xcode
xcode-select --install

# Install the Homebrew
# see https://brew.sh/
curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | /bin/bash

# Install the SDKMAN!
# see https://sdkman.io/
export SDKMAN_DIR="$HOME/.config/sdkman" && \
  curl -fsSL "https://get.sdkman.io" | /bin/bash

# Install the dein.vim
# see https://github.com/Shougo/dein.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/santosned/dein.vim/master/bin/installer.sh)"

# Clone this repository
mkdir -p $HOME/github.com/sciencesakura && cd $_
git clone --depth=1 git@github.com:sciencesakura/dotfiles.git
cd dotfiles/

# Make links to the dotfiles
./scripts/make-symlinks.sh

# Restart the terminal
exit

# Install packages via Homebrew
./scripts/install-packages.sh homebrew dev dev-java dev-web dev-docker dev-gke desktop

# Use bash as a login shell
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"
```
