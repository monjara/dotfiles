local M = {}

M.init = function()
  vim.g.mapleader = ','
  vim.g.terminal_emulator = 'zsh'
  vim.opt.autoread = true
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.cmdheight = 0
  vim.opt.laststatus = 0
  vim.opt.signcolumn = 'yes:1'
  vim.opt.splitkeep = 'screen'
  vim.opt.termguicolors = true
  vim.opt.ignorecase = true
  vim.opt.winborder = 'rounded'

  vim.diagnostic.config {
    virtual_text = { current_line = true },
  }
end

return M
