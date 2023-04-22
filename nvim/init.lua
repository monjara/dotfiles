require('core')
require('plugins')
require('lsp')
require('custom')
require('keymap')

vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h'
})
