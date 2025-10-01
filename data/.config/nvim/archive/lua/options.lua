vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.shortmess = 'aoOTIcF'
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.showmatch = true
vim.opt.signcolumn = 'yes'
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.visualbell = true
vim.opt.splitright = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 0
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.virtualedit = 'onemore'
vim.opt.wildmode = 'list:longest'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.o.winborder = 'none'
vim.g.mapleader = ','

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopeFindPre',
  callback = function()
    vim.opt_local.winborder = 'none'
    vim.api.nvim_create_autocmd('WinLeave', {
      once = true,
      callback = function()
        vim.opt_local.winborder = 'rounded'
      end,
    })
  end,
})

vim.opt.laststatus = 0
vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })
local width = vim.api.nvim_win_get_width(0)
local line = string.rep('─', width)
vim.opt.statusline = line
vim.opt.statusline = line
