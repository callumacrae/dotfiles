" Support 3gcc
" https://github.com/tomtom/tcomment_vim/issues/179#issuecomment-603665075
nmap <expr> gcc v:count? ":<c-u><cr>gc".(v:count1-1)."j" : ":TComment<CR>"
