local nvim_lsp = require('lspconfig')
local coq = require('coq')
local null_ls = require("null-ls")
local trouble = require("trouble")

-- Redefine sign.
local signs = { Error = 'E', Warning = 'W', Hint = 'H', Information = 'I' }

for type, icon in pairs(signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

--local function vim.keymap.set(...) vim.api.nvim_vim.keymap.set(bufnr, ...) end
local opts = { noremap=true, silent=true }

null_ls.setup({
    debug = false,
    save_after_format = false,
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
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false

      require "lsp_signature".on_attach()

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.keymap.set('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    end,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim_lsp["null-ls"].setup({
--     on_attach = function(client)
--         if client.resolved_capabilities.document_formatting then
--             vim.keymap.set('n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting_sync()<cr>', opts)
--             vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
--         end
--     end
-- })
--
--
trouble.setup({
    use_diagnostic_signs = true,
    auto_close = true,
    auto_open = false
})

