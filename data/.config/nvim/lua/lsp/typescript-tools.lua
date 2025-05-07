return {
  'pmizio/typescript-tools.nvim',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opt = {},
  config = function()
    require('typescript-tools').setup {
      settings = {
        tsserver_locale = 'ja',
      },
    }
  end,
}
