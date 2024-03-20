autocmd! bufwritepost .vimrc source %

call plug#begin('~/.vim/plugged')

Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'rust-lang/rust.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive' " git extension for commit logs and etc.
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'

Plug 'google/vim-searchindex'

Plug 'numToStr/Comment.nvim'

Plug 'matze/vim-move'

Plug 'togglebyte/togglerust' " Debug Rust projects

Plug 'chriskempson/base16-vim'

" Plug 'editorconfig/editorconfig-vim'

if has('nvim')
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'

    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'saecki/crates.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'folke/lsp-colors.nvim'

    Plug 'sindrets/diffview.nvim'
endif


call plug#end()            " required

syntax on

set runtimepath+=~/.vim-plugins/LanguageClient-neovim

set completeopt=menu,menuone,noselect

set clipboard=unnamed
set mouse=a " click with mouse
set wildmenu
set wildmode=full
set wildignore=*~,*.png,*.jpg,*.gif,Thumbs.db,*.min.js,*.swp,*.o,vendor,*.pyc

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

set hlsearch " highlight search
set incsearch

set nowritebackup
set laststatus=2

set list " spaces as characters
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵

set foldmethod=indent

set splitright " split on right side
set splitbelow
set lazyredraw
set ttyfast

set noswapfile

set termguicolors
set background=dark

" copy with `y` to clipboard
set clipboard+=unnamedplus

if has('nvim')
    let base16colorspace=256
    colorscheme base16-irblack

    highlight LineNr guibg=NONE
    highlight CursorLine guibg=NONE
    highlight CursorLineNr guibg=NONE guifg=YELLOW
    highlight StatusLine guibg=NONE guifg=YELLOW
    highlight StatusLineNC guibg=NONE guifg=#dddddd
    highlight SignColumn guibg=NONE
    highlight GitGutterChange guibg=NONE
    highlight GitGutterAdd guibg=NONE
    highlight GitGutterDelete guibg=NONE

    lua require('git')
    let g:coq_settings = { 'auto_start': v:true }
    lua require('lsp_conf')

    lua require('nvim-tree').setup({ actions = { open_file = { quit_on_open = true } } })
    lua require('todo-comments').setup()
    lua require('crates').setup()

    lua require('nvim-treesitter.configs').setup({ highlight = { enable = true, }, })

    lua require('lsp-colors').setup()

    lua require('Comment').setup()

    lua require('diffview').setup()
    ca do DiffviewOpen
    ca dc DiffviewClose
    ca dh DiffviewFileHistory

    " Launch gopls when Go files are in use
    let g:LanguageClient_serverCommands = {
           \ 'go': ['gopls']
           \ }
    " Run gofmt on save

    set cursorline " need for Neovim 0.6 for highlight CursorLineNr
else
    colorscheme gruvbox
endif

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" indentline
let g:indentLine_char = '¦'
let g:vim_json_syntax_conceal = 0

let g:netrw_liststyle=1

filetype plugin indent on
set nocompatible

set showcmd " show commands at bottom

" nvim-tree
nnoremap <C-t> :NvimTreeToggle<CR>

" vim-move
let g:move_key_modifier = 'C'

" ------------
" MAPS
" -----------
let mapleader = ","

nnoremap j gj
nnoremap k gk

nnoremap tn :tabnew<cr>

nnoremap <leader>xx :TroubleToggle<cr>
nnoremap <leader>xf :TodoQuickFix<cr>

" buffers
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap <leader>b <cmd>Telescope buffers<cr>

" tabs
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" only one window
nnoremap <leader>o :only<CR>


nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>pa :set paste<CR>
nnoremap <leader>npa :set nopaste<CR>


nmap <leader>cr :Cargo run<CR>

if &diff
  "Get from remote
  nnoremap dr :diffget<Space>RE<CR>
  "Get from base
  nnoremap db :diffget<Space>BA<CR>
  "Get from local
  nnoremap dl :diffget<Space>LO<CR>
endif

packadd termdebug
let g:termdebug_wide = 1
let g:TermDebugging = 0
