" for some reason the first two don't work - actives in wrong buffer?
nmap <leader>cs :execute "new +set\\ ft=" . &filetype . "\\<bar>Codi"<CR>
nmap <leader>cv :execute "vnew +set\\ ft=" . &filetype . "\\<bar>Codi"<CR>
nmap <leader>cc :execute "tabe +set\\ ft=javascript\\<bar>Codi"<CR>
nmap <leader>cr :CodiUpdate<CR>
