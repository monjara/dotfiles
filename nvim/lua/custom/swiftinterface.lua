vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.swiftinterface' },
  callback = function()
    vim.api.nvim_command('set filetype=swift')
  end
})
