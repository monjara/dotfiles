require('config.lazy')
require('keymap')

vim.lsp.enable {
  'astro',
  'eslint',
  'html',
  'biome',
  'css_variables',
  'cssls',
  'fish_lsp',
  'jsonls',
  'lua_ls',
  'marksman',
  'nixd',
  'postgres_lsp',
  'pyright',
  'tailwindcss',
  'taplo',
  'tombi',
}

vim.cmd([[colorscheme tokyonight]])
