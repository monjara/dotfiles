return {
  'stevearc/conform.nvim',
  config = function()
    local make_js_formatter = function(bufnr)
      local root_has = function(files)
        return vim.fs.root(bufnr, files)
      end

      if root_has {
        'biome.json',
        'biome.jsonc',
      } then
        return { 'biome-check' }
      end

      if
        root_has {
          'prettier.config.js',
          'prettier.config.mjs',
          '.prettierrc',
          '.prettierrc.json',
        }
      then
        return { 'prettier' }
      end

      return {}
    end

    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = make_js_formatter,
        typescriptreact = make_js_formatter,
        javascript = make_js_formatter,
        javascriptreact = make_js_formatter,
        json = make_js_formatter,
        css = make_js_formatter,
        scss = make_js_formatter,
        html = make_js_formatter,
        yaml = make_js_formatter,
      },
    }
  end,
}
