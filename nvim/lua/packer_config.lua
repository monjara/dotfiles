local utils = require('utils')

-- packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = utils.join_paths(fn.stdpath('data'), 'site/pack/packer/start/packer.nvim')
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd.packadd 'packer.nvim'
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer = require('packer')

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'leico/autodate.vim'
  use 'simeji/winresizer'
  use 'tpope/vim-surround'
  use 'vim-jp/vimdoc-ja'

  use {
    'airblade/vim-gitgutter',
    cond = utils.is_not_vscode,
    setup = function()
      vim.opt.signcolumn = 'yes'
    end
  }

  use {
    'folke/tokyonight.nvim',
    cond = { utils.is_not_vscode, utils.is_linux },
    setup = function()
    end,
    config = function()
      require('tokyonight').setup {
        style = 'night',
        light_style = 'night'
      }
      vim.cmd [[colorscheme tokyonight]]
    end
  }

  use {
    'rafamadriz/neon',
    cond = { utils.is_not_vscode, utils.is_mac },
    setup = function()
      require('plugins.neon.setup')
    end,
    config = function()
      require('plugins.neon.config')
    end
  }

  use {
    'folke/zen-mode.nvim',
    cond = utils.is_not_vscode,
    config = function()
      require('zen-mode').setup {}
    end
  }

  use {
    'dsznajder/vscode-es7-javascript-react-snippets',
    cond = utils.is_not_vscode,
    ft = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    run = 'yarn install --frozen-lockfile && yarn compile'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      require('plugins.hop.config')
    end
  }

  use {
    'kassio/neoterm',
    opt = true,
    cond = utils.is_not_vscode,
    event = { 'BufEnter' },
    setup = function()
      require('plugins.neoterm.setup')
    end,
    config = function()
      require('plugins.neoterm.config')
    end
  }

  use {
    'ibhagwan/fzf-lua',
    cond = utils.is_not_vscode,
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.fzf.config')
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    cond = utils.is_not_vscode,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme = 'nightfly' },
      }
    end,
  }

  use {
    'mattn/emmet-vim',
    cond = utils.is_not_vscode,
    opt = true,
    event = { 'BufEnter' },
  }


  -- Debugging

  use {
    'pantharshit00/vim-prisma',
    opt = true,
    ft = 'prisma'
  }

  use 'neovim/nvim-lspconfig'
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'


  use 'mfussenegger/nvim-dap'

  use {
    'simrat39/rust-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('plugins.neotree.config')
    end,
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
