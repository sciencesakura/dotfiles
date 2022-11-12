# dotfiles

## Requirements

### macOS

```sh
# 1. Command Line Tools for Xcode
xcode-select --install

# 2. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Git
brew install git
```

## Installation

```sh
# 1. Clone this repository
mkdir -p $HOME/github.com/sciencesakura && cd $_
git clone --depth=1 git@github.com:sciencesakura/dotfiles.git
cd dotfiles/

# 2. Run the installation script
./make-symlinks.sh
```
