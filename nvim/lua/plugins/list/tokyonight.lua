return {
  'folke/tokyonight.nvim',
  config = function()
    require('tokyonight').setup {
      style = 'night',
      light_style = 'night'
    }
    vim.cmd [[colorscheme tokyonight]]
  end
}
