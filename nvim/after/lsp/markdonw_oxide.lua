local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

return {
  cmd = { 'markdown-oxide' },
  filetypes = { 'markdown' },
  root_markers = { '.git', '.obsidian', '.moxide.toml' },
  capabilities = capabilities,
}
