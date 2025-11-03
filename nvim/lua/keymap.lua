local M = {}

local function selection_has_diff()
  local gs = require('gitsigns')

  local a = vim.fn.line('v')
  local b = vim.fn.line('.')
  local start_line = math.min(a, b)
  local end_line = math.max(a, b)

  local hunks = gs.get_hunks(vim.api.nvim_get_current_buf())
  if not hunks then
    return false
  end

  for _, h in ipairs(hunks) do
    local h_start = h.add.start
    local h_end = h.add.start + h.add.count - 1

    if not (end_line < h_start or start_line > h_end) then
      return true
    end
  end

  return false
end

M.init = function()
  vim.keymap.set('i', 'jj', '<esc>', {})

  vim.keymap.set('n', '<space>rr', '<cmd>lua require("spectre").toggle()<cr>', {
    desc = 'Toggle Spectre',
  })
  vim.keymap.set('n', '<space>rw', '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', {
    desc = 'Search current word',
  })
  vim.keymap.set('n', '<space>rp', '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', {
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
  vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>', { desc = 'delete current buffer' })

  vim.keymap.set('n', '<space>fr', '<cmd>Pick grep_live<cr>', { desc = 'min.pick live grep' })
  vim.keymap.set('n', '<space>ff', '<cmd>Pick files<cr>', { desc = 'min.pick find file' })
  vim.keymap.set('n', '<space>fb', '<cmd>Pick buffers<cr>', { desc = 'min.pick find file' })

  vim.keymap.set('n', 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
  vim.keymap.set('n', 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })

  vim.keymap.set('v', '<leader>ga', function()
    require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
  end, { desc = 'Git add -p' })

  vim.keymap.set('n', '<leader>ga', function()
    require('gitsigns').stage_buffer()
  end, { desc = 'Git add current file' })

  vim.keymap.set('v', '<leader>gc', function()
    local diff = selection_has_diff()
    if not diff then
      vim.notify('No changes in selected range to commit', vim.log.levels.WARN)
      return
    end

    require('gitsigns').stage_hunk { vim.fn.line('.'), vim.fn.line('v') }

    vim.fn.inputsave()
    local msg = vim.fn.input('Commit message: ')
    vim.fn.inputrestore()

    if msg ~= '' then
      vim.system({ 'git', 'commit', '-m', msg }):wait()
      vim.notify('Committed selected range: ' .. msg)
    else
      vim.notify('Commit canceled')
    end
  end, { desc = 'git commit' })
end

return M
