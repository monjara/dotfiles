local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(e)
      vim.bo[e.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
        { 'n', '<Space>rn', vim.lsp.buf.rename },
        { { 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action },
        { 'n', 'gr', vim.lsp.buf.references },
        { 'n', '<space>ef', vim.diagnostic.open_float },
        { 'n', '[g', vim.diagnostic.goto_prev },
        { 'n', ']g', vim.diagnostic.goto_next },
        { 'n', '<space>el', vim.diagnostic.setloclist },
      }

      local utils = require('utils')
      if utils.is_filetye(e.buf, 'swift') then
        table.insert(maps, {
          'n',
          '<leader>fo',
          function()
            vim.api.nvim_command('SwiftFormat')
          end,
        })
      elseif utils.is_filetye(e.buf, 'lua') then
        table.insert(maps, {
          'n',
          '<leader>fo',
          function()
            -- formatter.nvim
            vim.api.nvim_command('Format')
          end,
        })
      else
        table.insert(maps, {
          'n',
          '<leader>fo',
          function()
            vim.lsp.buf.format { async = true }
          end,
        })
      end

      local o = { buffer = e.buf, noremap = true, silent = true }
      utils.keymap_set(maps, o)
    end,
  })
end

return M
