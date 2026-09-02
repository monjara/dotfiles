return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
      callback = function()
        require('lualine').refresh()
      end,
    })

    require('lualine').setup {
      sections = {
        lualine_a = {
          {
            'mode',

            fmt = function(mode)
              local reg = vim.fn.reg_recording()

              if reg ~= '' then
                return 'RECORDING @' .. reg
              end

              return mode
            end,

            separator = { right = '' },

            color = function()
              if vim.fn.reg_recording() ~= '' then
                return {
                  fg = '#282c34',
                  bg = '#e06c75',
                  gui = 'bold',
                }
              end
            end,
          },
        },

        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
        },
      },
    }
  end,
}
