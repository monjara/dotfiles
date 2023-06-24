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
    'folke/zen-mode.nvim',
    lazy = true,
    keys = {
      { '<space>z', '<cmd>ZenMode<cr>' }
    },
    config = function()
      require('zen-mode').setup {}
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
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    opts = {}
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
      { 's', '<cmd>HopChar1MW<cr>', desc = 'hop' }
    },
    config = function()
      require 'hop'.setup { keys = 'jfkdurghalsieownvmcxypq' }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<space>ff', '<cmd>Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git <cr>', desc = 'Telescope' },
      { '<space>fr', '<cmd>Telescope live_grep find_command=rg,--files,--hidden,--glob,!*.git <cr>',  desc = 'Telescope' },
      { '<space>fb', '<cmd>Telescope buffers find_command=rg,--files,--hidden,--glob,!*.git <cr>',    desc = 'Telescope' },
      { '<space>fh', '<cmd>Telescope help_tags<cr>',                                                  desc = 'Telescope' }
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
    lazy = true,
    ft = { 'rust', 'toml' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = true,
    -- TODO マージされた後version指定
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1000
    branch = 'main',
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
