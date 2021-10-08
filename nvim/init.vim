autocmd! bufwritepost .vimrc source %

call plug#begin('~/.vim/plugged')
Plug 'rust-lang/rust.vim' 
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
"Plug 'vim-airline/vim-airline'
Plug 'shadmansaleh/lualine.nvim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'} | Plug 'junegunn/fzf.vim' " fuzzy finder
Plug 'luochen1990/rainbow' " color parentheses
Plug 'dense-analysis/ale' " checker syntax
Plug 'posva/vim-vue'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive' " git extension for commit logs and etc.
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'
Plug 'jmcantrell/vim-virtualenv'

Plug 'ryanoasis/vim-devicons'

Plug 'google/vim-searchindex'

call plug#end()            " required

syntax on
colorscheme miramare

set clipboard=unnamed
set mouse=a " click with mouse
set wildmenu
set wildmode=longest,list:full
set wildignore=*~,*.png,*.jpg,*.gif,Thumbs.db,*.min.js,*.swp,*.o,vendor


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

set encoding=UTF-8
set history=1000
set wildignore+=*.pyc

set hlsearch " highlight search
set incsearch

set nowritebackup
set laststatus=2

set cursorline

set list " spaces as characters
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵

set foldmethod=indent

set splitright " split on right side
set lazyredraw
set ttyfast

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

let g:fzf_preview_window = 'right:70%'

let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '🛑'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_info = '💭'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] [%linter%] %s'
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 3

let b:ale_linters = {
\   'python': ['flake8', 'pylint', 'mypy'],
\   'cpp': ['clang'],
\   'c': ['clang'],
\}

let b:ale_fixers = {
\   'python': ['black', 'isort'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'vue': ['prettier'],
\   'html': ['prettier'],
\   'cpp': ['clang-format'],
\   'c': ['clang-format'],
\}


set statusline^=%{coc#status()}
let g:airline#extensions#coc#enabled = 0

if has('nvim')
    lua require('evil_lualine')
    lua require('git')
endif

let g:indentLine_char = '¦'

let g:vue_pre_processors = ['pug', 'scss']

let g:netrw_liststyle=1

filetype plugin indent on
set nocompatible

set showcmd " show commands at bottom

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" ------------
" MAPS
" -----------
nnoremap j gj
nnoremap k gk

nnoremap tn :tabnew<CR>
nnoremap :ve :Vexplore<CR>
nnoremap :rt :RainbowToggle<CR>

" buffers
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap ,b :Buffers<CR>

" tabs
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>
nnoremap ,t :tabs<CR>

" only one window
nnoremap ,o :only<CR>


" mapping fzf commands
" ff = open files explorer
" co = open commits explorer
" gf = open git ls-files
" gs = open git status
nnoremap :ff :Files .<CR>
nnoremap :co :Commits<CR>
nnoremap :gf :GFiles<CR>
nnoremap :gs :GFiles?<CR>
nnoremap :gd :Git diff<CR>

nnoremap :pa :set paste<CR>
nnoremap :npa :set nopaste<CR>


nmap :cr :!command cargo r<CR>
nmap <F6> :EditorConfigReload<CR>


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"VimDiff shortcuts
if &diff
  "Get from remote
  nnoremap dr :diffget<Space>RE<CR>
  "Get from base
  nnoremap db :diffget<Space>BA<CR>
  "Get from local
  nnoremap dl :diffget<Space>LO<CR>
endif
