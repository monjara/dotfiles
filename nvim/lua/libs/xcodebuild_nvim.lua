return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('xcodebuild').setup({
      -- put some options here or leave it empty to use default settings
    })

    vim.keymap.set('n', '<space>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
    vim.keymap.set('n', '<space>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
    vim.keymap.set('n', '<space>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
    vim.keymap.set('n', '<space>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
    vim.keymap.set('n', '<space>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run This Test Class' })
    vim.keymap.set('n', '<space>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All Xcodebuild Actions' })
    vim.keymap.set('n', '<space>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
    vim.keymap.set('n', '<space>xp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test Plan' })
    vim.keymap.set('n', '<space>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
  end,
}
