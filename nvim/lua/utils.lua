local utils = {}

utils.is_not_vscode = vim.g.vscode == nil
utils.is_mac = vim.fn.has('darwin') == 1
utils.is_linux = vim.fn.has('linux') == 1

utils.get_separator = function()
  return '/'
end

utils.join_paths = function(...)
  local separator = utils.get_separator()
  return table.concat({ ... }, separator)
end

utils.get_home = function()
  return os.getenv('HOME')
end

local function get_config_dir()
  return vim.fn.stdpath('config')
end

utils.get_config = function()
  return get_config_dir()
end

utils.get_init_lua = function()
  return get_config_dir() .. '/init.lua'
end

utils.create_custome_command = function(name, command, opts)
  vim.api.nvim_create_user_command(
    name,
    function()
      vim.api.nvim_command(command)
    end,
    opts
  )
end

return utils
