require('config.lazy')
require('keymap')

vim.lsp.enable {
  "eslint",
  "html",
  'biome',
  'css_variables',
  'cssls',
  'fish_lsp',
  'jsonls',
  'lua_ls',
  'nixd',
  'pyright',
  'tailwindcss',
  'taplo',
  'tombi',
}


vim.cmd [[colorscheme tokyonight]]
