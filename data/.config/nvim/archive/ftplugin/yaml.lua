if string.find(vim.fn.expand('%:t'), 'template.yaml') then
  vim.api.nvim_command('set filetype=yaml.cloudformation')
end
