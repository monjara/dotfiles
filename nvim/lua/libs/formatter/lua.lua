return {
  require('formatter.filetypes.lua').stylua,
  function()
    local util = require('formatter.util')
    if util.get_current_buffer_file_name() == 'special.lua' then
      return nil
    end

    return {
      exe = 'stylua',
      args = {
        '--indent-type=Spaces',
        '--indent-width=2',
        '--quote-style=AutoPreferSingle',
        '--call-parentheses=NoSingleTable',
        '--search-parent-directories',
        '--stdin-filepath',
        util.escape_path(util.get_current_buffer_file_path()),
        '--',
        '-',
      },
      stdin = true,
    }
  end,
}
