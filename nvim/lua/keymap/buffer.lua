--- Checks if a buffer is terminal.
---
--- @param bufnr integer Buffer id, or 0 for current buffer
--- @return boolean # true if the buffer is terminal, false otherwise.
local function is_terminal(bufnr)
  return vim.bo[bufnr].buftype == 'terminal'
end

--- Checks if a buffer is ready (loaded, valid, and listed).
---
--- @param bufnr integer Buffer id, or 0 for current buffer
--- @return boolean # true if the buffer is ready, false otherwise.
local function buffer_is_ready(bufnr)
  return vim.api.nvim_buf_is_loaded(bufnr)
      and vim.api.nvim_buf_is_valid(bufnr)
      and vim.bo[bufnr].buflisted
end

--- Gets a list of recent buffers, sorted by last used time.
---
--- @return integer[] # A list of buffer numbers, sorted by last used time.
local function get_recent_buffers()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  table.sort(buffers, function(a, b)
    return a.lastused > b.lastused
  end)

  local bufnrs = {}

  for _, bufnr in ipairs(buffers) do
    table.insert(bufnrs, bufnr.bufnr)
  end

  return bufnrs
end


local RIGHT_DIRECTION = 1
local LEFT_DIRECTION = -1

--- Switches to the next or previous buffer, optionally filtering by terminal type.
---
--- @param opts table Options for switching buffers.
---
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

---
---
local function find_next_buffer(current_bufnr)
  local preferred = nil
  local fallback = nil

  local buffers = get_recent_buffers()

  for _, bufnr in ipairs(buffers) do
    if bufnr ~= current_bufnr
        and buffer_is_ready(bufnr)
    then
      if not is_terminal(bufnr) then
        preferred = bufnr
        break
      end
    end

    fallback = fallback or bufnr
  end

  return preferred or fallback
end


local function close_buffer()
  local current_bufnr = vim.api.nvim_get_current_buf()
  if is_terminal(current_bufnr) then
    return nil
  end

  local next_buf = find_next_buffer(current_bufnr)

  if next_buf then
    vim.api.nvim_set_current_buf(next_buf)
  end

  vim.bo[current_bufnr].buflisted = false
  vim.api.nvim_buf_delete(current_bufnr, { unload = true, force = false })
end

vim.keymap.set('n', '<leader>q', close_buffer, { desc = 'delete current buffer' })
vim.keymap.set('n', '<space>q', close_buffer, { desc = 'delete current buffer' })
