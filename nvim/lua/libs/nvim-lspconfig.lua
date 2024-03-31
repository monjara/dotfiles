return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    local lspconfig = require('lspconfig')

    local root_pattern = function(filename, pattern)
      return lspconfig.util.root_pattern(pattern)(filename)
    end

    -- lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          format = {
            enable = false,
          },
        },
      },
    }

    -- rust
    local rt = require('rust-tools')
    rt.setup {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
          vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        settings = {
          ['rust_analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },
    }

    -- swift
    lspconfig.sourcekit.setup {
      ft = { 'swift' },
      cmd = {
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
      },
      on_attach = function()
        vim.api.nvim_create_user_command('SwiftFormat', '!swift format ' .. vim.api.nvim_buf_get_name(0) .. ' -i', {})
      end,
      root_dir = function(filename, _)
        return root_pattern(filename, 'Package.swift')
          or root_pattern(filename, 'buildServer.json')
          or root_pattern(filename, '*.xcodeproj')
          or root_pattern(filename, '*.xcworkspace')
          or lspconfig.util.find_git_ancestor(filename)
      end,
    }

    -- ruby
    lspconfig.solargraph.setup {
      ft = { 'ruby' },
    }

    require('libs.nvim-lspconfig.init')
  end,
}
