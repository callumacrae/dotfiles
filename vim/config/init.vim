source ~/.vimrc

call plug#begin(stdpath('data') . '/plugged')

" Appearance
Plug 'srcery-colors/srcery-vim'

" Code intelligence and highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-spell-checker', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
Plug 'statico/vim-javascript-sql'

Plug 'sheerun/vim-polyglot'

" Code writing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
" Plug 'AndrewRadev/tagalong.vim' - buggy, use vim-surround instead
" Plug 'jiangmiao/auto-pairs' - buggy, coc-pairs is better
" Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'mattn/emmet-vim'
" Plug 'mogelbrod/vim-jsonpath'

Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'
" Plug 'glts/vim-textobj-comment' - conflicts with vim-textobj-css
Plug 'jasonlong/vim-textobj-css'
Plug 'sgur/vim-textobj-parameter'
Plug 'whatyouhide/vim-textobj-xmlattr'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tveskag/nvim-blame-line'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'junegunn/vim-peekaboo'
" Plug 'Yilin-Yang/vim-markbar'

" Plug 'junegunn/goyo.vim'

Plug 'rizzatti/dash.vim'

call plug#end()

for f in split(glob('~/.dotfiles/vim/config/plugin-config/*.vim'), "\n")
  execute 'source' f
endfor

colorscheme srcery
set termguicolors

" misc
nnoremap <leader>ve :tabe $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

vmap <leader>l Sfconsole.log<CR>
nmap <leader>l yssfconsole.log<CR>

" is there a nicer way to do this?
nnoremap [t vato<Esc>
nnoremap ]t vat<Esc>

" Fix performance issue with vim-vue https://github.com/posva/vim-vue#vim-slows-down-when-using-this-plugin-how-can-i-fix-that
let g:vue_pre_processors = ['scss', 'typescript']

set colorcolumn=80,100

set splitbelow
set splitright

set scrolloff=10

set foldopen-=block

set inccommand=nosplit
