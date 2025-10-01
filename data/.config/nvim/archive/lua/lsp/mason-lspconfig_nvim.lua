return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    require('mason-lspconfig').setup {
      automatic_installation = true,
      ensure_installed = {
        'lua_ls',
      },
    }

    -- require('mason-lspconfig').setup_handlers {
    --   function(server_name)
    --     local skips = {
    --       ['rust_analyzer'] = true,
    --       ['lua_ls'] = true,
    --       ['swift_mesonls'] = true,
    --     }
    --
    --     if not skips[server_name] then
    --       require('lspconfig')[server_name].setup {}
    --     end
    --   end,
    -- }
  end,
}
