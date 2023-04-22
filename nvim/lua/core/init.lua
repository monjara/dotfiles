local utils = require('utils')

local function load_options()
  local options = {
    fenc = 'utf-8',
    encoding = 'utf-8',
    shortmess = 'aoOTIcF',
    ignorecase = true,
    wildignorecase = true,
    hidden = true,
    showcmd = true,
    autoread = true,
    backup = false,
    clipboard = 'unnamedplus',
    showmatch = true,
    signcolumn = 'yes',
    swapfile = false,
    cursorline = true,
    visualbell = true,
    splitright = true,
    cmdheight = 0,
    laststatus = 0,
    writebackup = false,
    updatetime = 300,
    virtualedit = 'onemore',
    wildmode = 'list:longest',
    autoindent = true,
    smartindent = true,
    cindent = true,
    smarttab = true,
    expandtab = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 0,
  }

  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

local function load_globals()
  local globals = {
    python3_host_prog = utils.join_paths(utils.get_home(), '.anyenv/envs/pyenv/shims/python'),
    mapleader = ','
  }

  for k, v in pairs(globals) do
    vim.g[k] = v
  end
end

load_options()
load_globals()
