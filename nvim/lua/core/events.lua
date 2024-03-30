vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h',
})
