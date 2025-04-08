return {
  'echasnovski/mini.trailspace',
  event = 'VeryLazy',
  config = function()
    local trailspace = require('mini.trailspace')

    trailspace.setup {}
    vim.api.nvim_create_user_command('Trailspace', function()
      trailspace.trim()
    end, { nargs = 0 })
  end,
  keys = {
    {
      '<leader>tw',
      function()
        require('mini.trailspace').trim()
      end,
      desc = 'mini trim whitespace',
      mode = { 'n' },
    },
  },
}
