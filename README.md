# dotfiles

## Installation on macOS

```sh
# Install the Command Line Tools for Xcode
xcode-select --install

# Install the tmux-256color
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gzip -d terminfo.src.gz
sudo /usr/bin/tic -xe tmux-256color terminfo.src

# Install the Homebrew
curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | /bin/bash

# Install the SDKMAN!
curl -fsSL "https://get.sdkman.io" | /bin/bash

# Clone this repository
mkdir -p $HOME/github.com/sciencesakura && cd $_
git clone --depth=1 git@github.com:sciencesakura/dotfiles.git
cd dotfiles/

# Make links to the dotfiles
./make-symlinks.sh

# Restart the terminal
exit

# Install packages via Homebrew
./install-packages.sh homebrew dev dev-java dev-web dev-gke desktop

# Use bash as a login shell
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"
```
