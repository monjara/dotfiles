return {
  'folke/tokyonight.nvim',
  config = function()
    require('tokyonight').setup {
      style = 'night',
      light_style = 'night',
      on_colors = function(colors)
        colors.bg = '#000000'
      end,
    }

    vim.cmd([[colorscheme tokyonight]])
  end,
}
