require('config.lazy')
require('keymap')

vim.lsp.enable {
  'lua_ls',
  'jsonls',
  'taplo',
  'biome',
  'cssls',
  'css_variables',
  'tailwindcss',
  'pyright',
  'nixd',
}
