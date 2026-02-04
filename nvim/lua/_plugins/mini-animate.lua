local animate = require('mini.animate')
animate.setup {
  cursor = {
    -- Animate for 100 milliseconds with linear easing
    timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
  },
  scroll = {
    -- Animate for 150 milliseconds with linear easing
    timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
  },
}
