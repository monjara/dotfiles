return {
  'github/copilot.vim',
  config = function()
    local opt = { expr = true, replace_keycodes = false }
    vim.keymap.set('i', '<C-s>', 'copilot#Accept("<CR>")', opt)
    vim.keymap.set('i', '<C-f>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<C-d>', '<Plug>(copilot-previous)')
    vim.keymap.set('i', '<C-a>', '<Plug>(copilot-dismiss)')
    vim.keymap.set('i', '<C-g>', '<Plug>(copilot-suggest)')

    vim.g.copilot_no_tab_map = true
  end,
}
