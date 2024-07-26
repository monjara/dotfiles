return {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opt = {},
  },
  {
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
      require('neodev').setup {}
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

      -- typescript, typescriptreact, javascriptreact
      require('typescript-tools').setup {
        ft = {
          'typescript',
          'typescriptreact',
          'javascript',
          'javascriptreact',
        },
        settings = {
          tsserver_locale = 'ja',
        },
      }

      -- swift
      lspconfig.sourcekit.setup {
        ft = { 'swift' },
        cmd = {
          '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
        },
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

      -- default
      require('libs.nvim-lspconfig.init')
    end,
  },
}
