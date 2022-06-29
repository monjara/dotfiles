local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>ff', "<cmd>lua  require('fzf-lua').files()<CR>", opts)
vim.keymap.set('n', '<space>fb', "<cmd>lua  require('fzf-lua').buffers()<CR>", opts)
vim.keymap.set('n', '<space>fm', "<cmd>lua  require('fzf-lua').marks()<CR>", opts)
vim.keymap.set('n', '<space>fr', "<cmd>lua  require('fzf-lua').grep()<CR>", opts)
vim.keymap.set('n', '<space>fp', "<cmd>lua  require('fzf-lua').registers()<CR>", opts)
vim.keymap.set('n', '<space>gs', "<cmd>lua  require('fzf-lua').git_status()<CR>", opts)
-- TODO add keymap
