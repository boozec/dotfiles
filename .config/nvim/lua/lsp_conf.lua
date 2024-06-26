local nvim_lsp = require('lspconfig')
-- local coq = require('coq')
--

local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.ruff,
        -- null_ls.builtins.diagnostics.flake8,
        -- Rust
        null_ls.builtins.formatting.rustfmt,
        -- C
        null_ls.builtins.formatting.clang_format,
        -- JS/TS
        null_ls.builtins.formatting.prettier,
    },
    on_attach = common_on_attach
})

-- Setup lspconfig. 
 
require "lsp_signature".setup()

--- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local common_on_attach = function(client, bufnr)
    -- Mappings.
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    vim.keymap.set('n', '<A-f>', '<cmd>lua vim.lsp.buf.format {async = true}<cr>', opts)
    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.format {async = true}"

    -- lsp_status.on_attach(client)
end


local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'clangd', 'gopls', 'ocamllsp' }
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      capabilities = capabilities,
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


-- nvim-cmp setup
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
