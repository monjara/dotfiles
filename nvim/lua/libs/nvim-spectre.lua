return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  keys = {
    {
      '<space>fs',
      '<cmd>lua require("spectre").toggle()<cr>',
      desc = 'toggle spectre',
      mode = 'n',
    },
    {
      '<space>fw',
      '<cmd>lua require("spectre").open_visual({select_word = true})<cr>',
      desc = 'toggle spectre',
      mode = 'n',
    },
    {
      '<space>fw',
      '<cmd>lua require("spectre").open_visual()<cr>',
      desc = 'toggle spectre',
      mode = 'v',
    },
  },
  config = function()
    require('spectre').setup {
      is_insert_mode = true,
    }
  end,
}
