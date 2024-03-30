return {
  'smoka7/hop.nvim',
  lazy = true,
  keys = {
    { 's', '<cmd>HopChar1MW<cr>', desc = 'hop', mode = { 'n', 'v' } },
  },
  config = function()
    require('hop').setup { keys = 'jfkdurghalsieownvmcxypq' }
  end,
}
