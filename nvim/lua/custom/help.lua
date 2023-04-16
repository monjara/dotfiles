local function createFloatingHelp(q)
  local lines = vim.o.lines - vim.o.cmdheight
  local columns = vim.o.columns
  local height = lines - 4
  local width = math.min(columns - 10, 80)
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  local opts = {
    height = height,
    width = width,
    row = row,
    col = col,
    relative = 'editor',
    style = 'minimal',
    zindex = 45,
  }
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(bufnr, true, opts)
  vim.opt_local.filetype = 'help'
  vim.opt_local.buftype = 'help'
  vim.api.nvim_command('help ' .. q['args'])
end

vim.api.nvim_create_user_command(
  'H',
  function(opts)
    createFloatingHelp(opts)
  end,
  {
    nargs = 1,
    complete = 'help'
  }
)
