local function split_type()
  -- local current_win = vim.api.nvim_win_get_number(0)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0) * 2.1

  if height > width then
    vim.g.neoterm_size = 10
    return 'bel'
  else
    vim.g.neoterm_size = 50
    return 'vert'
  end
end

local function open_neoterm(cmd)
  local split = split_type()
  local command = split .. ' ' .. cmd
  vim.api.nvim_command(command)
end

vim.keymap.set(
  'n',
  '<Space>tt',
  function()
    open_neoterm('Ttoggle')
  end,
  { noremap = true, silent = true })
vim.keymap.set('n',
  '<Space>tn',
  function()
    open_neoterm('Tnew')
  end,
  { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<Space>tr',
  function()
    open_neoterm('Tredo')
  end,
  { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<Space>tc',
  function()
    open_neoterm('Tclear')
  end,
  { noremap = true, silent = true })
vim.keymap.set(
  'n',
  '<Space>td',
  function()
    open_neoterm('Tclose')
  end,
  { noremap = true, silent = true })
