return {
  'folke/zen-mode.nvim',
  lazy = true,
  keys = {
    { '<space>z', '<cmd>ZenMode<cr>' },
  },
  config = function()
    require('zen-mode').setup {}
  end,
}
