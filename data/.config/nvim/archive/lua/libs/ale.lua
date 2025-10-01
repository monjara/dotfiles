return {
  'dense-analysis/ale',
  ft = { 'yaml' },
  config = function()
    local g = vim.g

    g.ale_ruby_rubocop_auto_correct_all = 1
    g.ale_linters = {
      lua = { 'lua_language_server' },
      cloudformation = { 'cfn-lint' },
    }
  end,
}
