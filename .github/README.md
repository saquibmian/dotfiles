# dotfiles

[fish](https://fishshell.com), [neovim](https://neovim.io), [kitty](https://sw.kovidgoyal.net/kitty/), [macOS](https://www.apple.com/macos/)

## Setup

```console
$ cd ~
$ git init
$ git remote add origin https://github.com/saquibmian/dotfiles
$ git fetch
$ git checkout -f main
$ git config status.showUntrackedFiles no
```

## Manual Steps (for MacOS)

[Install Homebrew](https://docs.brew.sh/Installation):

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the base dependencies in the [Brewfile](./.Brewfile):

```sh
brew bundle install --global
```

[Set the default shell for the user to `fish`](https://fishshell.com/docs/current/index.html#default-shell):

```sh
# Ensure that "$(command -v fish)" is in /etc/shells
echo -s $(command -v fish) | sudo tee -a /etc/shells
chsh -s $(command -v fish)
```

Set up fonts in Kitty (see [kitty.conf](/.config/kitty/kitty.conf) for details)

