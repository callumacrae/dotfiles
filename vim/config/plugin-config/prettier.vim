let clang_formats = ['cpp', 'c']

" Use prettier for everything but c and cpp (too lazy to list file types)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd BufWritePre * if index(clang_formats, &ft) < 0 | do nmap <silent> <leader>p :Prettier<CR>

command! ClangFormat :pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py
autocmd BufWritePre * if index(clang_formats, &ft) >= 0 | do map <silent> <leader>p :ClangFormat<CR>
