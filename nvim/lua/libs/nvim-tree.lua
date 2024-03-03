return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    local api = require('nvim-tree.api')

    local function on_attach(bufnr)
      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true
        }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      for _, v in ipairs({
        { 'n', '<C-l>', api.node.open.edit, opts('edit') },
        { 'n', '<CR>',  'j',                opts('down') },
        { 'n', 's',     's',                opts('hop') },
      }) do
        vim.keymap.set(v[1], v[2], v[3], v[4])
      end
    end

    require('nvim-tree').setup {
      on_attach = on_attach,
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        float = {
          enable = true,
          open_win_config = {
            width = 80,
            height = 30,
            row = 1,
            col = 20,
          },
        }
      },
      renderer = {
        group_empty = true,
        highlight_git = 'all',
        icons = {
          git_placement = 'after',
          glyphs = {
            git = {
              unstaged = '+',
              untracked = '?',
              deleted = '-',
              renamed = 'R',
              staged = '!'
            }
          }
        }
      },
      filters = {
        dotfiles = false,
      },
      actions = {
        open_file = {
          quit_on_open = true
        }
      }
    }

    vim.keymap.set('n', '<space>dd', '<cmd>NvimTreeFindFile<cr>', {})
  end,

}
