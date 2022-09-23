local map = vim.keymap
local opts = { noremap = true, silent = true }

map.set('n', '<space>ff', ':FzfLua files<CR>', opts)
map.set('n', '<space>fb', ':FzfLua buffers<CR>', opts)
map.set('n', '<space>fm', ':FzfLua marks<CR>', opts)
map.set('n', '<space>fr', ':FzfLua grep<CR>', opts)
map.set('n', '<space>fp', ':FzfLua registers<CR>', opts)
map.set('n', '<space>gs', ':FzfLua git_status<CR>', opts)
-- TODO add keymap
