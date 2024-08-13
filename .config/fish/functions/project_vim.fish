function project_vim --description 'Open project picker to open a project in NeoVIM'
    ls -d ~/dev/* | fzf --prompt 'Open Project> ' --bind 'enter:become(vim {1})'
end
