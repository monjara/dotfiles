local utils = require('utils')
return {
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-vsnip' },
    {
      'hrsh7th/vim-vsnip',
      config = function()
        vim.g.vsnip_snippet_dir = utils.get_config() .. '/.vsnip'
      end
    },
    { 'hrsh7th/cmp-cmdline' },
  }
}
