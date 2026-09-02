return {
  'nvim-mini/mini.trailspace',
  version = false,
  config = function()
    local trailspace = require('mini.trailspace')
    trailspace.setup {
      only_in_normal_buffers = true,
    }

    vim.api.nvim_create_user_command('Trailspace', function()
      trailspace.trim()
    end, { range = true })
  end,
}
