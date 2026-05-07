local M = {}

M.init = function()
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_python3_provider = 0
  vim.g.mapleader = ','
  vim.g.terminal_emulator = 'fish'
  vim.opt.autoread = true
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.cmdheight = 0
  vim.opt.winbar = "%f"
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
