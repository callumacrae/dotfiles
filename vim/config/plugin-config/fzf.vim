noremap <silent> <C-p> :Files<CR>

nmap <Leader>gf "pyiq:execute ":FZF -q " . getreg("p")<CR>
vnoremap <Leader>gf "py:execute ":FZF -q " . getreg("p")<CR>

nnoremap <Leader>* "pyiw:execute ":Ag " . getreg("p")<CR>
vnoremap <Leader>* "py:execute ":Ag " . getreg("p")<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
