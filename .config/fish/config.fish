set -gx EDITOR nvim

fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin
fish_add_path ~/.bun/bin

set -x FZF_DEFAULT_COMMAND 'rg --files'
set -x XDG_CONFIG_HOME "$HOME/.config"

if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/opt/homebrew/bin/brew shellenv)
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Created by `pipx` on 2025-04-15 16:52:41
fish_add_path ~/.local/bin
