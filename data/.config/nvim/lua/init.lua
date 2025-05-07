require('options')
require('keymaps')
require('commands')
-- vim.api.nvim_create_autocmd({ 'TabEnter' }, {
--   command = 'tcd %:h',
-- })
-- vim.api.nvim_create_augroup('neotree', {})
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, {
--   group = 'neotree',
--   callback = function()
--     if vim.fn.argc() == 0 then
--       vim.cmd('Neotree toggle')
--     end
--   end,
-- })
--
--

vim.lsp.enable { 'biome', 'taplo' }

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
