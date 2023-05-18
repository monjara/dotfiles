local utils = require('utils')

local maps = {
  { { 'n', 'v' }, '<space>',   '' },
  { 'n',          '<space>q',  '<cmd>q!<cr>' },
  { 'n',          '<space>wq', '<cmd>wq<cr>' },
  { 'n',          [[\]],       ',' },
  { 'n',          'j',         'gj' },
  { 'n',          'k',         'gk' },
  { 'n',          'gj',        'j' },
  { 'n',          'gk',        'k' },
  { 'n',          '<Leader>n', '<cmd>nohl<cr>' },
  { 'n',          '<Leader>o', '<cmd>only<cr>' },
  { 'n',          'ZZ',        '' },
  { 'n',          'ZQ',        '' },
  { 'n',          '<space>tt', '<cmd>terminal<CR>' },
  { 'i',          'jj',        '<esc>' },
  { 'i',          '{',         '{}<left>' },
  { 'i',          '[',         '[]<left>' },
  { 'i',          [[']],       [[''<left>]] },
  { 'i',          [["]],       [[""<left>]] },
  { { 'i', 'c' }, '<cr>',      '' },
  { { 'i', 'c' }, '<C-l>',     '<cr>' },
  { 't',          '<M-i>',     [[<C-\><C-n>]] },
  {
    'n',
    '<space>yf',
    function()
      vim.api.nvim_command('let @" = expand("%:p")')
      vim.api.nvim_command('let @+ = expand("%:p")')
    end
  },
  {
    'n',
    '<space>yd',
    function()
      vim.api.nvim_command('let @" = expand("%:p:h")')
      vim.api.nvim_command('let @+ = expand("%:p:h")')
    end
  }
}

utils.keymap_set(maps)
