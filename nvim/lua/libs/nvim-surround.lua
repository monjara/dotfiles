return {
  'kylechui/nvim-surround',
  lazy = true,
  version = '*',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {}
  end,
}
