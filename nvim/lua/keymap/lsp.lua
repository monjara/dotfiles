vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP implementation' })
vim.keymap.set('n', 'gl', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle LSP inlay hints' })
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
