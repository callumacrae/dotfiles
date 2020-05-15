let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_show_hidden = 1

" \p will enter currently highlighted text into CtrlP
vnoremap <Leader>p "py:CtrlP<CR>:call feedkeys("\<C-\>rp")<CR>
