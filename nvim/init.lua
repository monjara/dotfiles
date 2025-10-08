require('setup_rocks')

vim.cmd([[colorscheme tokyonight-night]])

vim.g.mapleader = ','
vim.opt.termguicolors = true
vim.opt.laststatus = 0
vim.opt.clipboard = 'unnamedplus'
vim.opt.signcolumn = 'yes:3'

vim.diagnostic.config {
  virtual_text = { current_line = true },
}

vim.keymap.set('i', 'jj', '<esc>', {})

vim.keymap.set('n', '<C-p>', function()
  require('fff').find_files()
end, { desc = 'FFFind files' })

vim.keymap.set('n', '<space>ff', function()
  require('fff').find_files()
end, { desc = 'FFFind files' })

vim.keymap.set('n', '<space>rr', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<space>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<space>rp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})

vim.keymap.set({ 'n', 'v' }, 's', '<cmd>HopChar1<cr>', { desc = 'hop char 1' })
vim.keymap.set('n', '<space>dd', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>ri', ':Rocks install ', { desc = 'Rocks install' })
vim.keymap.set('n', '<leader>sc', '<cmd>source ~/.config/nvim/init.lua<cr>', { desc = 'source init.lua' })
vim.keymap.set('n', '<leader>sv', '<cmd>source ~/.config/nvim/init.lua<cr>', { desc = 'source init.lua' })

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP signature help' })
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP add workspace folder' })
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP remove workspace folder' })
vim.keymap.set('n', '<space>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = 'LSP list workspace folders' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP type definition' })
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = 'LSP rename' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP references' })
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = 'LSP code action' })
vim.keymap.set('n', '<space>ef', vim.diagnostic.open_float, {
  desc = 'Open floating diagnostic message',
})
vim.keymap.set('n', 'g[', function()
  vim.diagnostic.jump {
    count = 1,
    float = true,
  }
end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'g]', function()
  vim.diagnostic.jump {
    count = -1,
    float = true,
  }
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '<space>el', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>fo', function()
  vim.lsp.buf.format { async = true }
end, { desc = 'Format current buffer with LSP' })

vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bprevious<cr>', { desc = 'previous buffer' })

vim.keymap.set(
  'n',
  '<space>fr',
  function()
    require('grug-far').open({
      engine = 'astgrep',
    })
  end,
  { desc = 'Grug Far' }
)

vim.lsp.enable { 'lua_ls', 'jsonls', 'taplo' }
