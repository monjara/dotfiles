return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<space>xl', '<cmd>XcodebuildToggleLogs<cr>', desc = 'Toggle Xcodebuild Logs', mode = 'n' },
    { '<space>xb', '<cmd>XcodebuildBuild<cr>', desc = 'Build Project', mode = 'n' },
    { '<space>xr', '<cmd>XcodebuildBuildRun<cr>', desc = 'Build & Run Project', mode = 'n' },
    { '<space>xt', '<cmd>XcodebuildTest<cr>', desc = 'Run Tests', mode = 'n' },
    { '<space>xT', '<cmd>XcodebuildTestClass<cr>', desc = 'Run This Test Class', mode = 'n' },
    { '<space>X', '<cmd>XcodebuildPicker<cr>', desc = 'Show All Xcodebuild Actions', mode = 'n' },
    { '<space>xd', '<cmd>XcodebuildSelectDevice<cr>', desc = 'Select Device', mode = 'n' },
    { '<space>xp', '<cmd>XcodebuildSelectTestPlan<cr>', desc = 'Select Test Plan', mode = 'n' },
    { '<space>xq', '<cmd>Telescope quickfix<cr>', desc = 'Show QuickFix List', mode = 'n' },
  },
  config = function()
    require('xcodebuild').setup {}
  end,
}
