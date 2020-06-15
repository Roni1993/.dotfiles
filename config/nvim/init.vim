syntax on

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8


call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'

Plug 'junegunn/goyo.vim'
Plug 'wincent/terminus'
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-one'
Plug 'yuttie/comfortable-motion.vim'

Plug 'valloric/youcompleteme'
Plug 'sheerun/vim-polyglot'

Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
call plug#end()

colorscheme one
set background=light
let g:airline_theme='one'
let g:airline_powerline_fonts = 1
let g:one_allow_italics = 1 
let g:goyo_width = 120

highlight Normal guibg=none
highlight NonText guibg=none
