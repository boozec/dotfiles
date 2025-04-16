-- Auto-reload Neovim configuration on save
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerCompile
  augroup end
]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- use 'cespare/vim-toml'            -- TOML syntax highlighting
    use 'rust-lang/rust.vim'          -- Rust language support
    use 'nvim-lua/plenary.nvim'       -- Lua utilities for plugins
    use 'lewis6991/gitsigns.nvim'     -- Git integration (show signs in gutter)
    use 'kyazdani42/nvim-web-devicons'-- File icons
    use 'mg979/vim-visual-multi'      -- Multi-cursor support
    use 'tpope/vim-fugitive'          -- Git wrapper for commands like :Git
    use 'ap/vim-css-color'            -- Show color preview for CSS colors
    -- use 'lukas-reineke/indent-blankline.nvim'         -- Display vertical indentation lines
    use 'google/vim-searchindex'      -- Show search match count
    use 'numToStr/Comment.nvim'       -- Easily comment/uncomment lines
    -- use 'togglebyte/togglerust'       -- Rust debugging tools
    -- use 'chriskempson/base16-vim'     -- Base16 color schemes
    use 'NLKNguyen/papercolor-theme'  -- PaperColor theme
    use 'projekt0n/github-nvim-theme'
    use 'nvim-telescope/telescope.nvim' -- Fuzzy finder
    use 'neovim/nvim-lspconfig'       -- LSP configuration for multiple languages
    use 'hrsh7th/nvim-cmp'            -- Autocompletion engine
    use 'hrsh7th/cmp-nvim-lsp'        -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'    -- Snippet completion for nvim-cmp
    use 'L3MON4D3/LuaSnip'            -- Snippet engine
    use 'kyazdani42/nvim-tree.lua'    -- File explorer
    use 'ray-x/lsp_signature.nvim'    -- Show function signatures as you type
    use 'folke/todo-comments.nvim'    -- Highlight and search TODO comments
    use 'saecki/crates.nvim'          -- Rust crate version management
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'             -- Update treesitter parsers
    }
    use 'folke/trouble.nvim'          -- Diagnostics and references list
    use 'folke/lsp-colors.nvim'       -- Adds missing LSP diagnostics highlight groups
    use 'sindrets/diffview.nvim'      -- Git diff and history viewer

    use 'mfussenegger/nvim-dap'       -- Debug Adapter Protocol client implementation
    use 'leoluz/nvim-dap-go'          -- Neovim DAP extension for Go
    use 'nvim-neotest/nvim-nio'
    use 'rcarriga/nvim-dap-ui'

    use 'koraa/proverif.vim'

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Automatically set up the configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- General Neovim settings

-- Configure completion options (menu, menuone, noselect)
vim.opt.completeopt = "menu,menuone,noselect"

-- Enable system clipboard access
vim.opt.clipboard = "unnamedplus"

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Enable command-line completion features
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "list", "full" }

-- Ignore certain file types when using wildmenu for file navigation
vim.opt.wildignore = "*.png,*.jpg,*.gif,*.swp,*.o,*.pyc,vendor"

-- Show absolute line numbers
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Set text width to 80 characters
vim.opt.textwidth = 80

-- Highlight a column at 80 characters
vim.opt.colorcolumn = "80"

-- Disable line wrapping
vim.opt.wrap = false

-- Set tab width and shift width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Automatically indent new lines to match the previous line
vim.opt.autoindent = true

-- Automatically reload files if they are modified outside of Neovim
vim.opt.autoread = true

-- Set UTF-8 as the default encoding
vim.opt.encoding = "UTF-8"

-- Set the history size for command line and search
vim.opt.history = 1000

-- Highlight search matches
vim.opt.hlsearch = true

-- Incrementally search while typing
vim.opt.incsearch = true

-- Disable backup file creation
vim.opt.backup = false

-- Set the status line to always be visible
vim.opt.laststatus = 2

-- Show invisible characters (e.g., tabs, spaces, etc.)
vim.opt.list = true

-- Define characters for different invisible characters
vim.opt.listchars = { eol = '⏎', tab = '» ', trail = 'ˑ', nbsp = '⎵' }
vim.cmd([[match Error /.*\t$/]])
vim.cmd([[match Error /.*\s$/]])
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "c", "cpp" },
  callback = function()
    vim.opt.autoindent = true
    vim.opt.expandtab = false
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})


