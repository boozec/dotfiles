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
    },
    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.keymap.set('n', '<A-f>', '<cmd>lua vim.lsp.buf.formatting_sync(nil, 2000)<cr>', opts)
            vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 2000)"
        end
    end
})

-- Setup lspconfig. 
 
require "lsp_signature".setup()

--- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local common_on_attach = function(client, bufnr)
    -- Mappings.
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

    -- lsp_status.on_attach(client)
end


local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = coq.lsp_ensure_capabilities(),
    on_attach = common_on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

trouble.setup({
    use_diagnostic_signs = true,
    auto_close = true,
    auto_open = false
})

