require('core')

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
--   callback = function()
--     vim.opt_local.sw = 2
--     vim.opt_local.sts = 2
--     vim.opt_local.ts = 2
--     vim.opt_local.et = true
--   end
-- })

local utils = require('utils')
vim.g.python3_host_prog = utils.join_paths(utils.get_home(), '.anyenv/envs/pyenv/shims/python')

require('plugins')
require('lsp')
require('custom')

vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('n', [[\]], ',', {})
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':<C-u>nohl<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>only<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZZ', '', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZQ', '', { noremap = true })

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<M-i>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<space>yf',
  function()
    vim.api.nvim_command('let @" = expand("%:p")')
    vim.api.nvim_command('let @+ = expand("%:p")')
  end
)

vim.keymap.set(
  'n',
  '<space>yd',
  function()
    vim.api.nvim_command('let @" = expand("%:p:h")')
    vim.api.nvim_command('let @+ = expand("%:p:h")')
  end
)

vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h'
})

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'lua',
    'rust'
  },
  highlight = {
    enable = true
  },
  autotag = {
    enable = true
  }
}
