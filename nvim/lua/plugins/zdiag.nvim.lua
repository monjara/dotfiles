return {
  'monjara/zdiag.nvim',
  cmd = 'Zdiag',
  keys = {
    {
      '<space>b',
      '<cmd>Zdiag<cr>',
      desc = 'Open diagnostics view'
    },

    -- 以下はzdiagバッファ限定
    {
      '<C-space>',
      function()
        require('zdiag').jump_to_source({
          mode = 'buffer'
        })
      end,
      ft = 'zdiag',
      desc = 'Jump to source'
    },
    {
      'q',
      function()
        require('zdiag').close()
      end,
      ft = 'zdiag',
      desc = 'Close diagnostics view'
    },
    {
      'g]',
      function()
        require('zdiag').call(
          function()
            vim.diagnostic.jump {
              count = 1,
              float = true,
            }
          end
        )
      end,
      ft = 'zdiag',
      desc = 'Go to previous diagnostic message'
    },
    {
      'g[',
      function()
        require('zdiag').call(
          function()
            vim.diagnostic.jump {
              count = -1,
              float = true,
            }
          end
        )
      end,
      ft = 'zdiag',
      desc = 'Go to next diagnostic message',
    },

    {
      '<space>ca',
      function()
        require('zdiag').call(vim.lsp.buf.code_action)
      end,
      ft = 'zdiag',
      desc = 'LSP code action',
    },
    {
      'gD',
      function()
        require('zdiag').call(vim.lsp.buf.declaration)
      end,
      ft = 'zdiag',
      desc = 'LSP declaration',
    },
    {
      'gd',
      function()
        require('zdiag').call(vim.lsp.buf.definition)
      end,
      ft = 'zdiag',
      desc = 'LSP definition',
    },
    {
      'K',
      function()
        require('zdiag').call(vim.lsp.buf.hover)
      end,
      ft = 'zdiag',
      desc = 'LSP hover',
    },
    {
      'gi',
      function()
        require('zdiag').call(vim.lsp.buf.implementation)
      end,
      ft = 'zdiag',
      desc = 'LSP implementation',
    },
    {
      'gl',
      function()
        require('zdiag').call(
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        )
      end,
      ft = 'zdiag',
      desc = 'Toggle LSP inlay hints',
    },
    {
      '<C-k>',
      function()
        require('zdiag').call(vim.lsp.buf.signature_help)
      end,
      ft = 'zdiag',
      desc = 'LSP signature help',
    },
    {
      '<space>wa',
      function()
        require('zdiag').call(vim.lsp.buf.add_workspace_folder)
      end,
      ft = 'zdiag',
      desc = 'LSP add workspace folder',
    },
    {
      '<space>wr',
      function()
        require('zdiag').call(vim.lsp.buf.remove_workspace_folder)()
      end,
      ft = 'zdiag',
      desc = 'LSP remove workspace folder',
    },
    {
      'gt',
      function()
        require('zdiag').call(vim.lsp.buf.type_definition)
      end,
      ft = 'zdiag',
      desc = 'LSP type definition',
    },
    {
      '<space>rn',
      function()
        require('zdiag').call(vim.lsp.buf.rename)
      end,
      ft = 'zdiag',
      desc = 'LSP rename',
    },
    {
      'gr',
      function()
        require('zdiag').call(vim.lsp.buf.references)
      end,
      ft = 'zdiag',
      desc = 'LSP references',
    },
    {
      '<space>ef',
      function()
        require('zdiag').call(vim.diagnostic.open_float)
      end,
      ft = 'zdiag',
      desc = 'Open floating diagnostic message',
    },
  },
  config = function(_, opts)
    require('zdiag').setup(opts)
  end,
}
