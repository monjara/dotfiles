local opt = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'v' }, '<space>', '', opt)
vim.keymap.set('n', '<space>w', '<cmd>silent w!<cr>', opt)
vim.keymap.set('n', '<space>q', '<cmd>q!<cr>', opt)
vim.keymap.set('n', '<space>wq', '<cmd>wq<cr>', opt)
vim.keymap.set('n', [[\]], ',', opt)
vim.keymap.set('n', 'j', 'gj', opt)
vim.keymap.set('n', 'k', 'gk', opt)
vim.keymap.set('n', 'gj', 'j', opt)
vim.keymap.set('n', 'gk', 'k', opt)
vim.keymap.set('n', 'ZZ', '', opt)
vim.keymap.set('n', 'ZQ', '', opt)
vim.keymap.set('n', '<space>tt', '<cmd>terminal<CR>', opt)
vim.keymap.set('n', '<space>si', [[<cmd>%s/"/'/g<CR>]], opt)
vim.keymap.set('i', 'jj', '<esc>', opt)
vim.keymap.set({ 'i', 'c' }, '<C-l>', '<esc>', opt)
vim.keymap.set('t', '<M-i>', [[<C-\><C-n>]], opt)
vim.keymap.set('n', '<space>j', '<cmd>bnext<cr>', opt)
vim.keymap.set('n', '<space>k', '<cmd>bprevious<cr>', opt)
vim.keymap.set(
  -- yank and copy current file's absolute path to clipboard
  'n',
  '<Leader>fp',
  function()
    vim.api.nvim_command('let @" = expand("%:.")')
    vim.api.nvim_command('let @+ = expand("%:.")')
  end,
  opt
)
vim.keymap.set(
  -- yank and copy directiory that current file existing to clipboard
  'n',
  '<Leader>fd',
  function()
    vim.api.nvim_command('let @" = expand("%:p:h")')
    vim.api.nvim_command('let @+ = expand("%:p:h")')
  end,
  opt
)
vim.keymap.set(
  -- echo current file name
  'n',
  '<Leader>fe',
  function()
    vim.api.nvim_command('echo expand("%:p")')
  end,
  opt
)
vim.keymap.set(
  -- toggle line number (call :set number!)
  'n',
  '<Leader>nn',
  function()
    vim.api.nvim_command('set number!')
  end,
  opt
)
vim.keymap.set(
  -- TODO: toggle hlsearch
  'n',
  '<Leader>hl',
  '<cmd>nohl<cr>',
  opt
)
vim.keymap.set('n', '<Leader>o', '<cmd>only<cr>', opt)
