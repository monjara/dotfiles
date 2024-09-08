vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h',
})
vim.api.nvim_create_augroup('neotree', {})
vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = 'neotree',
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd('Neotree toggle')
    end
  end,
})
