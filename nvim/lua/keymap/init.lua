vim.api.nvim_set_keymap('n', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>q', ':<C-u>q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<space>wq', ':<C-u>wq<CR>', { noremap = true })
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
vim.api.nvim_set_keymap('c', '<cr>', '', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-l>', '<cr>', { noremap = true })

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
