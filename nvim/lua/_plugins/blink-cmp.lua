require('blink.cmp').setup {
  keymap = {
    preset = 'none',
    ['<cr>'] = { 'select_and_accept', 'fallback' },
    ['<c-l>'] = { 'select_and_accept', 'fallback' },
    ['<c-j>'] = { 'select_next', 'fallback' },
    ['<c-k>'] = { 'select_prev', 'fallback' },
    ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<c-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
  },
  cmdline = {
    completion = {
      menu = {
        auto_show = true
      }
    },
    keymap = {
      preset = 'none',
      ['<c-l>'] = { 'select_and_accept', 'fallback' },
      ['<c-j>'] = { 'select_next', 'fallback' },
      ['<c-k>'] = { 'select_prev', 'fallback' },
      ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<c-h>'] = { 'show', 'show_documentation', 'hide_documentation' },
    }
  },
  fuzzy = {
    implementation = "rust"
  }
}
