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
        settings = {
          tsserver_locale = 'ja',
        },
      }

      lspconfig.biome.setup {}

      lspconfig.prismals.setup {}

      lspconfig.gopls.setup {
        settings = {
          gopls = {
            staticcheck = true,
          },
        },
      }

      local deno_root = lspconfig.util.search_ancestors(vim.fn.getcwd(), function(path)
        if (vim.loop.fs_stat(table.concat { path, 'deno.lock' }) or {}).type == 'file' then
          return path
        end
      end)

      -- denols
      if deno_root ~= nil then
        lspconfig.denols.setup {}
      end

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
            or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
        end,
      }

      -- ruby
      lspconfig.solargraph.setup {
        ft = { 'ruby' },
      }

      lspconfig.glsl_analyzer.setup {
        ft = { 'glsl' },
      }

      lspconfig.taplo.setup {
        ft = { 'toml' },
      }

      -- default
      -- require('libs.nvim-lspconfig.init')

      vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
        pattern = { '*.tf', '*.tfvars' },
        callback = function()
          vim.lsp.buf.format()
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { '*.swiftinterface' },
        callback = function()
          vim.api.nvim_command('set filetype=swift')
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { '*.swift-format' },
        callback = function()
          vim.api.nvim_command('set filetype=json')
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = { '*.ejs' },
        callback = function()
          vim.api.nvim_command('set filetype=html')
        end,
      })

      vim.api.nvim_create_autocmd({ 'LspAttach' }, {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(e)
          local bufnr = e.buf
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local maps = {
            { 'n', 'gD', vim.lsp.buf.declaration },
            { 'n', 'gd', vim.lsp.buf.definition },
            { 'n', 'K', vim.lsp.buf.hover },
            { 'n', 'gi', vim.lsp.buf.implementation },
            { 'n', '<C-k>', vim.lsp.buf.signature_help },
            { 'n', '<space>wa', vim.lsp.buf.add_workspace_folder },
            { 'n', '<space>wr', vim.lsp.buf.remove_workspace_folder },
            {
              'n',
              '<space>wl',
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end,
            },
            { 'n', 'gt', vim.lsp.buf.type_definition },
            { 'n', '<space>rn', vim.lsp.buf.rename },
            { 'n', 'gr', vim.lsp.buf.references },
            { 'n', '<space>ef', vim.diagnostic.open_float },
            { 'n', 'g[', vim.diagnostic.goto_prev },
            { 'n', 'g]', vim.diagnostic.goto_next },
            { 'n', '<space>el', vim.diagnostic.setloclist },
          }

          local utils = require('utils')
          -- if utils.is_filetye(bufnr, 'swift') then
          --   table.insert(maps, {
          --     'n',
          --     '<leader>fo',
          --     function()
          --       vim.api.nvim_command('SwiftFormat')
          --     end,
          --   })
          -- elseif utils.is_filetye(bufnr, 'rust') then
          if utils.is_filetye(bufnr, 'rust') then
            table.insert(maps, {
              'n',
              '<leader>fo',
              function()
                vim.lsp.buf.format { async = true }
              end,
            })
            table.insert(maps, {
              { 'n', 'v' },
              '<space>ca',
              function()
                vim.cmd.RustLsp('codeAction')
              end,
            })
          elseif utils.is_filetye(bufnr, 'typescript', 'typescriptreact', 'javascript', 'javascriptreact') then
            table.insert(maps, {
              'n',
              '<leader>fo',
              function()
                vim.api.nvim_command('TSToolsSortImports')
                vim.lsp.buf.format { async = true }
              end,
            })
            table.insert(maps, { { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action })
          else
            -- default setting
            table.insert(maps, {
              'n',
              '<leader>fo',
              function()
                -- formatter.nvim
                vim.api.nvim_command('Format')
              end,
            })

            table.insert(maps, { { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action })
          end

          utils.keymap_set(maps, { buffer = bufnr, noremap = true, silent = true })
        end,
      })
    end,
  },
}
