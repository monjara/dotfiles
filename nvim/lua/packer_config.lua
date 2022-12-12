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

  if vim.fn.has('linux') == 1 then
    use {
      'folke/tokyonight.nvim',
      setup = function()
        require('plugins.tokyonight.setup')
      end,
      config = function()
        require('plugins.tokyonight.config')
      end
    }
  end

  use {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {}
    end
  }

  use {
    'dsznajder/vscode-es7-javascript-react-snippets',
    run = 'yarn install --frozen-lockfile && yarn compile'
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
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
    end
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
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.fzf.config')
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
    'simrat39/rust-tools.nvim',
    opt = true,
    ft = 'rust',
    config = function()
      local rt = require("rust-tools")

      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      })
    end
  }

  -- Debugging
  use 'mfussenegger/nvim-dap'

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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
