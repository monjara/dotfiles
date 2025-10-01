return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  config = function()
    require('gitsigns').setup()
    require('scrollbar.handlers.gitsigns').setup()
  end,
  keys = {
    { '<space>gd', '<cmd>Gitsigns diffthis<cr>', desc = 'gitsigns' },
    { '<space>gb', '<cmd>Gitsigns blame_line<cr>', desc = 'gitsigns' },
    { '<space>gtb', '<cmd>Gitsigns toggle_current_line_blame<cr>', desc = 'gitsigns' },
  },
}
