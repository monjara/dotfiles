return {
  'phaazon/hop.nvim',
  lazy = true,
  branch = 'v2',
  keys = {
    { 's', '<cmd>HopChar1MW<cr>', desc = 'hop' }
  },
  config = function()
    require 'hop'.setup { keys = 'jfkdurghalsieownvmcxypq' }
  end
}
