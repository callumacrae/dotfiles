source ~/.vimrc

call plug#begin(stdpath('data') . '/plugged')

" Appearance
Plug 'srcery-colors/srcery-vim'

" Code intelligence and highlighting
Plug 'neovim/nvim-lspconfig'
Plug 'sbdchd/neoformat'

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

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip' " required for snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'ray-x/lsp_signature.nvim'

Plug 'github/copilot.vim', {'branch': 'release'}

" Navigation
Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'phaazon/hop.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/vimux'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rsi'
Plug 'klen/nvim-config-local', {'branch': 'main'}
Plug 'vim-test/vim-test'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }

" Plug 'bellini666/trouble.nvim', {'branch': 'main'}

call plug#end()

for f in split(glob('~/.dotfiles/vim/config/plugin-config/*.{vim,lua}'), "\n")
  execute 'source' f
endfor

colorscheme srcery
set termguicolors

" wrap text in console.log
vmap <leader>l Sfconsole.log<CR>
nmap <leader>l yssfconsole.log<CR>

" wrap contents of function in JSON.parse(JSON.stringify())
nmap <leader>sp ysi))iJSON.stringify<esc>ysi))iJSON.parse<esc>
vmap <leader>sp S)ysa))iJSON.parse<esc>laJSON.stringify<esc>

" " is there a nicer way to do this?
" " t = tag
" nnoremap [t vato<Esc>
" nnoremap ]t vat<Esc>

command! CpPath let @+=@%

" Fix performance issue with vim-vue https://github.com/posva/vim-vue#vim-slows-down-when-using-this-plugin-how-can-i-fix-that
" let g:vue_pre_processors = ['scss', 'typescript']
let g:vue_pre_processors = 'detect_on_enter'

command! Bonly %bd|e#

lua << EOF
vim.opt.colorcolumn = { 80, 100 }

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20

vim.opt.inccommand = 'nosplit'

vim.opt.mouse = ''

require('config-local').setup()
EOF
