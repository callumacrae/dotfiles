command! ClangFormat :pyf /usr/local/Cellar/clang-format/11.0.0/share/clang/clang-format.py

function PrettierMaybe()
  let clang_formats = ['cpp', 'c']

  " Use prettier for everything but c and cpp (too lazy to list file types)
  if index(clang_formats, &ft) >= 0
    map <silent> <buffer> <leader>p :ClangFormat<CR>
  else
    nmap <buffer> <leader>p <Plug>(Prettier)
  endif
endfunction

autocmd FileType * call PrettierMaybe()
