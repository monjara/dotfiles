require('blink.cmp').setup {
  keymap = {
    preset = 'none',
    ['<cr>'] = { 'select_and_accept', 'fallback' },
    ['<C-l>'] = { 'select_and_accept', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
  }
}
