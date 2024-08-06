function project --description 'Open project picker to navigate to project'
    pushd $(ls -d ~/dev/* | fzf)
    commandline -f repaint
end
