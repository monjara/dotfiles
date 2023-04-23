local win_id = 0

local createPopup = function()
  local opts = {
    height = 1,
    width = 20,
    row = 0,
    col = vim.o.columns - 20,
    focusable = false,
    relative = 'editor',
    zindex = 45
  }
  local bufnr = vim.api.nvim_create_buf(false, true)
  local recording = vim.api.nvim_exec('echo reg_recording()', true)
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { ' Recording: ' .. recording })
  win_id = vim.api.nvim_open_win(bufnr, false, opts)

  local ns_id = vim.api.nvim_create_namespace('recording')
  vim.api.nvim_win_set_hl_ns(win_id, ns_id)
  vim.api.nvim_set_hl(ns_id, 'Normal', { fg = '#eb6ea5' })
end


local closePopup = function()
  vim.api.nvim_win_close(win_id, true)
end


vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
  callback = function()
    createPopup()
  end
})

vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
  callback = function()
    closePopup()
  end
})
