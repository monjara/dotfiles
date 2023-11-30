return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  enabled = function ()
    return vim.bo.filetype == 'swift'
  end,
  config = function()
    local lint = require('lint')

    local pattern = '[^:]+:(%d+):(%d+): (%w+): (.+)'
    local groups = { 'lnum', 'col', 'severity', 'message' }
    local defaults = { ['source'] = 'swiftlint' }
    local severity_map = {
      ['error'] = vim.diagnostic.severity.ERROR,
      ['warning'] = vim.diagnostic.severity.WARN,
    }

    local swiftlintConfigs =
        vim.fn.systemlist({ 'find', vim.fn.getcwd(), '-iname', '.swiftlint.yml', '-not', '-path', '*/.*/*' })

    table.sort(swiftlintConfigs, function(a, b)
      return a ~= '' and #a < #b
    end)

    local selectedSwiftlintConfig
    if swiftlintConfigs[1] then
      selectedSwiftlintConfig = string.match(swiftlintConfigs[1], '^%s*(.-)%s*$')
    end

    lint.linters.swiftlint = {
      cmd = 'swiftlint',
      stdin = false,
      args = {
        'lint',
        '--force-exclude',
        '--use-alternative-excluding',
        '--config',
        selectedSwiftlintConfig or os.getenv('HOME') .. '/.config/nvim/.swiftlint.yml', -- change path if needed
      },
      stream = 'stdout',
      ignore_exitcode = true,
      parser = require('lint.parser').from_pattern(pattern, groups, severity_map, defaults),
    }

    -- setup
    lint.linters_by_ft = {
      swift = { 'swiftlint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })

    vim.keymap.set('n', '<leader>xl', function()
      require('lint').try_lint()
    end, { desc = 'Lint file' })
  end
}
