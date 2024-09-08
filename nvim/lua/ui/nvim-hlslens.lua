return {
  'kevinhwang91/nvim-hlslens',
  depends = {
    'petertriho/nvim-scrollbar',
  },
  config = function()
    require('scrollbar.handlers.search').setup {}
  end,
}
