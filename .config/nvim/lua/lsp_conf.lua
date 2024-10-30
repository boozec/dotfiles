local nvim_lsp = require('lspconfig')
local trouble = require("trouble")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Redefine LSP diagnostic signs
local signs = { Error = 'E', Warning = 'W', Hint = 'H', Information = 'I' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local opts = { noremap=true, silent=true }

-- Setup lsp_signature for function signature help
require "lsp_signature".setup()

-- Common on_attach function to handle keymaps and settings for all LSPs
local common_on_attach = function(client, bufnr)
    -- Key mappings
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- Use vim.diagnostic.open_float for showing line diagnostics (replacing deprecated call)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.keymap.set('n', '<A-f>', '<cmd>lua vim.lsp.buf.format {async = true}<cr>', opts)
    
    -- Autoformat on save
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format {async = true}")
end

-- LSP servers setup
local servers = {
    'clangd',
    'gopls',
    'jdtls',
    'metals',
    'ocamllsp',
    'ruff_lsp',
    'rust_analyzer',
}

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

nvim_lsp.ts_ls.setup {
  capabilities = capabilities,
  on_attach = common_on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

vim.lsp.inlay_hint.enable(true, { 0 })

-- Trouble setup
trouble.setup({
    use_diagnostic_signs = true,
    auto_close = true,
    auto_open = false
})

-- nvim-cmp setup for autocompletion
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
