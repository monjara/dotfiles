return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      style = 'night',
      light_style = 'night',
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
        lightbulb = 'transparent',
      },
      ---@class ColorScheme
      on_colors = function(colors)
        colors.bg = '#000000'
      end,
    }
    vim.cmd([[colorscheme tokyonight]])
  end,
}
