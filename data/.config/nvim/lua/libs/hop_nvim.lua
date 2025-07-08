return {
  'smoka7/hop.nvim',
  version = '*',
  lazy = true,
  keys = {
    { 't', '<cmd>HopWord<cr>',    desc = 'hop', mode = { 'n', 'v' } },
    { 's', '<cmd>HopChar1MW<cr>', desc = 'hop', mode = { 'n', 'v' } },
  },
  config = function()
    require('hop').setup {
      keys = 'jfkdurghalsieownvmcxypq',
      case_insensitive = true,
    }
  end,
}
