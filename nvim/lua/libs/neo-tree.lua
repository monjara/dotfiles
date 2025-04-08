return {
  'nvim-neo-tree/neo-tree.nvim',
  lazy = true,
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
        }
      end,
    },
  },
  keys = {
    { '<space>dd', '<cmd>Neotree reveal position=current<cr>', desc = 'Neotree' },
  },
  config = function()
    vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

    local function copy_path(state)
      -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
      -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify

      local results = {
        filepath,
        modify(filepath, ':.'),
        modify(filepath, ':~'),
        filename,
        modify(filename, ':r'),
        modify(filename, ':e'),
      }

      vim.ui.select({
        results[1],
        results[2],
        results[3],
        results[4],
        results[5],
        results[6],
      }, {
        prompt = 'Choose to copy to clipboard:',
      }, function(choice, index)
        if choice == nil then
          vim.notify('Selection cancelled')
        end

        local result = results[index]
        vim.fn.setreg('*', result)
      end)
    end

    require('neo-tree').setup {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      sort_case_insensitive = false,
      sort_function = nil,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
          with_expanders = nil,
          expander_collapsed = '›',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          --[[
          folder_closed = '',
          folder_open = '',
          folder_empty = 'ﰊ',
          ]]
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            added = '✚',
            modified = '',
            deleted = '✖',
            renamed = '',
            untracked = '',
            ignored = '',
            unstaged = '',
            staged = '',
            conflict = '',
          },
        },
      },
      window = {
        position = 'current',
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ['<cr>'] = '',
          ['<C-l>'] = 'open',
          ['<C-j>'] = 'open',
          ['T'] = 'open_split',
          ['t'] = 'open_vsplit',
          ['s'] = '',
          ['C'] = 'close_node',
          ['a'] = {
            'add',
            config = {
              show_path = 'none',
            },
          },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['Y'] = copy_path,
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
          hide_by_name = {},
          hide_by_pattern = {},
          never_show = {},
        },
        follow_current_file = {
          enabled = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = false,
        window = {
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
            ['H'] = 'toggle_hidden',
            ['/'] = 'fuzzy_finder',
            ['f'] = 'filter_on_submit',
            ['<c-x>'] = 'clear_filter',
            ['[g'] = 'prev_git_modified',
            [']g'] = 'next_git_modified',
          },
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
        group_empty_dirs = true,
        show_unloaded = true,
        window = {
          mappings = {
            ['<bs>'] = 'navigate_up',
            ['.'] = 'set_root',
          },
        },
      },
    }
  end,
}
