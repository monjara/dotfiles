local utils = require('utils')
utils.create_custome_command('VV', 'tabnew ' .. utils.get_init_lua() .. ' | :tcd %:h', { nargs = 0 })
utils.create_custome_command('SV', 'source ' .. utils.get_init_lua(), { nargs = 0 })

vim.opt.rtp:append(vim.fn.stdpath('config') .. '/oxi')
require('core')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:append(lazypath)

require('lazy').setup {
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { import = 'libs' },
  --[[
  --   local development
  --   { dir = '~/Develop/lua/fuga' }
  --]]
}
