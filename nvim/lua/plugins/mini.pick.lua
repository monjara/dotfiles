return {
  'nvim-mini/mini.pick',
  version = false,
  keys = {
    {'<space>fr', '<cmd>Pick grep_live<cr>', { desc = 'min.pick live grep' }},
    {'<space>ff', '<cmd>Pick files<cr>', { desc = 'min.pick find file' }},
    {'<c-p>', '<cmd>Pick files<cr>', { desc = 'min.pick find file' }},
    {'<space>fb', '<cmd>Pick buffers<cr>', { desc = 'min.pick find file' }},
  },
  opts = {
    -- Delays (in ms; should be at least 1)
    delay = {
      -- Delay between forcing asynchronous behavior
      async = 10,

      -- Delay between computation start and visual feedback about it
      busy = 50,
    },

    -- Keys for performing actions. See `:h MiniPick-actions`.
    mappings = {
      caret_left  = '<Left>',
      caret_right = '<Right>',

      choose            = '<CR>',
      choose_in_split   = '<C-s>',
      choose_in_tabpage = '<C-t>',
      choose_in_vsplit  = '<C-v>',
      choose_marked     = '<M-CR>',

      delete_char       = '<BS>',
      delete_char_right = '<Del>',
      delete_left       = '<C-u>',
      delete_word       = '<C-w>',

      mark     = '<C-x>',
      mark_all = '<C-a>',

      move_down  = '<C-n>',
      move_start = '<C-g>',
      move_up    = '<C-p>',

      paste = '<C-r>',

      refine        = '<C-Space>',
      refine_marked = '<M-Space>',

      scroll_down  = '<C-f>',
      scroll_left  = '<C-h>',
      scroll_right = '<C-l>',
      scroll_up    = '<C-b>',

      stop = '<Esc>',

      toggle_info    = '<S-Tab>',
      toggle_preview = '<Tab>',
    },

    -- General options
    options = {
      -- Whether to show content from bottom to top
      content_from_bottom = false,

      -- Whether to cache matches (more speed and memory on repeated prompts)
      use_cache = false,
    },

    -- Source definition. See `:h MiniPick-source`.
    source = {
      items = nil,
      name  = nil,
      cwd   = nil,

      match   = nil,
      show    = nil,
      preview = nil,

      choose        = nil,
      choose_marked = nil,
    },

    -- Window related options
    window = {
      -- String to use as caret in prompt
      prompt_caret = '▏',

      -- String to use as prefix in prompt
      prompt_prefix = '> ',

      prompt_positon = 'top',

      -- Float window config (table or callable returning it)
      config = function()
        local width  = math.floor(vim.o.columns * 0.90)
        local height = math.floor(vim.o.lines   * 0.90)

        return {
          relative = "editor",
          anchor = "NW",
          row = 1, -- 上から1行（もう少し下げたいなら 2,3...）
          col = math.floor((vim.o.columns - width) / 2),
          width = width,
          height = height,
          border = "rounded",
        }
      end,
    },
  }
}
