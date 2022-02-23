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
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'

Plug 'kana/vim-textobj-user'
Plug 'fvictorio/vim-textobj-backticks'
" Plug 'glts/vim-textobj-comment' - conflicts with vim-textobj-css
Plug 'sgur/vim-textobj-parameter'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'beloglazov/vim-textobj-quotes'

" Navigation
Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'phaazon/hop.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'

" tmux
Plug 'callumacrae/vim-tmux-navigator' " includes https://github.com/christoomey/vim-tmux-navigator/pull/237
Plug 'preservim/vimux'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rsi'
Plug 'klen/nvim-config-local', {'branch': 'main'}

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

" wrap contents of function in JSON.parse(JSON.stringify())
nmap <leader>sp ysi))iJSON.stringify<esc>ysi))iJSON.parse<esc>

" is there a nicer way to do this?
nnoremap [t vato<Esc>
nnoremap ]t vat<Esc>

command! CpPath let @+=@%

" Fix performance issue with vim-vue https://github.com/posva/vim-vue#vim-slows-down-when-using-this-plugin-how-can-i-fix-that
" let g:vue_pre_processors = ['scss', 'typescript']
let g:vue_pre_processors = 'detect_on_enter'

lua << EOF
vim.opt.colorcolumn = { 80, 100 }

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20

vim.opt.inccommand = 'nosplit'

require('config-local').setup()
EOF
