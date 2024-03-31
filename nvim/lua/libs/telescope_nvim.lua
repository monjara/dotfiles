return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        path_display = {
          shorten = 3,
        },
        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-l>'] = require('telescope.actions').select_default,
            ['<CR>'] = function() end,
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
    }, { silent = true, noremap = true })
  end,
}
