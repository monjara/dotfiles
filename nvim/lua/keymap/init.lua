require('keymap.buffer')
require('keymap.lsp')

vim.keymap.set('i', 'jj', '<esc>', {})

vim.keymap.set('n', '<space>q', '<cmd>q!<cr>', { desc = 'quit' })

vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set('n', '<leader>o', '<cmd>only<cr>', { silent = true })

local copy_to_clipboard = function(text)
  vim.fn.setreg('+', text)
  print('Copied: ' .. text)
end

vim.api.nvim_create_user_command('CopyRelativePath', function()
  local path = vim.fn.expand('%')
  copy_to_clipboard(path)
end, {})

vim.api.nvim_create_user_command('CopyAbsolutePath', function()
  local path = vim.fn.expand('%:p')
  copy_to_clipboard(path)
end, {})

vim.api.nvim_create_user_command('CopyFileName', function()
  local path = vim.fn.expand('%:t')
  copy_to_clipboard(path)
end, {})

vim.keymap.set('n', '<leader>yr', '<cmd>CopyRelativePath<cr>', { desc = 'Copy relative path to clipboard' })
vim.keymap.set('n', '<leader>ya', '<cmd>CopyAbsolutePath<cr>', { desc = 'Copy absolute path to clipboard' })
vim.keymap.set('n', '<leader>yf', '<cmd>CopyFileName<cr>', { desc = 'Copy file name to clipboard' })

vim.api.nvim_create_user_command('ColumnT', function()
  vim.cmd('%!column -t')
end, { range = true })

vim.api.nvim_create_user_command('ToggleWrap', function()
  local wrap = vim.wo.wrap
  vim.wo.wrap = not wrap
end, { range = false })

vim.api.nvim_create_user_command('Filetype', function()
  local filetype = vim.bo.filetype
  vim.notify('Current filetype: ' .. filetype)
end, { range = false })

vim.keymap.set('n', 'z.', function()
  local win = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(win)
  local cursor_col = vim.fn.virtcol('.')
  local leftcol = math.max(0, cursor_col - math.floor(width / 2))

  vim.fn.winrestview {
    leftcol = leftcol,
  }
end, {
  desc = 'Center cursor horizontally',
})

vim.api.nvim_create_user_command('Cwd', function()
  local cwd = vim.fn.getcwd()
  vim.notify(cwd)
end, { range = false })

vim.keymap.set('i', '<C-g>', '<Esc>')
vim.keymap.set('t', '<C-g>', '<C-\\><C-n>')

vim.api.nvim_create_user_command('Term', function(opts)
  local args = opts.fargs

  local name = table.remove(args, 1)
  if not name then
    vim.notify('Usage: Term <name> [command...]', vim.log.levels.ERROR)
    return
  end

  vim.cmd('terminal ' .. table.concat(args, ' '))
  vim.api.nvim_buf_set_name(0, name)
end, {
  nargs = '+',
})
