return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<space>ff', '<cmd>Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git <cr>', desc = 'Telescope' },
    { '<space>fr', '<cmd>Telescope live_grep find_command=rg,--files,--hidden,--glob,!*.git <cr>',  desc = 'Telescope' },
    { '<space>fb', '<cmd>Telescope buffers find_command=rg,--files,--hidden,--glob,!*.git <cr>',    desc = 'Telescope' },
    { '<space>fh', '<cmd>Telescope help_tags<cr>',                                                  desc = 'Telescope' }
  },
  config = function()
    require 'telescope'.setup({
      defaults = {
        path_display = {
          shorten = 3
        },
        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-l>'] = require('telescope.actions').select_default,
            ['<CR>'] = function()
            end
          }
        }
      }
    })
  end
}
