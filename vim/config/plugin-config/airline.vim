let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_theme = 'srcery'

function! GetSignatureText()
  let status = luaeval('require("lsp_signature").status_line(80)')
  return status.label
endfunction

call airline#parts#define_function('signature', 'GetSignatureText')

let g:airline_section_a = ''
" let g:airline_section_x = airline#section#create(['signature'])
let airline_section_x = ''
let g:airline_section_y = airline#section#create(['filetype'])
let g:airline_section_z = '♥️ '

let g:airline#extensions#branch#displayed_head_limit = 20
let g:airline#extensions#branch#format = 1
