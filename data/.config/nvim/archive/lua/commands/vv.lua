local init_lua = vim.fn.stdpath('config') .. '/init.lua'
vim.api.nvim_create_user_command('VV', 'tabnew' .. init_lua .. ' | :tcd %:h', { nargs = 0 })
