noremap <silent> <C-p> :Files<CR>

" https://github.com/junegunn/fzf.vim/issues/672
" @TODO can i get this working again with fzf
" vnoremap <Leader>p "py:CtrlP<CR>:call feedkeys("\<C-\>rp")<CR>
" vnoremap <Leader>p "py:FZF -q <c-r>p<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
