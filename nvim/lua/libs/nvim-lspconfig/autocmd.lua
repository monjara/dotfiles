local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.tf', '*.tfvars' },
    callback = function()
      vim.lsp.buf.format()
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.swiftinterface' },
    callback = function()
      vim.api.nvim_command('set filetype=swift')
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.swift-format' },
    callback = function()
      vim.api.nvim_command('set filetype=json')
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
    pattern = { '*.ejs' },
    callback = function()
      vim.api.nvim_command('set filetype=html')
    end,
  })
end
return M
