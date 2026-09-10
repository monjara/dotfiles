local function selection_has_diff()
  local gs = require('gitsigns')

  local a = vim.fn.line('v')
  local b = vim.fn.line('.')
  local start_line = math.min(a, b)
  local end_line = math.max(a, b)

  local hunks = gs.get_hunks(vim.api.nvim_get_current_buf())
  if not hunks then
    return false
  end

  for _, h in ipairs(hunks) do
    local h_start = h.add.start
    local h_end = h.add.start + h.add.count - 1

    if not (end_line < h_start or start_line > h_end) then
      return true
    end
  end

  return false
end

local function commit()
  local diff = selection_has_diff()
  if not diff then
    vim.notify('No changes in selected range to commit', vim.log.levels.WARN)
    return
  end

  require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') }

  vim.fn.inputsave()
  local msg = vim.fn.input('Commit message: ')
  vim.fn.inputrestore()

  if msg ~= '' then
    vim.system({ 'git', 'commit', '-m', msg }):wait()
    vim.notify('Committed selected range: ' .. msg)
  else
    vim.notify('Commit canceled')
  end
end

return {
  'lewis6991/gitsigns.nvim',
  keys = {
    {
      '<leader>ga',
      function()
        require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end,
      mode = { 'v' },
      desc = 'Git add current file',
    },
    {
      '<leader>ga',
      function()
        require('gitsigns').stage_buffer()
      end,
      mode = { 'n' },
      desc = 'Git add current file',
    },
    { '<leader>gc', commit, mode = { 'n', 'v' }, desc = 'Git commit selected range' },
  },
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
  end,
}
