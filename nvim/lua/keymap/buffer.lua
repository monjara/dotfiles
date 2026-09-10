local function is_terminal(bufnr)
  return vim.bo[bufnr].buftype == 'terminal'
end

local RIGHT_DIRECTION = 1
local LEFT_DIRECTION = -1

local function switch_buffer(opts)
  opts = opts or {}
  local direction = opts.direction or RIGHT_DIRECTION
  local switch_type = opts.switch_mode or false

  local current_buf = vim.api.nvim_get_current_buf()

  local target_is_terminal = switch_type ~= is_terminal(current_buf)

  local buffers = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and is_terminal(buf) == target_is_terminal
  end, vim.api.nvim_list_bufs())

  if #buffers == 0 then
    return
  end

  if switch_type then
    local index = direction == RIGHT_DIRECTION and 1 or #buffers
    vim.api.nvim_set_current_buf(buffers[index])
    return
  end

  if #buffers < 2 then
    return
  end

  for i, buf in ipairs(buffers) do
    if buf == current_buf then
      local next_index = (i - 1 + direction) % #buffers + 1
      vim.api.nvim_set_current_buf(buffers[next_index])
      return
    end
  end
end

vim.keymap.set('n', '<tab>', function()
  switch_buffer { direction = RIGHT_DIRECTION }
end, { desc = 'Next buffer' })

vim.keymap.set('n', '<space><tab>', function()
  switch_buffer { direction = RIGHT_DIRECTION, switch_mode = true }
end, { desc = 'Next buffer' })

vim.keymap.set('n', '<S-tab>', function()
  switch_buffer { direction = LEFT_DIRECTION }
end, { desc = 'previous buffer' })

vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>', { desc = 'delete current buffer' })
