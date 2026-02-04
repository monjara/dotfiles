return {
  'nvim-mini/mini.animate',
  version = false,
  config = function()
    require 'mini.animate'.setup {
      cursor = {
        -- Animate for 100 milliseconds with linear easing
        timing = require('mini.animate').gen_timing.linear { duration = 100, unit = 'total' },
      },
      scroll = {
        -- Animate for 150 milliseconds with linear easing
        timing = require('mini.animate').gen_timing.linear { duration = 150, unit = 'total' },
      },
    }
  end
}
