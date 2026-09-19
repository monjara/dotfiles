vim.api.nvim_create_user_command('Notify', function(opts)
  vim.system({ vim.o.shell, vim.o.shellcmdflag, opts.args }, { text = true }, function(result)
    vim.schedule(function()
      local output = result.stdout

      if result.stderr ~= '' then
        output = output .. result.stderr
      end

      if not output or output == '' then
        output = 'No output'
      end

      vim.notify(vim.trim(output), result.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR, {
        title = '$ ' .. opts.args,
      })
    end)
  end)
end, {
  nargs = '+',
  complete = 'shellcmd',
})

vim.keymap.set('c', '<C-l>', '<CR>')
