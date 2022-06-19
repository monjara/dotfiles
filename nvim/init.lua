-- packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
   vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'leico/autodate.vim'
  use 'simeji/winresizer'
  use 'tpope/vim-surround'
  use 'vim-jp/vimdoc-ja'
  -- use {'Shougo/defx.nvim', run = ':UpdateRemotePlugins',}

  use {
    'airblade/vim-gitgutter',
    config = function()
      vim.cmd[[set signcolumn=yes]]
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
      vim.cmd[[colorscheme tokyonight]]
    end
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

  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n',  '<space>ff',  "<cmd>lua  require('fzf-lua').files()<CR>",       opts)
      vim.keymap.set('n',  '<space>fb',  "<cmd>lua  require('fzf-lua').buffers()<CR>",     opts)
      vim.keymap.set('n',  '<space>fm',  "<cmd>lua  require('fzf-lua').marks()<CR>",       opts)
      vim.keymap.set('n',  '<space>fr',  "<cmd>lua  require('fzf-lua').grep()<CR>",        opts)
      vim.keymap.set('n',  '<space>gs',  "<cmd>lua  require('fzf-lua').git_status()<CR>",  opts)
      -- TODO add keymap
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = { theme  = 'nightfly' },
      }
    end,
  }

-- TODO: lazy
  use 'mattn/emmet-vim'
  use {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>rr', ':<C-u>T cargo run .<CR>')
      vim.keymap.set('n', '<space>rt', ':<C-u>T cargo test<CR>')
    end
  }
  use {
   'pantharshit00/vim-prisma',
   ft = 'prisma'
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'

  if packer_bootstrap then
     require('packer').sync()
  end
end)

-- lsp-installer
require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- lspconfig
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['pyright'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
})
require('lspconfig')['tsserver'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
})
require('lspconfig')['rust_analyzer'].setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {}
    }
})

-- nvim-cmp
vim.cmd[[set completeopt=menu,menuone,noselect]]
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

-- defx.nvim
-- vim.cmd([[
-- nnoremap <silent> <Space>dd :<C-u> Defx <CR>
-- nnoremap <silent> <Space>dc :<C-u> Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')` <CR>
--
-- autocmd FileType defx call s:defx_my_settings()
-- function! s:defx_my_settings() abort
--   nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
--   nnoremap <silent><buffer><expr> c  defx#do_action('copy')
--   nnoremap <silent><buffer><expr> m  defx#do_action('move')
--   nnoremap <silent><buffer><expr> p  defx#do_action('paste')
--   nnoremap <silent><buffer><expr> l  defx#do_action('open')
--   nnoremap <silent><buffer><expr> E  defx#do_action('open', 'vsplit')
--   nnoremap <silent><buffer><expr> T  defx#do_action('open', 'tabnew')
--   nnoremap <silent><buffer><expr> P  defx#do_action('preview')
--   nnoremap <silent><buffer><expr> o  defx#do_action('open_tree', 'toggle')
--   nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
--   nnoremap <silent><buffer><expr> N  defx#do_action('new_file')
--   nnoremap <silent><buffer><expr> M  defx#do_action('new_multiple_files')
--   nnoremap <silent><buffer><expr> C  defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
--   nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'time')
--   nnoremap <silent><buffer><expr> d  defx#do_action('remove')
--   nnoremap <silent><buffer><expr> r  defx#do_action('rename')
--   nnoremap <silent><buffer><expr> !  defx#do_action('execute_command')
--   nnoremap <silent><buffer><expr> x  defx#do_action('execute_system')
--   nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
--   nnoremap <silent><buffer><expr> .  defx#do_action('toggle_ignored_files')
--   nnoremap <silent><buffer><expr> ;  defx#do_action('repeat')
--   nnoremap <silent><buffer><expr> h  defx#do_action('cd', ['..'])
--   nnoremap <silent><buffer><expr> ~  defx#do_action('cd')
--   nnoremap <silent><buffer><expr> q  defx#do_action('quit')
--   nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
--   nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
--   nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
--   nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
--   nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
--   nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
--   nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
-- endfunction
--
-- function! s:open_defx_if_directory()
--   try
--     let l:full_path = expand(expand('%:p'))
--   catch
--     return
--   endtry
--
--   if isdirectory(l:full_path)
--     execute "Defx `expand('%:p')` | bd " . expand('%:r')
--   endif
-- endfunction
--
-- augroup defx_config
--   autocmd!
--   autocmd FileType defx call s:defx_my_settings()
--
--   autocmd BufEnter * call s:open_defx_if_directory()
--   autocmd BufWritePost * call defx#redraw()
--   autocmd BufEnter * call defx#redraw()
-- augroup END
-- ]])

vim.g.mapleader = ","
vim.api.nvim_set_keymap("n",  "<space>",    "",                {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  [[\]],        ",",               {noremap  =  false,  silent  =  false})
vim.api.nvim_set_keymap("n",  "j",          "gj",              {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "k",          "gk",              {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "gj",         "j",               {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "gk",         "k",               {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "<Leader>n",  ":<C-u>nohl<CR>",  {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "<Leader>o",  ":<C-u>only<CR>",  {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "ZZ",         "",                {noremap  =  true,   silent  =  false})
vim.api.nvim_set_keymap("n",  "ZQ",         "",                {noremap  =  true,   silent  =  false})

vim.api.nvim_set_keymap("i",  "jj",         "<ESC>",           {noremap  =  true,   silent  =  true})
vim.api.nvim_set_keymap("t",  "<A-i>",      [[<C-\><C-n>]],    {noremap  =  true,   silent  =  true})

vim.opt.number = true
vim.opt.fenc = 'utf-8'
vim.opt.encoding='utf-8'
vim.opt.ignorecase=true
vim.opt.wildignorecase=true
vim.opt.hidden=true
vim.opt.showcmd=true
vim.opt.autoread=true
vim.opt.backup=false
vim.opt.showmatch=true
vim.opt.swapfile =false
vim.opt.cursorline=true
vim.opt.visualbell=true
vim.opt.splitright=true
vim.opt.cmdheight=2
vim.opt.laststatus=2
vim.opt.writebackup=false
vim.opt.updatetime=300
vim.opt.virtualedit='onemore'
vim.opt.wildmode='list:longest'

vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')

vim.opt.autoindent=true          -- 改行時に前の行のインデントを計測
vim.opt.smartindent=true         -- "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
vim.opt.cindent=true             -- "Cプログラムファイルの自動インデントを始める
vim.opt.smarttab=true            -- "新しい行を作った時に高度な自動インデントを行う
vim.opt.expandtab=true           -- "タブ入力を複数の空白に置き換える

vim.opt.tabstop=2                -- "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
vim.opt.shiftwidth=2             -- "自動インデントで入る空白数
vim.opt.softtabstop=0            -- "キーボードから入るタブの数

if vim.fn.has("autocmd") == 1 then
vim.cmd([[
autocmd FileType javascript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescript       setlocal sw=2 sts=2 ts=2 et
autocmd FileType javascriptreact  setlocal sw=2 sts=2 ts=2 et
autocmd FileType typescriptreact  setlocal sw=2 sts=2 ts=2 et
]])
end

vim.cmd([[

filetype off
filetype plugin indent on

command! -nargs=0 VV :tabnew $MYVIMRC
" source vim setting file
command! -nargs=0 SV :source ~/.config/nvim/init.lua
" open help vertical split
command! -nargs=1 -complete=help H :vertical belowright help <args>

]])

