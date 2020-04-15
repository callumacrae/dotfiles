:source ~/.vimrc

call plug#begin(stdpath('data') . '/plugged')

" Code intelligence and highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}

Plug 'sheerun/vim-polyglot'

Plug 'jiangmiao/auto-pairs'

" Code writing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'editorconfig/editorconfig-vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tveskag/nvim-blame-line'

" Misc
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'

call plug#end()

" nvim-blame-line
nnoremap <silent> <leader>b :ToggleBlameLine<CR>
" autocmd BufEnter * EnableBlameLine

" coc-prettier
" @TODO put cocconfig in dotfiles repo
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <silent> <leader>p :Prettier<CR>

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
