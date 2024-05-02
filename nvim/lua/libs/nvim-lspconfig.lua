return {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact' },
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
        settings = {
          -- tsserver_locale = 'ja',
        },
      }

      -- -- javascript
      -- require('tsserver').setup {
      --   ft = { 'javascript' },
      -- }

      -- swift
      lspconfig.sourcekit.setup {
        ft = { 'swift' },
        cmd = {
          '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp',
        },
        on_attach = function()
          vim.api.nvim_create_user_command('SwiftFormat', '!swift format ' .. vim.fn.expand('%') .. ' -i', {})
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

      -- default
      require('libs.nvim-lspconfig.init')
    end,
  },
}
