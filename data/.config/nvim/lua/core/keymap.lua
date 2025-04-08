local utils = require('utils')

local maps = {
  { { 'n', 'v' }, '<space>', '' },
  { 'n', '<space>w', '<cmd>silent w!<cr>' },
  { 'n', '<space>q', '<cmd>q!<cr>' },
  { 'n', '<space>wq', '<cmd>wq<cr>' },
  { 'n', [[\]], ',' },
  { 'n', 'j', 'gj' },
  { 'n', 'k', 'gk' },
  { 'n', 'gj', 'j' },
  { 'n', 'gk', 'k' },
  { 'n', 'ZZ', '' },
  { 'n', 'ZQ', '' },
  { 'n', '<space>tt', '<cmd>terminal<CR>' },
  { 'n', '<space>si', [[<cmd>%s/"/'/g<CR>]] },
  { 'i', 'jj', '<esc>' },
  { { 'i', 'c' }, '<C-l>', '<esc>' },
  { 't', '<M-i>', [[<C-\><C-n>]] },
  { 'n', '<space>j', '<cmd>bnext<cr>' },
  { 'n', '<space>k', '<cmd>bprevious<cr>' },
  {
    -- yank and copy current file's absolute path to clipboard
    'n',
    '<Leader>fp',
    function()
      vim.api.nvim_command('let @" = expand("%:.")')
      vim.api.nvim_command('let @+ = expand("%:.")')
    end,
  },
  {
    -- yank and copy directiory that current file existing to clipboard
    'n',
    '<Leader>fd',
    function()
      vim.api.nvim_command('let @" = expand("%:p:h")')
      vim.api.nvim_command('let @+ = expand("%:p:h")')
    end,
  },
  {
    -- echo current file name
    'n',
    '<Leader>fe',
    function()
      vim.api.nvim_command('echo expand("%:p")')
    end,
  },
  {
    -- toggle line number (call :set number!)
    'n',
    '<Leader>nn',
    function()
      vim.api.nvim_command('set number!')
    end,
  },
  {
    -- TODO: toggle hlsearch
    'n',
    '<Leader>hl',
    '<cmd>nohl<cr>',
  },
  {
    'n',
    '<Leader>o',
    '<cmd>only<cr>',
  },
}

utils.keymap_set(maps)

utils.create_custome_command('VV', 'tabnew ' .. utils.get_init_lua() .. ' | :tcd %:h', { nargs = 0 })
utils.create_custome_command('SV', 'source ' .. utils.get_init_lua(), { nargs = 0 })

utils.create_custome_command('SamBuild', '!sam build', { nargs = 0 })
