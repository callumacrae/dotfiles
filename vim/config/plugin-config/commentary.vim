" Support 3gcc
" https://github.com/tomtom/tcomment_vim/issues/179#issuecomment-603665075
autocmd VimEnter * nmap <expr> gcc v:count? ":<c-u><cr>gc".(v:count1-1)."j" : ":TComment<CR>"

" Muscle memory from commentary 😬 (and it's easier to type)
nmap gcap gcip
