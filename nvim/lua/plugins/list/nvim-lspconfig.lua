return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  }
}
