return {
  'nvim-mini/mini.base16',
  version = false,
  lazy = false,
  config = function()
    -- local base16 = require('mini.base16')
    -- local zenn_palette = base16.mini_palette(
    --   '#1f1e2b', -- background
    --   '#ebeddf', -- foreground
    --   70         -- accent chroma
    -- )
    -- base16.setup({ palette = zenn_palette })
    --
    -- -- overwrite highlight WinSeparator
    -- vim.api.nvim_set_hl(0, 'WinSeparator', { link = 'Comment' })
    -- -- call autocmd ColorScheme manually
    -- vim.api.nvim_exec_autocmds('ColorScheme', {})
  end
}
