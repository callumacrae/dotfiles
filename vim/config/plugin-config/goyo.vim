let g:goyo_width = 100

function! s:goyo_enter()
	set rnu
	set nu
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
