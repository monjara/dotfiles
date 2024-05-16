return {
  function()
    print('ssss')
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
