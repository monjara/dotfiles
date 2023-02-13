require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'lua',
    'rust'
  },
  highlight = {
    enable = true
  }
}
