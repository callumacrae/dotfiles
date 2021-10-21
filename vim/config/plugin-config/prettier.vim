let clang_formats = ['cpp', 'c']

" Use prettier for everything but c and cpp (too lazy to list file types)
autocmd FileType * if index(clang_formats, &ft) < 0 | nmap <leader>p <Plug>(Prettier)

command! ClangFormat :pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py
autocmd FileType * if index(clang_formats, &ft) >= 0 | map <silent> <leader>p :ClangFormat<CR>
