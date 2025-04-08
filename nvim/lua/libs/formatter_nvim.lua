return {
  'mhartington/formatter.nvim',
  config = function()
    require('formatter').setup {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        lua = require('formatter.lua'),
        swift = require('formatter.swift'),
        ['*'] = {
          function()
            vim.lsp.buf.format { async = true }
            return {}
          end,
        },
      },
    }
  end,
}
