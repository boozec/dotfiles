set number
set tabstop=4
set shiftwidth=4
set expandtab    
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

set ai
set autoread
set encoding=utf-8
set history=1000
set wildignore+=*.pyc
set wrap
set hlsearch
set incsearch
set visualbell
set laststatus=2

call vundle#end()            " required
filetype plugin indent on    " required
set nocompatible              " be iMproved, required
filetype off                  " required

syntax on

colorscheme gruvbox-hard
"colorscheme synthwave
set showcmd
