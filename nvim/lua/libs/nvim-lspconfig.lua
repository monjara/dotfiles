return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    local utils = require 'utils'
    local lspconfig = require 'lspconfig'

    local root_pattern = function(filename, pattern)
      return lspconfig.util.root_pattern(pattern)(filename)
    end

    -- lua
    lspconfig.lua_ls.setup {
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

    -- swift
    lspconfig.sourcekit.setup {
      ft = { 'swift' },
      cmd = {
        '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp'
      },
      on_attach = function()
        vim.api.nvim_create_user_command(
          'SwiftFormat',
          '!swift format ' .. vim.api.nvim_buf_get_name(0) .. ' -i',
          {}
        )
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
      ft = { 'ruby' }
    }

    -- lspconfig
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(e)
        vim.bo[e.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local maps = {
          { 'n',          'gD',        vim.lsp.buf.declaration },
          { 'n',          'gd',        vim.lsp.buf.definition },
          { 'n',          'K',         vim.lsp.buf.hover },
          { 'n',          'gi',        vim.lsp.buf.implementation },
          { 'n',          '<C-k>',     vim.lsp.buf.signature_help },
          { 'n',          '<space>wa', vim.lsp.buf.add_workspace_folder },
          { 'n',          '<space>wr', vim.lsp.buf.remove_workspace_folder },
          { 'n',          '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
          { 'n',          '<space>D',  vim.lsp.buf.type_definition },
          { 'n',          '<Space>rn', vim.lsp.buf.rename },
          { { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action },
          { 'n',          'gr',        vim.lsp.buf.references },
        }

        if vim.bo[e.buf].filetype == 'swift' then
          table.insert(maps, { 'n', '<leader>fo', function() vim.api.nvim_command('SwiftFormat') end })
        else
          table.insert(maps, { 'n', '<leader>fo', function() vim.lsp.buf.format { async = true } end })
        end

        local o = { buffer = e.buf, noremap = true, silent = true }
        utils.keymap_set(maps, o)
      end
    })

    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
      pattern = { '*.tf', '*.tfvars' },
      callback = function()
        vim.lsp.buf.format()
      end
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { '*.swiftinterface' },
      callback = function()
        vim.api.nvim_command('set filetype=swift')
      end
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { '*.swift-format' },
      callback = function()
        vim.api.nvim_command('set filetype=json')
      end
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { '*.ejs' },
      callback = function()
        vim.api.nvim_command('set filetype=html')
      end
    })
  end
}
