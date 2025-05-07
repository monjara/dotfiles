return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
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
