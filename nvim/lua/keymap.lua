vim.g.mapleader = ","
vim.api.nvim_set_keymap("n", "<space>", "", { noremap = true, silent = false })
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

vim.api.nvim_set_keymap("n", "<space>dd", ":<C-u>Explore<CR>", {noremap = true, silent = true})

vim.cmd([[
command! -nargs=0 VV :tabnew $MYVIMRC | :tcd %:h
command! -nargs=0 SV :source ~/.config/nvim/init.lua
command! -nargs=1 -complete=help H :vertical belowright help <args>

autocmd FileType netrw nmap <buffer> s <Plug>(easymotion-s)
autocmd FileType netrw nmap <buffer><nowait> ; <CR>
autocmd TabEnter * :tcd %:h
]])

