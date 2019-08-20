set number
set tabstop=4
set shiftwidth=4
set expandtab    
set runtimepath+=~/.vim/bundle/swift.vim

set autoindent
set autoread
set encoding=utf-8
set history=1000
set wildignore+=*.pyc
set wrap

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'davidhalter/jedi-vim'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
colorscheme gruvbox-hard
