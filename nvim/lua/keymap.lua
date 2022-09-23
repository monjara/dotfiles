vim.g.mapleader = ","
vim.api.nvim_set_keymap("n", "<space>", "", { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<space>", "", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", [[\]], ",", { noremap = false, silent = false })
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "gj", "j", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "gk", "k", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<Leader>n", ":<C-u>nohl<CR>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<Leader>o", ":<C-u>only<CR>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "ZZ", "", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "ZQ", "", { noremap = true, silent = false })

vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<A-i>", [[<C-\><C-n>]], { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<space>yf",
  function()
    vim.api.nvim_command('let @" = expand("%:p")')
    vim.api.nvim_command('let @+ = expand("%:p")')
  end
)

vim.keymap.set(
  "n",
  "<space>yd",
  function()
    vim.api.nvim_command('let @" = expand("%:p:h")')
    vim.api.nvim_command('let @+ = expand("%:p:h")')
  end
)

vim.api.nvim_create_autocmd({ 'TabEnter' }, {
  command = 'tcd %:h'
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { 'neo-tree' },
  callback = function()
    vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotino-s)", { noremap = false, silent = false })
  end
})

vim.cmd([[
command! -nargs=0 VV :tabnew $MYVIMRC | :tcd %:h
command! -nargs=0 SV :source ~/.config/nvim/init.lua
command! -nargs=1 -complete=help H :vertical belowright help <args>
]])

