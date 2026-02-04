return {
    'smoka7/hop.nvim',
    version = "*",
    keys = {
      {'s', '<cmd>HopChar1<cr>', { desc = 'hop char 1' }},
    },
    config = function ()
      require 'hop'.setup {
      keys = 'fdetovxqpygblzhckisuran'
    }
    end
}
