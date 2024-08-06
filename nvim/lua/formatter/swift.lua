return {
  function()
    return {
      exe = 'swift',
      args = {
        'format',
        vim.fn.expand('%'),
        '-i',
      },
    }
  end,
}
