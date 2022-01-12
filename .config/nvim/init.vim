autocmd! bufwritepost .vimrc source %

call plug#begin('~/.vim/plugged')
Plug 'cespare/vim-toml', { 'branch': 'main' }
"Plug 'rust-lang/rust.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'luochen1990/rainbow' " color parentheses
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive' " git extension for commit logs and etc.
Plug 'editorconfig/editorconfig-vim'
Plug 'ap/vim-css-color'
Plug 'Yggdroot/indentLine'

Plug 'google/vim-searchindex'

Plug 'kazhala/close-buffers.nvim'
Plug 'numToStr/Comment.nvim'

Plug 'matze/vim-move'

if has('nvim')
    Plug 'rktjmp/lush.nvim'
    Plug 'ellisonleao/gruvbox.nvim'

    Plug 'nvim-telescope/telescope.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'folke/todo-comments.nvim'
    Plug 'saecki/crates.nvim'
    "Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'folke/trouble.nvim'
    Plug 'folke/lsp-colors.nvim'
endif


call plug#end()            " required

syntax on

set runtimepath+=~/.vim-plugins/LanguageClient-neovim

set completeopt=menu,menuone,noselect

set clipboard=unnamed
set mouse=a " click with mouse
set wildmenu
set wildmode=full
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

set cursorline " need for Neovim 0.6 for highlight CursorLineNr

set list " spaces as characters
set listchars=eol:⏎,tab:»·,trail:ˑ,nbsp:⎵

set foldmethod=indent

set splitright " split on right side
set lazyredraw
set ttyfast

set noswapfile

" rust
"   let g:rustfmt_autosave = 1
"   let g:rustfmt_emit_files = 1
"   let g:rustfmt_fail_silently = 0
"   let g:rust_clip_command = 'xclip -selection clipboard'

set termguicolors
set background=dark

if has('nvim')
    colorscheme gruvbox
    highlight CursorLine guibg=NONE
    highlight CursorLineNr guibg=NONE guifg=ORANGE
    highlight Pmenu guibg=#222f3d guifg=#ecf0f1
    highlight PmenuSel guibg=#000000 guifg=#f1c40f 
    highlight StatusLine guibg=#ecf0f1 guifg=#282828
    highlight StatusLineNC guibg=#2c3e50 guifg=#282828

    "lua require('lualine_style')
    lua require('git')
    let g:coq_settings = { 'auto_start': v:true }
    lua require('lsp_conf')

    lua require('nvim-tree').setup()
    lua require('todo-comments').setup()
    lua require('crates').setup()

    " call wilder#setup({
    "   \ 'modes': [':', '/', '?'],
    "   \ })
    " call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
    "   \ 'highlights': {
    "   \   'border': 'Normal',
    "   \ },
    "   \ 'border': 'rounded',
    "   \ 'left': [
    "   \   ' ', wilder#popupmenu_devicons(),
    "   \ ],
    "   \ })))
    lua require('nvim-treesitter.configs').setup({ highlight = { enable = true, }, })

    lua require('lsp-colors').setup()

    lua require('Comment').setup()

    "let g:loaded_nvimgdb = 1
    function! NvimGdbNoTKeymaps()
      tnoremap <silent> <buffer> <esc> <c-\><c-n>
    endfunction

    let g:nvimgdb_config_override = {
      \ 'key_next': 'n',
      \ 'key_step': 's',
      \ 'key_finish': 'f',
      \ 'key_continue': 'c',
      \ 'key_until': 'u',
      \ 'key_breakpoint': 'b',
      \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
      \ }
else
    colorscheme industry
endif

" indentline
let g:indentLine_char = '¦'
let g:vim_json_syntax_conceal = 0

let g:netrw_liststyle=1

filetype plugin indent on
set nocompatible

set showcmd " show commands at bottom

" nvim-tree
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_highlight_opened_files = 1
nnoremap <C-t> :NvimTreeToggle<CR>

" vim-move
let g:move_key_modifier = 'C'

" ------------
" MAPS
" -----------
let mapleader = ","

nnoremap j gj
nnoremap k gk

nnoremap tn :tabnew<CR>
nnoremap <leader>rt :RainbowToggle<CR>
nnoremap <leader>xx :TroubleToggle<cr>

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


nmap <leader>cr :!command cargo r<CR>
nmap <F6> :EditorConfigReload<CR>

if &diff
  "Get from remote
  nnoremap dr :diffget<Space>RE<CR>
  "Get from base
  nnoremap db :diffget<Space>BA<CR>
  "Get from local
  nnoremap dl :diffget<Space>LO<CR>
endif
