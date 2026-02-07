return {
  'smoka7/hop.nvim',
  version = "*",
  keys = {
    { 's', '<cmd>HopChar1<cr>', { desc = 'hop char 1', silent = true } },
  },
  config = function()
    require 'hop'.setup {
      keys = 'jfkdurghalsieownvmcxypq',
    }
  end
}
