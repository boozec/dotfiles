set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'rust-lang/rust.vim' 
Plugin 'airblade/vim-gitgutter' " display git status of the file
Plugin 'vim-airline/vim-airline' " airline at bottom with insert, name, line etc.
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plugin 'junegunn/fzf.vim' " fuzzy finder
Plugin 'luochen1990/rainbow' " color parentheses
Plugin 'dense-analysis/ale' " checker syntax

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

set number " number of the current line
set relativenumber " relative number, ..-2 -1 x 1 2, where x is current line
set mouse=a " click with mouse
set tabstop=4
set shiftwidth=4
set expandtab " convert tabs in spaces
set ai " auto indent
set autoread
set encoding=utf-8
set history=1000
set wildignore+=*.pyc
set wrap
set hlsearch " highlight search
set incsearch " highlight search while type
set nowritebackup
set laststatus=2
set cursorline
set list " spaces as characters
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵
set textwidth=80
set colorcolumn=80

nnoremap tn :tabnew<CR>
nnoremap ve :Vexplore<CR>
nnoremap di ciw
nnoremap rt :RainbowToggle<CR>

" mapping fzf commands
" ff = open files explorer
" co = open commits explorer
" gf = open git ls-files
" gs = open git status
nnoremap ff :Files .<CR>
nnoremap co :Commits<CR>
nnoremap gf :GFiles<CR>
nnoremap gs :GFiles?<CR>
let g:fzf_preview_window = 'right:70%'
let g:ale_fix_on_save = 1


call vundle#end()            " required
filetype plugin indent on    " required
set nocompatible              " be iMproved, required
filetype off                  " required

syntax on

colorscheme miramare
"colorscheme gruvbox-hard
set showcmd " show commands at bottom
