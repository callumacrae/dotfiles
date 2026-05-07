let s:oxfmt = {
  \ 'exe': 'oxfmt',
  \ 'args': ['--stdin-filepath', '"%:p"'],
  \ 'stdin': 1,
  \ }

for ft in ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'vue', 'json']
  let g:neoformat_{ft}_oxfmt = s:oxfmt
  let g:neoformat_enabled_{ft} = ['oxfmt', 'prettier']
endfor

let g:neoformat_try_node_exe = 1

map <silent> <leader>p <cmd>Neoformat<cr>
