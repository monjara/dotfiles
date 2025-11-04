vim.keymap.set({ 'n', 'v' }, 'za', '<nop>', { desc = 'disable za' })
vim.keymap.set({ 'n', 'v' }, 'zd', '<nop>', { desc = 'disable zd' })
vim.keymap.set({ 'n', 'v' }, 'zf', '<nop>', { desc = 'disable zf' })
vim.keymap.set({ 'n', 'v' }, 'zF', '<nop>', { desc = 'disable zF' })
vim.keymap.set({ 'n', 'v' }, 'zh', '<nop>', { desc = 'disable zh' })
vim.keymap.set({ 'n', 'v' }, 'zr', '<nop>', { desc = 'disable zr' })

require 'mini.surround'.setup {
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'za',        -- Add surrounding in Normal and Visual modes
    delete = 'zd',     -- Delete surrounding
    find = 'zf',       -- Find surrounding (to the right)
    find_left = 'zF',  -- Find surrounding (to the left)
    highlight = 'zh',  -- Highlight surrounding
    replace = 'zr',    -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',

  -- Whether to disable showing non-error feedback
  -- This also affects (purely informational) helper messages shown after
  -- idle time if user input is required.
  silent = false,
}
