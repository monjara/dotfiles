return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'CursorHold', 'CursorHoldI' },
  dependencies = {
    'windwp/nvim-ts-autotag'
  },
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.api.nvim_command('TSUpdate')
    end
  end,
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = {
        'javascript',
        'typescript',
        'lua',
        'rust'
      },
      highlight = {
        enable = true
      },
      autotag = {
        enable = true
      }
    }
  end
}
