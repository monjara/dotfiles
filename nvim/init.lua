-- dein start
local home_dir = os.getenv("HOME")
local dein_dir = home_dir .. "/.config/nvim/dein"
local dein_repo_dir = home_dir .. "/.cache/dein/repos/github.com/Shougo/dein.vim"

if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
  os.execute("git clone --depth=1 https://github.com/Shougo/dein.vim " .. dein_repo_dir)
end

vim.opt.runtimepath:append(home_dir .. '/.cache/dein/repos/github.com/Shougo/dein.vim')

if vim.fn['dein#load_state'](dein_dir) then
  vim.api.nvim_set_var('dein#lazy_rplugins', 1)
  vim.api.nvim_set_var('dein#enable_notification', 1)
  vim.api.nvim_set_var('dein#install_max_processes', 16)
  vim.api.nvim_set_var('dein#install_message_type', 'none')
  vim.api.nvim_set_var('dein#enable_notification', 1)
--  vim.api.nvim_set_var('dein#auto_recache', 1)

  local cache_dir = home_dir .. '/.cache/dein'
  local toml_dir  = home_dir .. '/.config/nvim/dein/toml'
  local toml      = toml_dir .. '/dein.toml'
  local lazy_toml = toml_dir .. '/dein_lazy.toml'
  local plug_dir  = toml_dir .. '/plugins'

  vim.fn['dein#begin'](cache_dir)

  vim.fn['dein#load_toml'](toml, {lazy = 0})
  vim.fn['dein#load_toml'](lazy_toml, {lazy = 1})
  vim.fn['dein#load_toml'](plug_dir .. '/defx.toml',        {lazy = 0})
  vim.fn['dein#load_toml'](plug_dir .. '/neoterm.toml',     {lazy = 0})
  vim.fn['dein#load_toml'](plug_dir .. '/fzf.toml',         {lazy = 0})
  vim.fn['dein#load_toml'](plug_dir .. '/easy-motion.toml', {lazy = 0})

  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
	vim.cmd([[autocmd VimEnter * call dein#call_hook('post_source')]])
end

vim.cmd([[
filetype plugin indent on
syntax enable
]])

if vim.fn['dein#check_install']() then
  vim.fn['dein#install']()
end
-- dein end

vim.cmd[[colorscheme tokyonight]]

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

