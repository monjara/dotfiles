local function split_type()
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
  '<space>tt',
  function()
    open_neoterm('Ttoggle')
  end,
  { noremap = true, silent = true }
)

local map = vim.keymap
local opt = { noremap = true, silent = true }
map.set('n',
  '<space>tn',
  function()
    open_neoterm('Tnew')
  end,
  opt
)

map.set(
  'n',
  '<space>tr',
  function()
    open_neoterm('Tredo')
  end,
  opt
)

map.set(
  'n',
  '<space>tc',
  function()
    open_neoterm('Tclear')
  end,
  opt
)

map.set(
  'n',
  '<space>td',
  function()
    open_neoterm('Tclose')
  end,
  opt
)