-- Use indent-based folding
vim.opt.foldmethod = "indent"

-- Open vertical splits to the right of the current window
vim.opt.splitright = true

-- Open horizontal splits below the current window
vim.opt.splitbelow = true

-- Optimize screen redrawing for performance
vim.opt.lazyredraw = true

-- Disable swapfile creation
vim.opt.swapfile = false

-- Enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true

-- Set background to dark mode
vim.opt.background = "dark"

-- Highlight the current line
vim.opt.cursorline = true

-- **Highlight settings**
-- Set custom highlights for various UI components
vim.cmd('colorscheme github_dark_default')
vim.cmd [[
    highlight Normal guibg=NONE
    highlight NormalNC guibg=#111111
    highlight NonText guibg=NONE
    highlight LineNr guibg=NONE
    highlight CursorLine guibg=NONE
    highlight CursorLineNr guibg=NONE guifg=Yellow
    highlight StatusLineNC guibg=#0d1117 guifg=#cacaca
    highlight Error guibg=red guifg=#000000
    "highlight StatusLine guibg=#000000 guifg=Yellow
    "highlight StatusLineNC guibg=#000000 guifg=Yellow
    highlight SignColumn guibg=NONE
    highlight GitGutterChange guibg=#000000
    highlight GitGutterAdd guibg=#000000
    highlight GitGutterDelete guibg=#000000
]]

-- Keybindings
vim.g.mapleader = ","  -- Set the leader key to ","
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })  -- Move down visually wrapped lines
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })  -- Move up visually wrapped lines

---- Buffers
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true }) -- Move to the next buffer
vim.api.nvim_set_keymap('n', '[b', ':bprev<CR>', { noremap = true, silent = true }) -- Move to the previous buffer
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true }) -- List and switch to buffers using Telescope

---- Tabs
vim.api.nvim_set_keymap('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']t', ':tabn<CR>', { noremap = true, silent = true }) -- Move to the next tab
vim.api.nvim_set_keymap('n', '[t', ':tabp<CR>', { noremap = true, silent = true }) -- Move to the previous tab

vim.api.nvim_set_keymap('n', '<leader>o', ':only<CR>', { noremap = true })  -- Close all other windows
vim.api.nvim_set_keymap('n', '<A-t>', ':NvimTreeToggle<CR>', { noremap = true })  -- Toggle NvimTree file explorer
vim.api.nvim_set_keymap('n', '<leader>pa', ':set paste<CR>', { noremap = true })  -- Enable paste mode
vim.api.nvim_set_keymap('n', '<leader>npa', ':set nopaste<CR>', { noremap = true })  -- Disable paste mode
vim.api.nvim_set_keymap('n', '<leader>cr', ':Cargo run<CR>', { noremap = true })  -- Run `cargo run` for Rust projects
vim.api.nvim_set_keymap('n', '<space>d', '<cmd>Trouble diagnostics<cr>', { noremap = true })  -- Toggle Trouble diagnostic window
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })  -- Find files with Telescope
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true })  -- Live grep with Telescope
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true })  -- Search help tags with Telescope
vim.api.nvim_set_keymap('n', '<C-i>', ':lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>', { noremap = true })

-- Custom command aliases for Diffview
vim.api.nvim_create_user_command('Do', 'DiffviewOpen', {})
vim.api.nvim_create_user_command('Dc', 'DiffviewClose', {})
vim.api.nvim_create_user_command('Dh', 'DiffviewFileHistory', {})


-- Plugin configuration
require('nvim-tree').setup { actions = { open_file = { quit_on_open = true } } }
require('todo-comments').setup {}
require('crates').setup {}
require('nvim-treesitter.configs').setup { highlight = { enable = true } }
require('lsp-colors').setup {}
require('Comment').setup()
-- require("ibl").setup { indent = {char = "¦"} }
-- vim.cmd.highlight('clear @ibl.scope.underline.1')

-- General settings from ~/.config/nvim/lua/
require('git')  -- Load git-related settings
require('lsp_conf')  -- Load LSP configuration
require('dap_conf')
require('evil_lualine')

-- Set up language client for Go
vim.g.LanguageClient_serverCommands = { go = { 'gopls' } }
