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

      local deno_root = lspconfig.util.search_ancestors(vim.fn.getcwd(), function(path)
        if lspconfig.util.path.is_file(lspconfig.util.path.join(path, 'deno.lock')) then
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
            or lspconfig.util.find_git_ancestor(filename)
        end,
      }

      -- ruby
      lspconfig.solargraph.setup {
        ft = { 'ruby' },
      }

      lspconfig.glsl_analyzer.setup {
        ft = { 'glsl' },
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
            { 'n', '<space>D', vim.lsp.buf.type_definition },
            { 'n', '<space>rn', vim.lsp.buf.rename },
            { { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action },
            { 'n', 'gr', vim.lsp.buf.references },
            { 'n', '<space>ef', vim.diagnostic.open_float },
            { 'n', '[g', vim.diagnostic.goto_prev },
            { 'n', ']g', vim.diagnostic.goto_next },
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
                vim.cmd('silent !cargo fix --allow-dirty')
                vim.lsp.buf.format { async = false }
                vim.cmd('silent RustLsp reloadWorkspace')
              end,
            })
          else
            table.insert(maps, {
              'n',
              '<leader>fo',
              function()
                -- formatter.nvim
                vim.api.nvim_command('Format')
              end,
            })
          end

          utils.keymap_set(maps, { buffer = bufnr, noremap = true, silent = true })
        end,
      })
    end,
  },
}
