set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()            " required
filetype plugin indent on    " required

" Colour Theme
colorscheme gruvbox
set background=dark
set termguicolors
if (&term =~ "tmux") || (&term =~ "screen")
    "termguicolors only sets t_8f and t_8b for $TERM~=xterm. Manually set t_8f and t_8b for tmux or screen
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif
set ttimeoutlen=10 "airline mode change display update speed depends on this variable. increase on bad connectivity

" features
set noswapfile
set nowritebackup
set nobackup
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set incsearch
set breakindent
set textwidth=9999999
syntax on

" mappings
nnoremap <silent> <leader><leader> :nohl<CR>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap <silent> <F2> :set paste!<CR>
nnoremap <F8> :YcmCompleter GoTo<CR>
