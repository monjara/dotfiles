if vim.g.vscode then
  require('vscode_nvim')
else
  require('opts')
  require('packer_config')
  require('mason_config')
  require('lsp_config')
  require('cmp_config')
  require('keymap')
  require('plugins.treesitter.config')
  require('custome')
end
