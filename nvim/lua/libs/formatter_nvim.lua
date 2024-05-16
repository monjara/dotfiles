return {
  'mhartington/formatter.nvim',
  config = function()
    require('formatter').setup {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        lua = require('libs.formatter.lua'),
        swift = require('libs.formatter.swift'),
        ['*'] = {
          function()
            vim.lsp.buf.format { async = false }
            return {}
          end,
        },
      },
    }
  end,
}
