vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')

for k, v in pairs({
  number = true,
  fenc = 'utf-8',
  encoding = 'utf-8',
  ignorecase = true,
  wildignorecase = true,
  hidden = true,
  showcmd = true,
  autoread = true,
  backup = false,
  showmatch = true,
  swapfile = false,
  cursorline = true,
  visualbell = true,
  splitright = true,
  cmdheight = 2,
  laststatus = 2,
  writebackup = false,
  updatetime = 300,
  virtualedit = 'onemore',
  wildmode = 'list:longest',
  autoindent = true,  -- 改行時に前の行のインデントを計測
  smartindent = true, -- "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
  cindent = true,     -- "Cプログラムファイルの自動インデントを始める
  smarttab = true,    -- "新しい行を作った時に高度な自動インデントを行う
  expandtab = true,   -- "タブ入力を複数の空白に置き換える
  tabstop = 2,        -- "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
  shiftwidth = 2,     -- "自動インデントで入る空白数
  softtabstop = 0,    -- "キーボードから入るタブの数
}) do
  vim.opt[k] = v
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    vim.opt_local.sw = 2
    vim.opt_local.sts = 2
    vim.opt_local.ts = 2
    vim.opt_local.et = true
  end
})

vim.cmd([[
filetype off
filetype plugin indent on
]])

local utils = require('utils')
vim.g.python3_host_prog = utils.join_paths(vim.loop.os_homedir(), '.anyenv/envs/pyenv/shims/python')

-- lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'simeji/winresizer',
  'tpope/vim-surround',
  'vim-jp/vimdoc-ja',
  {
    'airblade/vim-gitgutter',
    init = function()
      vim.opt.signcolumn = 'yes'
    end
  },
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
    'rafamadriz/neon',
    cond = { utils.is_not_vscode, utils.is_mac },
    init = function()
      vim.g.neon_style = "Dark"
      vim.g.neon_italic_comment = false
      vim.g.neon_italic_keyword = false
      vim.g.neon_italic_boolean = false
      vim.g.neon_italic_function = false
      vim.g.neon_italic_variable = false
      vim.g.neon_bold = false
      vim.g.neon_transparent = false
    end,
    config = function()
      vim.cmd [[colorscheme neon]]
    end
  },
  {
    'folke/zen-mode.nvim',
    cond = utils.is_not_vscode,
    config = function()
      require('zen-mode').setup {}
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
      vim.cmd [[let &runtimepath.=$HOME.'/.config/nvim/plugged/neoterm']]
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
  {
    'nvim-lualine/lualine.nvim',
    cond = utils.is_not_vscode,
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'nightfly' },
      }
    end,
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
    'mattn/emmet-vim',
    cond = utils.is_not_vscode,
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
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
              ['A']  = 'git_add_all',
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

require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
})
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    'lua_ls',
  }
})

local nvim_lsp = require 'lspconfig'

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

-- lua
nvim_lsp.lua_ls.setup {
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

-- rust
local rt = require('rust-tools')
rt.setup {
  server = {
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ["rust_analyzer"] = {
        checkOnSave = {
          command = 'clippy',
        }
      }
    }
  }
}

-- ts
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = lsp_flags
}


-- terraform
nvim_lsp.terraformls.setup {
  on_attach = on_attach,
  flags = lsp_flags
}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end
})

nvim_lsp.docker_compose_language_service.setup {
  on_attach = on_attach,
  flags = lsp_flags
}


nvim_lsp.dockerls.setup {
  on_attach = on_attach,
  flags = lsp_flags
}

if vim.fn.has('mac') == 1 then
  -- swift
  nvim_lsp.sourcekit.setup {
    on_attach = on_attach,
    flags = lsp_flags
  }
end

-- lspconfig
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local cmp = require 'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.g.mapleader = ','
vim.api.nvim_set_keymap('n', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<space>', '', { noremap = true })
vim.api.nvim_set_keymap('n', [[\]], ',', {})
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', 'gj', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'gk', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':<C-u>nohl<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>only<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZZ', '', { noremap = true })
vim.api.nvim_set_keymap('n', 'ZQ', '', { noremap = true })

vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<A-i>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<space>yf',
  function()
    vim.api.nvim_command('let @" = expand("%:p")')
    vim.api.nvim_command('let @+ = expand("%:p")')
  end
)

vim.keymap.set(
  'n',
  '<space>yd',
  function()
    vim.api.nvim_command('let @" = expand("%:p:h")')
    vim.api.nvim_command('let @+ = expand("%:p:h")')
  end
)

vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h'
})

-- TODO: implement with nvim_create_user_command()
vim.cmd([[
command! -nargs=0 VV :tabnew $MYVIMRC | :tcd %:h
command! -nargs=0 SV :source ~/.config/nvim/init.lua
command! -nargs=1 -complete=help H :vertical belowright help <args>
]])


require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'lua',
    'rust'
  },
  highlight = {
    enable = true
  }
}

vim.cmd([[
function! CreateCenteredFloatingWindow() abort
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let l:textbuf = nvim_create_buf(v:false, v:true)
    call nvim_open_win(l:textbuf, v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
    return l:textbuf
endfunction

function! FloatingWindowHelp(query) abort
    let l:buf = CreateCenteredFloatingWindow()
    call nvim_set_current_buf(l:buf)
    setlocal filetype=help
    setlocal buftype=help
    execute 'help ' . a:query
endfunction

command! -complete=help -nargs=? Help call FloatingWindowHelp(<q-args>)
]])
