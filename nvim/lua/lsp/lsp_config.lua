local utils = require('utils')

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
    'lua_ls',
  }
})

local nvim_lsp = require 'lspconfig'

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local maps = {
    { 'n', 'gD',         vim.lsp.buf.declaration },
    { 'n', 'gd',         vim.lsp.buf.definition },
    { 'n', 'K',          vim.lsp.buf.hover },
    { 'n', 'gi',         vim.lsp.buf.implementation },
    { 'n', '<C-k>',      vim.lsp.buf.signature_help },
    { 'n', '<space>wa',  vim.lsp.buf.add_workspace_folder },
    { 'n', '<space>wr',  vim.lsp.buf.remove_workspace_folder },
    { 'n', '<space>wl',  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
    { 'n', '<space>D',   vim.lsp.buf.type_definition },
    { 'n', '<Space>rn',  vim.lsp.buf.rename },
    { 'n', '<space>ca',  vim.lsp.buf.code_action },
    { 'n', 'gr',         vim.lsp.buf.references },
    { 'n', '<leader>fo', vim.lsp.buf.format }
  }
  utils.keymap_set(maps, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

-- lua
nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      format = {
        enable = true,
        defaultConfig = {
          insert_final_newline = false,
          indent_size = 2,
          indent_style = 'space',
        }
      }
    }
  }
}

-- rust
local rt = require('rust-tools')
rt.setup {
  server = {
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ['rust_analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
      }
    }
  }
}

-- ts
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags
}


-- terraform
nvim_lsp.terraformls.setup {
  on_attach = on_attach,
  flags = lsp_flags
}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end
})

nvim_lsp.docker_compose_language_service.setup {
  on_attach = on_attach,
  flags = lsp_flags
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  flags = lsp_flags
}

if vim.fn.has('mac') == 1 then
  -- swift
  nvim_lsp.sourcekit.setup {
    on_attach = on_attach,
    flags = lsp_flags
  }
end

-- lspconfig
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)