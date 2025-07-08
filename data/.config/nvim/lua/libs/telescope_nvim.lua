return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        layout_config = {
          width = {
            padding = 0
          }
        },
        path_display = { 'smart' },
        mappings = {
          n = {
            ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-j>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-l>'] = require('telescope.actions').preview_scrolling_right,
            ['<C-h>'] = require('telescope.actions').preview_scrolling_left,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-f>'] = false,
            ['<M-f>'] = false,
            ['<M-k>'] = false,
          },
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-l>'] = require('telescope.actions').select_default,
            ['<CR>'] = false,
          },
        },
      },
    }

    require('utils').keymap_set({
      {
        'n',
        '<space>ff',
        '<cmd>Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git <cr>',
      },
      {
        'n',
        '<space>fr',
        '<cmd>Telescope live_grep find_command=rg,--files,--hidden,--glob,!*.git <cr>',
      },
      {
        'n',
        '<space>fb',
        '<cmd>Telescope buffers find_command=rg,--files,--hidden,--glob,!*.git <cr>',
      },
      {
        'n',
        '<space>fh',
        '<cmd>Telescope help_tags<cr>',
      },
      {
        'n',
        '<space>fm',
        '<cmd>Telescope marks<cr>',
      },
    }, { silent = true, noremap = true })
  end,
}
