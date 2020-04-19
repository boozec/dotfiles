set number
set tabstop=4
set shiftwidth=4
set expandtab    
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'
"Plugin 'itchyny/lightline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plugin 'junegunn/fzf.vim'
Plugin 'luochen1990/rainbow'
Plugin 'dense-analysis/ale'

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 20

set ai
set autoread
set encoding=utf-8
set history=1000
set wildignore+=*.pyc
set wrap
set hlsearch
set incsearch
set nowritebackup
set laststatus=2
set cursorline
set ruler
set list
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵

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
set showcmd
