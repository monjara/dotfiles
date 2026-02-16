return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  branch = 'main',
  dependencie = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  main = 'nvim-treesitter.configs',
  opts = {
    highlight = { enable = true },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = 'CursorMoved'
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  }
}
