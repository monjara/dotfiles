return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.api.nvim_command('TSUpdate')
    end
  end,
  main = 'nvim-treesitter.configs',
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'javascript',
        'typescript',
        'lua',
        'rust',
        'vimdoc',
      },
      highlight = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    }
  end,
}
