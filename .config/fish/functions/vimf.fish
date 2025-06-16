function vimf --description 'Open file picker to open a file in vim'
    fzf --prompt 'Open File> ' --bind 'enter:become(vim {1})'
end
