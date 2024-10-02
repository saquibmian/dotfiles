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

bind \cf project
bind \co project_vim
