" Automatically start nerdtree when opening nvim
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" Close vim if nerdtree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Leader commands
map <silent> <leader>n :NERDTreeToggleVCS<CR>
map <silent> <leader>m :NERDTreeFind<CR>

" Options
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['\.DS_Store$', '\.idea$', '\.git$']
let NERDTreeMinimalUI = 1
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
let g:ctrlp_dont_split = 'nerdtree'

" Change mappings to match CtrlP mappings
" let g:NERDTreeMapOpenSplit = 'x'
" let g:NERDTreeMapPreviewSplit = 'gx'
" let g:NERDTreeMapOpenVSplit = 'v'
" let g:NERDTreeMapPreviewVSplit = 'gv'
" let g:NERDTreeMapCloseDir = 'c'
" let g:NERDTreeMapCloseChildren = 'C'

autocmd FileType nerdtree nnoremap <buffer> <c-v> *@:call nerdtree#ui_glue#invokeKeyMap("s")<CR>

" Change mappings to match gitgitter mappings
let g:NERDTreeGitStatusMapNextHunk = ']h'
let g:NERDTreeGitStatusMapPrevHunk = '[h'
