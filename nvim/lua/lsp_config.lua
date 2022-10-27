-- lsp-installer
require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
})
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    'rust_analyzer',
    'sumneko_lua',
    'tsserver'
  }
})

-- lspconfig
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
end

-- nvim-cmp
-- vim.cmd [[set completeopt=menu,menuone,noselect]]
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- Setup nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local nvim_lsp = require('lspconfig')
local is_deno = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc')
local is_node = nvim_lsp.util.root_pattern('package.json')

nvim_lsp['pylsp'].setup({
  filetypes = { 'python' },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {}
})
nvim_lsp['tsserver'].setup({
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  root_dir = is_node
})
nvim_lsp['denols'].setup({
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  on_attach = on_attach,
  root_dir = is_deno
})
nvim_lsp['rust_analyzer'].setup({
  filetypes = { 'rust' },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {}
  }
})
nvim_lsp['sumneko_lua'].setup({
  filetypes = { 'lua' },
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      }
    }
  }
})
nvim_lsp['terraformls'].setup({})
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = { "*.tf", "*.tfvars" },
--   callback = vim.lsp.buf.formatting_sync
-- })
nvim_lsp['jsonls'].setup({
  filetypes = { 'json', 'jsonc' },
})
nvim_lsp['taplo'].setup({})
