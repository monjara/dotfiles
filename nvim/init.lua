require('config.lazy')
require('keymap')

vim.lsp.enable {
  'astro',
  'biome',
  'css_variables',
  'cssls',
  'eslint',
  'fish_lsp',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'nixd',
  'postgres_lsp',
  'pyright',
  'tailwindcss',
  'taplo',
  'tombi',
  'ty',
}

vim.cmd([[colorscheme tokyonight]])

-- Undotree
vim.cmd([[packadd nvim.undotree]])
vim.keymap.set("n", "<leader>u", require("undotree").open)

-- Difftool
vim.cmd([[packadd nvim.difftool]])
