local utils = require('utils')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-surround',
  {
    'folke/tokyonight.nvim',
    cond = { utils.is_not_vscode, utils.is_linux },
    config = function()
      require('tokyonight').setup {
        style = 'night',
        light_style = 'night'
      }
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  {
    'dsznajder/vscode-es7-javascript-react-snippets',
    cond = utils.is_not_vscode,
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    build = 'yarn install --frozen-lockfile && yarn compile'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      local api = vim.api

      require 'hop'.setup { keys = 'jfkdurghalsieownvmcxypq' }

      api.nvim_set_keymap('', 's', ':HopChar1MW<CR>', {})
      api.nvim_set_keymap('', '<space>ss', ':HopChar1MW<CR>', {})
      api.nvim_set_keymap('', '<space>sw', ':HopChar1BC<CR>', {})
      api.nvim_set_keymap('', '<space>sd', ':HopChar1AC<CR>', {})

      api.nvim_create_autocmd({ 'BufEnter' }, {
        pattern = { 'neo-tree' },
        callback = function()
          vim.api.nvim_set_keymap('n', 's', ':HopChar1<CR>', {})
        end
      })
    end
  },
  {
    'kassio/neoterm',
    lazy = true,
    cond = utils.is_not_vscode,
    event = { 'BufEnter' },
    init = function()
      vim.opt.runtimepath:append(utils.get_home() .. '/.config/nvim/plugged/neoterm')
      vim.g.neoterm_default_mod = 'botright'
      vim.g.neoterm_keep_term_open = 1
      vim.g.neoterm_autoinsert = 0
      vim.g.neoterm_autojump = 1
    end,
    config = function()
      local function split_type()
        local width = vim.api.nvim_win_get_width(0)
        local height = vim.api.nvim_win_get_height(0) * 2.1

        if height > width then
          vim.g.neoterm_size = 10
          return 'bel'
        else
          vim.g.neoterm_size = 50
          return 'vert'
        end
      end

      local function open_neoterm(cmd)
        local split = split_type()
        local command = split .. ' ' .. cmd
        vim.api.nvim_command(command)
      end

      vim.keymap.set(
        'n',
        '<space>tt',
        function()
          open_neoterm('Ttoggle')
        end,
        { noremap = true, silent = true }
      )

      local map = vim.keymap
      local opt = { noremap = true, silent = true }
      map.set('n',
        '<space>tn',
        function()
          open_neoterm('Tnew')
        end,
        opt
      )

      map.set(
        'n',
        '<space>tr',
        function()
          open_neoterm('Tredo')
        end,
        opt
      )

      map.set(
        'n',
        '<space>tc',
        function()
          open_neoterm('Tclear')
        end,
        opt
      )

      map.set(
        'n',
        '<space>td',
        function()
          open_neoterm('Tclose')
        end,
        opt
      )
    end
  },
  {
    'ibhagwan/fzf-lua',
    cond = utils.is_not_vscode,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local map = vim.keymap
      local opts = { noremap = true, silent = true }

      map.set('n', '<space>ff', ':FzfLua files<CR>', opts)
      map.set('n', '<space>fb', ':FzfLua buffers<CR>', opts)
      map.set('n', '<space>fm', ':FzfLua marks<CR>', opts)
      map.set('n', '<space>fr', ':FzfLua grep<CR>', opts)
      map.set('n', '<space>fp', ':FzfLua registers<CR>', opts)
      map.set('n', '<space>gs', ':FzfLua git_status<CR>', opts)
    end
  },
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  'mfussenegger/nvim-dap',
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cond = { utils.is_not_vscode },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require('neo-tree').setup({
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil,           -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '›',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = 'ﰊ',
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = '*',
            highlight = 'NeoTreeFileIcon'
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
              added     = '✚',
              modified  = '',
              deleted   = '✖',
              renamed   = '',
              untracked = '',
              ignored   = '',
              unstaged  = '',
              staged    = '',
              conflict  = '',
            }
          },
        },
        window = {
          position = 'current',
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
                ['<space>'] = {
              'toggle_node',
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
                ['<2-LeftMouse>'] = 'open',
                ['<cr>'] = 'open',
                ['T'] = 'open_split',
                ['t'] = 'open_vsplit',
                ['s'] = '',
                ['C'] = 'close_node',
                ['a'] = {
              'add',
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = 'none' -- 'none', 'relative', 'absolute'
              }
            },
                ['A'] = 'add_directory', -- also accepts the optional config.show_path option like 'add'.
                ['d'] = 'delete',
                ['r'] = 'rename',
                ['y'] = 'copy_to_clipboard',
                ['x'] = 'cut_to_clipboard',
                ['p'] = 'paste_from_clipboard',
                ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like 'add':
                ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like 'add'.
                ['q'] = 'close_window',
                ['R'] = 'refresh',
                ['?'] = 'show_help',
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta"
            },
            never_show = { -- remains hidden even if visible is toggled to true
              --".DS_Store",
              --"thumbs.db"
            },
          },
          follow_current_file = false,            -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = false,               -- when true, empty folders will be grouped together
          hijack_netrw_behavior = 'open_current', -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
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
            }
          }
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = true,    -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
                  ['bd'] = 'buffer_delete',
                  ['<bs>'] = 'navigate_up',
                  ['.'] = 'set_root',
            }
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
                  ['A'] = 'git_add_all',
                  ['gu'] = 'git_unstage_file',
                  ['ga'] = 'git_add_file',
                  ['gr'] = 'git_revert_file',
                  ['gc'] = 'git_commit',
                  ['gp'] = 'git_push',
                  ['gg'] = 'git_commit_and_push',
            }
          }
        }
      })

      vim.keymap.set('n', '<space>dd', ':Neotree reveal position=current<cr>',
        { noremap = true, nowait = true, silent = true })
    end,
  }
})
