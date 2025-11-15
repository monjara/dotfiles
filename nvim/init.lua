require('setup_rocks').init()
require('opt').init()
require('keymap').init()

vim.lsp.enable {
  'lua_ls',
  'jsonls',
  'taplo',
  'ts_ls',
  'biome',
  'cssls',
  'css_variables',
  'tailwindcss',
  'pyright',
}
