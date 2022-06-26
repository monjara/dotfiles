-- packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.o.runtimepath = fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'leico/autodate.vim'
  use 'simeji/winresizer'
  use 'tpope/vim-surround'
  use 'vim-jp/vimdoc-ja'

  use {
    'airblade/vim-gitgutter',
    setup = function()
      vim.cmd [[set signcolumn=yes]]
    end
  }

  use {
    'folke/tokyonight.nvim',
    setup = function()
      vim.g.tokyonight_style = "night"
      vim.g.tokyonight_terminal_colors = true
      vim.g.tokyonight_italic_comments = false
      vim.g.tokyonight_italic_keywords = false
      vim.g.tokyonight_italic_functions = false
      vim.g.tokyonight_italic_variables = false
      vim.g.tokyonight_transparent = false
      vim.g.tokyonight_hide_inactive_statusline = false
      vim.g.tokyonight_sidebars = {}
      vim.g.tokyonight_transparent_sidebar = false
      vim.g.tokyonight_dark_sidebar = true
      vim.g.tokyonight_dark_float = true
      vim.g.tokyonight_colors = {}
      vim.g.tokyonight_day_brightness = 0.3
      vim.g.tokyonight_lualine_bold = false
    end,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'terryma/vim-multiple-cursors',
    setup = function()
      vim.g.multi_cursor_use_default_mapping = 0
      vim.g.multi_cursor_start_word_key      = '<C-n>'
      vim.g.multi_cursor_select_all_word_key = '<A-n>'
      vim.g.multi_cursor_start_key           = 'g<C-n>'
      vim.g.multi_cursor_select_all_key      = 'g<A-n>'
      vim.g.multi_cursor_next_key            = '<C-n>'
      vim.g.multi_cursor_prev_key            = '<C-p>'
      vim.g.multi_cursor_skip_key            = '<C-x>'
      vim.g.multi_cursor_quit_key            = '<Esc>'
    end
  }

  use {
    'easymotion/vim-easymotion',
    setup = function()
      vim.g.EasyMotion_do_mapping = 0
    end,
    config = function()
      vim.keymap.set('n', 's', "<Plug>(easymotion-overwin-f)", { noremap = false, nowait = true })
      vim.keymap.set('n', '<Space>sf', "<Plug>(easymotion-overwin-f2)", { noremap = false, nowait = true })
      vim.keymap.set('n', '<Space>sl', "<Plug>(easymotion-overwin-line)", { noremap = false, nowait = true })
      vim.keymap.set('n', '<Space>sw', "<Plug>(easymotion-overwin-w)", { noremap = false, nowait = true })
    end
  }

  use {
    'kassio/neoterm',
    opt = true,
    event = { 'BufEnter' },
    setup = function()
      vim.cmd [[let &runtimepath.=$HOME.'/.config/nvim/plugged/neoterm']]
      vim.g.neoterm_default_mod = 'botright'
      vim.g.neoterm_keep_term_open = 1
      vim.g.neoterm_autoinsert = 0
      vim.g.neoterm_autojump = 1
    end,
    config = function()
      local function split_type()
        -- local current_win = vim.api.nvim_win_get_number(0)
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
        '<Space>tt',
        function()
          open_neoterm('Ttoggle')
        end,
        { noremap = true, silent = true })
      vim.keymap.set('n',
        '<Space>tn',
        function()
          open_neoterm('Tnew')
        end,
        { noremap = true, silent = true })
      vim.keymap.set(
        'n',
        '<Space>tr',
        function()
          open_neoterm('Tredo')
        end,
        { noremap = true, silent = true })
      vim.keymap.set(
        'n',
        '<Space>tc',
        function()
          open_neoterm('Tclear')
        end,
        { noremap = true, silent = true })
      vim.keymap.set(
        'n',
        '<Space>td',
        function()
          open_neoterm('Tclose')
        end,
        { noremap = true, silent = true })
    end
  }

  use {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>ff', "<cmd>lua  require('fzf-lua').files()<CR>", opts)
      vim.keymap.set('n', '<space>fb', "<cmd>lua  require('fzf-lua').buffers()<CR>", opts)
      vim.keymap.set('n', '<space>fm', "<cmd>lua  require('fzf-lua').marks()<CR>", opts)
      vim.keymap.set('n', '<space>fr', "<cmd>lua  require('fzf-lua').grep()<CR>", opts)
      vim.keymap.set('n', '<space>fp', "<cmd>lua  require('fzf-lua').registers()<CR>", opts)
      vim.keymap.set('n', '<space>gs', "<cmd>lua  require('fzf-lua').git_status()<CR>", opts)
      -- TODO add keymap
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'nightfly' },
      }
    end,
  }

  -- TODO: lazy
  use { 'mattn/emmet-vim',
    opt = true,
    event = { 'BufEnter' },
  }

  use {
    'rust-lang/rust.vim',
    opt = true,
    ft = 'rust',
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>rr', ':<C-u>T cargo run .<CR>', opts)
      vim.keymap.set('n', '<space>rt', ':<C-u>T cargo test<CR>', opts)
    end
  }

  use {
    'pantharshit00/vim-prisma',
    opt = true,
    ft = 'prisma'
  }

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('lsp_config')
require('keymap')
require('opts')
