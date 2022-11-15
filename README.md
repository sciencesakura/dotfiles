# dotfiles

## macOS

### Requirements

```sh
# 1. Command Line Tools for Xcode
xcode-select --install

# 2. Homebrew
curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" | /bin/bash

# 3. SDKMAN! (optional)
curl -fsSL "https://get.sdkman.io" | /bin/bash
```

### Installation

```sh
# 1. Clone this repository
mkdir -p $HOME/github.com/sciencesakura && cd $_
git clone --depth=1 git@github.com:sciencesakura/dotfiles.git
cd dotfiles/

# 2. Make links to the dotfiles
./make-symlinks.sh

# 3. Restart the terminal

# 4. Install packages via Homebrew
./install-packages.sh homebrew dev dev-java dev-web dev-gke
```

### Configurations

```sh
# 1. Use bash as a login shell
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"
```
