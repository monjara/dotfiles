local utils = require('utils')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'goolord/alpha-nvim',
    lazy = true,
    event = 'BufWinEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  },
  {
    'kylechui/nvim-surround',
    lazy = true,
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'folke/tokyonight.nvim',
    cond = utils.is_not_vscode,
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
    lazy = true,
    cond = utils.is_not_vscode,
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    build = 'yarn install --frozen-lockfile && yarn compile'
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    event = { 'CursorHold', 'CursorHoldI' },
    dependencies = {
      'windwp/nvim-ts-autotag'
    },
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command('TSUpdate')
      end
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'javascript',
          'typescript',
          'lua',
          'rust'
        },
        highlight = {
          enable = true
        },
        autotag = {
          enable = true
        }
      }
    end
  },
  {
    'phaazon/hop.nvim',
    lazy = true,
    branch = 'v2',
    keys = {
      { 's',         '<cmd>HopChar1MW<cr>', desc = 'hop' },
      { '<space>ss', '<cmd>HopChar1MW<cr>', desc = 'hop' },
      { '<space>sw', '<cmd>HopChar1BC<cr>', desc = 'hop' },
      { '<space>sd', '<cmd>HopChar1AC<cr>', desc = 'hop' },
    },
    config = function()
      require 'hop'.setup { keys = 'jfkdurghalsieownvmcxypq' }
      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
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
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<space>ff', '<cmd>Telescope find_files<cr>', desc = 'Telescope' },
      { '<space>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Telescope' },
      { '<space>fb', '<cmd>Telescope buffers<cr>',    desc = 'Telescope' },
      { '<space>fh', '<cmd>Telescope help_tags<cr>',  desc = 'Telescope' }
    },
    config = function()
      require 'telescope'.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-k>'] = require('telescope.actions').move_selection_previous,
              ['<C-j>'] = require('telescope.actions').move_selection_next,
              ['<C-l>'] = require('telescope.actions').select_default,
              ['<CR>'] = function()
              end
            }
          }
        }
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    }
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-vsnip' },
      { 'hrsh7th/vim-vsnip' },
      { 'hrsh7th/cmp-cmdline' },
    }
  },
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust', 'toml' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = true,
    branch = 'v2.x',
    cond = utils.is_not_vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<space>dd', '<cmd>Neotree reveal position=current<cr>', desc = 'Neotree' },
    },
    config = require('plugins.config.neo-tree')
  }
})
