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
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-lua/popup.nvim' },
  { import = 'libs' },
  --[[
  --   local development
  --   { dir = '~/Develop/lua/fuga' }
  --]]
}

local rpc_path = require('utils').get_config() .. '/oxi'
vim.cmd('set rtp+=' .. rpc_path)
