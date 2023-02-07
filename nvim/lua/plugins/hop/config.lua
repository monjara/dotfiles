local api = vim.api

require 'hop'.setup { keys = 'jfkdurghalsieownvmcxypq' }

api.nvim_set_keymap('', 's', ':HopChar1MW<CR>', {})
api.nvim_set_keymap('', '<space>ss', ':HopChar1MW<CR>', {})
api.nvim_set_keymap('', '<space>sw', ':HopChar1BC<CR>', {})
api.nvim_set_keymap('', '<space>sd', ':HopChar1AC<CR>', {})

api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = { 'neo-tree' },
    callback = function()
      vim.api.nvim_set_keymap('n', 's', ':HopChar1<CR>', {})
    end
})
