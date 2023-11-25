for k, v in pairs({
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
  completeopt = { 'menu', 'menuone', 'noselect' }
}) do
  vim.opt[k] = v
end

for k, v in pairs({
  mapleader = ','
}) do
  vim.g[k] = v
end
