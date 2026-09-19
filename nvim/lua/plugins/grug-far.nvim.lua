return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup({
      windowCreationCommand = 'edit',
      keymaps = {
        replace = { n = '<leader>r' },
        syncAll = { n = '<leader>s' },
        syncLine = { n = '<leader>l' },
        close = { n = '<leader>c' },
      },
      openTargetWindow = {
        -- preferred location for target window relative to the grug-far window. If an existing candidate
        -- window that is not excluded by the exclude filter exists in that direction, it will be reused,
        -- otherwise a new window will be created in that direction.
        -- available options: "prev" | "left" | "right" | "above" | "below"
        preferredLocation = 'prev',
      },
    });
  end
}
