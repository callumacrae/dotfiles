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

Plug 'sheerun/vim-polyglot'

" Code writing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'
Plug 'AndrewRadev/tagalong.vim'
" Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'mattn/emmet-vim'

Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'
Plug 'glts/vim-textobj-comment'
Plug 'sgur/vim-textobj-parameter'
Plug 'whatyouhide/vim-textobj-xmlattr'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tveskag/nvim-blame-line'
Plug 'tpope/vim-fugitive'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/vim-peekaboo'
Plug 'Yilin-Yang/vim-markbar'

Plug 'junegunn/goyo.vim'

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

set colorcolumn=80,100

set splitbelow
set splitright
