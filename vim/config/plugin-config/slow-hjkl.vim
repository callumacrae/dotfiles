let g:slowhjkl = 1

function SlowDirection(direction)
  if g:slowhjkl && !v:count
    sleep 200m
  endif
  let count = v:count == 0 ? 1 : v:count

	if count >= 5
		" Save current position to jumplist
		mark '
	endif
  exec 'normal! ' . count . a:direction
endfunction

nnoremap <silent> h :<C-u>call SlowDirection('h')<CR>
nnoremap <silent> j :<C-u>call SlowDirection('j')<CR>
nnoremap <silent> k :<C-u>call SlowDirection('k')<CR>
nnoremap <silent> l :<C-u>call SlowDirection('l')<CR>

