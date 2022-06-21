-- packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
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
    config = function()
      vim.cmd [[set signcolumn=yes]]
    end
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
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
      vim.cmd [[colorscheme tokyonight]]
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use {
    'terryma/vim-multiple-cursors',
    config = function()
      vim.cmd([[
      let g:multi_cursor_use_default_mapping=0
      let g:multi_cursor_start_word_key      = '<C-n>'
      let g:multi_cursor_select_all_word_key = '<A-n>'
      let g:multi_cursor_start_key           = 'g<C-n>'
      let g:multi_cursor_select_all_key      = 'g<A-n>'
      let g:multi_cursor_next_key            = '<C-n>'
      let g:multi_cursor_prev_key            = '<C-p>'
      let g:multi_cursor_skip_key            = '<C-x>'
      let g:multi_cursor_quit_key            = '<Esc>'
      ]])
    end
  }

  use {
    'easymotion/vim-easymotion',
    config = function()
      vim.cmd([[
      let g:EasyMotion_do_mapping=0
      nnoremap [easyM] <Nop>
      nmap <Space>s [easyM]
      nmap s        <Plug>(easymotion-overwin-f)
      nmap [easyM]f <Plug>(easymotion-overwin-f2)
      nmap [easyM]l <Plug>(easymotion-overwin-line)
      nmap [easyM]w <Plug>(easymotion-overwin-w)
      autocmd FileType netrw nmap <buffer> s <Plug>(easymotion-s)
      ]])
    end
  }

  use {
    'kassio/neoterm',
    config = function()
      vim.cmd([[
        let &runtimepath.=$HOME.'/.config/nvim/plugged/neoterm'

        let g:neoterm_default_mod      = 'botright'
        let g:neoterm_keep_term_open   = 1
        let g:neoterm_autoinsert       = 0
        let g:neoterm_autojump         = 1

        nnoremap [term] <Nop>
        nmap <Space>t [term]
        nnoremap <silent> [term]t :<C-u> Ttoggle<CR>
        nnoremap <silent> [term]n :<C-u> Tnew<CR>
        nnoremap <silent> [term]r :<C-u> Tredo <CR>
        nnoremap <silent> [term]c :<C-u> Tclear <CR>
        nnoremap <silent> [term]d :<C-u> Tclose <CR>

        " TODO: use this function
        function! s:open_neoterm(cmd) abort
            let split = s:split_type()

            call execute(printf('%s %s', split, a:cmd))
        endfunction

        function! s:split_type() abort
            let width = winwidth(win_getid())
            let height = winheight(win_getid()) * 2.1

            if height > width
                let g:neoterm_size             = 10
                return 'bel'
            else
                let g:neoterm_size             = 50
                return 'vert'
            endif
        endfunction
      ]])
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
  use 'mattn/emmet-vim'
  use {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<space>rr', ':<C-u>T cargo run .<CR>', opts)
      vim.keymap.set('n', '<space>rt', ':<C-u>T cargo test<CR>', opts)
    end
  }

  use {
    'pantharshit00/vim-prisma',
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

  -- use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('lsp_config')
require('keymap')
require('opts')

-- nnoremap <silent><buffer><expr> C  defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
