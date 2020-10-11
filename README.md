```sh
# macOS
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew install git
mkdir -p $HOME/works && cd $_
git clone git@github.com:sciencesakura/dotfiles.git
./dotfiles/setup/setup-mac.sh
```
