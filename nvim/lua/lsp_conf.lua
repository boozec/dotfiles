local nvim_lsp = require('lspconfig')
local coq = require('coq')
local null_ls = require("null-ls")
local trouble = require("trouble")

-- Redefine sign.
local signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }

for type, icon in pairs(signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
end

null_ls.config({
    debug = false,
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.flake8,
        -- Rust
        null_ls.builtins.formatting.rustfmt,
        -- C
        null_ls.builtins.formatting.clang_format,
        -- JS/TS
        null_ls.builtins.formatting.prettier,
    }
})

-- Setup lspconfig. 
 
--- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = coq.lsp_ensure_capabilities(),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp["null-ls"].setup({
    on_attach =  function(client, bufnr)
        -- Format on save.
        if client.resolved_capabilities.document_formatting then
            buf_set_keymap('n', '<leader>fs', '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', opts)
            vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()'
        end
    end
})

trouble.setup({
    use_lsp_diagnostic_signs = true,
    auto_close = true,
    auto_open = true
})
