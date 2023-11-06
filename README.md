# dotfiles

```sh
mkdir -p $HOME/github.com/sciencesakura && cd $_
git clone --depth=1 git@github.com:sciencesakura/dotfiles.git
cd dotfiles/

# Make links to the dotfiles
./scripts/make-symlinks.sh
```

## Installation on macOS

### Install the Command Line Tools for Xcode

```sh
xcode-select --install
```

### Install the Homebrew

See https://brew.sh/

### Install packages via Homebrew

```sh
./scripts/install-packages.sh homebrew [TSV_NAME...]
```

### Use bash as a login shell

```sh
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/bash"
```
