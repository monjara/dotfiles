local utils = require('utils')

require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    }
  }
})
require('mason-lspconfig').setup({
  automatic_installation = true,
  ensure_installed = {
    'lua_ls',
  }
})

local nvim_lsp = require 'lspconfig'

local lsp_flags = {
  debounce_text_changes = 150,
}

-- lua
nvim_lsp.lua_ls.setup {
  flags = lsp_flags,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      format = {
        enable = true,
        defaultConfig = {
          insert_final_newline = false,
          indent_size = 2,
          indent_style = 'space',
        }
      }
    }
  }
}

-- rust
local rt = require('rust-tools')
rt.setup {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      ['rust_analyzer'] = {
        checkOnSave = {
          command = 'clippy',
        },
      }
    }
  }
}

-- kotlin
nvim_lsp.kotlin_language_server.setup {
  flags = lsp_flags
}

-- ts
nvim_lsp.tsserver.setup {
  flags = lsp_flags
}

-- vue
nvim_lsp.volar.setup {
  flags = lsp_flags
}

-- css
nvim_lsp.cssls.setup {
  flags = lsp_flags
}

nvim_lsp.eslint.setup {
  flags = lsp_flags
}

-- go
nvim_lsp.gopls.setup {
  flags = lsp_flags
}


-- terraform
nvim_lsp.terraformls.setup {
  flags = lsp_flags
}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end
})

nvim_lsp.docker_compose_language_service.setup {
  flags = lsp_flags
}

nvim_lsp.dockerls.setup {
  flags = lsp_flags
}


-- swift
if vim.fn.has('mac') == 1 then
  nvim_lsp.sourcekit.setup {
    flags = lsp_flags,
    cmd = {
      "/Applications/Xcode-15.1_beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
    },
    root_dir = function(filename, _)
      return require('lspconfig').util.find_git_ancestor(filename)
    end,
  }
end

-- sh
nvim_lsp.bashls.setup {
  flags = lsp_flags
}

-- lspconfig
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd(
  'LspAttach',
  {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(e)
      vim.bo[e.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local maps = {
        { 'n',          'gD',         vim.lsp.buf.declaration },
        { 'n',          'gd',         vim.lsp.buf.definition },
        { 'n',          'K',          vim.lsp.buf.hover },
        { 'n',          'gi',         vim.lsp.buf.implementation },
        { 'n',          '<C-k>',      vim.lsp.buf.signature_help },
        { 'n',          '<space>wa',  vim.lsp.buf.add_workspace_folder },
        { 'n',          '<space>wr',  vim.lsp.buf.remove_workspace_folder },
        { 'n',          '<space>wl',  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
        { 'n',          '<space>D',   vim.lsp.buf.type_definition },
        { 'n',          '<Space>rn',  vim.lsp.buf.rename },
        { { 'n', 'v' }, '<space>ca',  vim.lsp.buf.code_action },
        { 'n',          'gr',         vim.lsp.buf.references },
        { 'n',          '<leader>fo', function() vim.lsp.buf.format { async = true } end }
      }

      local o = { buffer = e.buf, noremap = true, silent = true }
      utils.keymap_set(maps, o)
    end
  }
)
