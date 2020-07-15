noremap <silent> <C-p> :Files<CR>

vnoremap <Leader>p "py:execute ":FZF -q " . getreg("p")<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
