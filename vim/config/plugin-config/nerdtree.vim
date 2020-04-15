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
