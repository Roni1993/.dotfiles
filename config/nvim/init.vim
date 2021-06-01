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

"install vim-plug if not existing
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-rooter'

Plug 'wincent/terminus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'yuttie/comfortable-motion.vim'

"Plug 'valloric/youcompleteme'

Plug 'ThePrimeagen/vim-be-good', {'do': './install.sh'}
call plug#end()

colorscheme base16-summerfruit-light
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
let g:goyo_width = 100

highlight clear Normal
highlight clear NonText
highlight clear LineNr

let mapleader = " "
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>


" set nice scrolling
nnoremap <silent> <leader>j :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <leader>k :call comfortable_motion#flick(-100)<CR>

let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
