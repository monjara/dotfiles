require('custom.help')

local utils = require('utils')
utils.create_custome_command('VV', 'tabnew ' .. utils.get_init_lua() .. ' | :tcd %:h', { nargs = 0 })
utils.create_custome_command('SV', 'source ' .. utils.get_init_lua(), { nargs = 0 })