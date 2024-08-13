function project --description 'Open project picker to navigate to project'
    pushd $(ls -d ~/dev/* | fzf --prompt 'Project> ')
    commandline -f repaint
end
