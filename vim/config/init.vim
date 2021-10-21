source ~/.vimrc

call plug#begin(stdpath('data') . '/plugged')

" Appearance
Plug 'srcery-colors/srcery-vim'

" Code intelligence and highlighting
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'sheerun/vim-polyglot'
Plug 'metakirby5/codi.vim'

" Code writing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'

Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'
" Plug 'glts/vim-textobj-comment' - conflicts with vim-textobj-css
Plug 'sgur/vim-textobj-parameter'
Plug 'whatyouhide/vim-textobj-xmlattr'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

for f in split(glob('~/.dotfiles/vim/config/plugin-config/*.{vim,lua}'), "\n")
  execute 'source' f
endfor

colorscheme srcery
set termguicolors

" misc
nnoremap <leader>ve :tabe $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" wrap text in console.log
vmap <leader>l Sfconsole.log<CR>
nmap <leader>l yssfconsole.log<CR>

" is there a nicer way to do this?
nnoremap [t vato<Esc>
nnoremap ]t vat<Esc>

" Fix performance issue with vim-vue https://github.com/posva/vim-vue#vim-slows-down-when-using-this-plugin-how-can-i-fix-that
let g:vue_pre_processors = ['scss', 'typescript']

lua << EOF
vim.opt.colorcolumn = { 80, 100 }

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10

vim.opt.inccommand = 'nosplit'
EOF
