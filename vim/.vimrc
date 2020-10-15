autocmd! bufwritepost .vimrc source %

set term=screen-256color
set clipboard=unnamed
set mouse=a " click with mouse

set number " number of the current line
set relativenumber " relative number, ..-2 -1 x 1 2, where x is current line
set textwidth=80
set colorcolumn=80
set nowrap
set fo-=t

set tabstop=4
set shiftwidth=4
set expandtab " convert tabs in spaces

set ai " auto indent
set autoread
set encoding=utf-8
set history=1000
set wildignore+=*.pyc

set hlsearch " highlight search
set incsearch " highlight search while type

set nowritebackup
set laststatus=2
set cursorline
set list " spaces as characters
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵

set foldmethod=indent

set splitright " split on right side
set lazyredraw
set ttyfast

"colorscheme gruvbox-hard

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

nnoremap tn :tabnew<CR>
nnoremap ve :Vexplore<CR>
nnoremap :rt :RainbowToggle<CR>

" mapping fzf commands
" ff = open files explorer
" co = open commits explorer
" gf = open git ls-files
" gs = open git status
nnoremap ff :Files .<CR>
nnoremap co :Commits<CR>
nnoremap gf :GFiles<CR>
nnoremap gs :GFiles?<CR>
nnoremap sp :set paste<CR>
nnoremap snp :set nopaste<CR>

let g:fzf_preview_window = 'right:70%'
let g:ale_fix_on_save = 1

filetype plugin indent on
set nocompatible

set showcmd " show commands at bottom
syntax on

colorscheme miramare
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'rust-lang/rust.vim' 
Plugin 'airblade/vim-gitgutter' " display git status of the file
Plugin 'vim-airline/vim-airline' " airline at bottom with insert, name, line etc.
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plugin 'junegunn/fzf.vim' " fuzzy finder
Plugin 'luochen1990/rainbow' " color parentheses
Plugin 'dense-analysis/ale' " checker syntax
Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()            " required
