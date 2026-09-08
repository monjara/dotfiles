return {
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel' }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g["conjure#debug"] = true
    end,

    -- Optional cmp-conjure integration
    dependencies = { 'PaterJason/cmp-conjure' },
  },
  {
    'PaterJason/cmp-conjure',
    lazy = true,
    config = function()
      local cmp = require('cmp')
      local config = cmp.get_config()
      table.insert(config.sources, { name = 'conjure' })
      return cmp.setup(config)
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    ft = 'clojure',

    dependencies = {
      'PaterJason/cmp-conjure',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
    },

    config = function()
      local cmp = require('cmp')

      cmp.setup {
        sources = {
          { name = 'conjure' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        },
      }
    end,
  },
}
