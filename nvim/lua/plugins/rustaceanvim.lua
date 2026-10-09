return {
  'mrcjkb/rustaceanvim',
  version = '^9', -- Recommended
  lazy = false, -- This plugin is already lazy

  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            files = {
              excludeDirs = { '.direnv' },
            },
          },
        },
      },
    }
  end,
}
