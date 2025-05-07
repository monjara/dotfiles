return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      default_settings = {
        ['rust-analyzer'] = {
          checkOnSave = false,
        },
      },
    }
  end,
}
