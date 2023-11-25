vim.opt.laststatus = 0
vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })
local width = vim.api.nvim_win_get_width(0)
local line = string.rep('─', width)
vim.opt.statusline = line
