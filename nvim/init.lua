require('config.lazy')
require('keymap')

vim.lsp.enable {
  'astro',
  'biome',
  'css_variables',
  'eslint',
  'fish_lsp',
  'html',
  'jsonls',
  'lua_ls',
  'markdown_oxide',
  'marksman',
  'nixd',
  'postgres_lsp',
  'pyright',
  'tailwindcss',
  'taplo',
  'tombi',
  'ty',
  'vscode-css-languageserver',
  'vtsls',
  'clojure_lsp'
}

-- colorscheme catppuccin-nvim " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.cmd([[colorscheme catppuccin-mocha]])

-- Undotree
vim.cmd([[packadd nvim.undotree]])
vim.keymap.set('n', '<leader>u', require('undotree').open)

-- Difftool
vim.cmd([[packadd nvim.difftool]])

-- require('vim._core.ui2').enable {}
