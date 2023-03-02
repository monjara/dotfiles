local utils = {}

utils.get_separator = function()
  return '/'
end

utils.join_paths = function(...)
  local separator = utils.get_separator()
  return table.concat({ ... }, separator)
end

utils.is_not_vscode = function()
  return vim.g.vscode == nil
end

utils.is_mac = function()
  return vim.fn.has('darwin') == 1
end

utils.is_linux = function()
  return vim.fn.has('linux') == 1
end

return utils
