local utils = {}

function utils.is_mac()
  return vim.fn.has('darwin') == 1
end

function utils.is_linux()
  return vim.fn.has('linux') == 1
end

function utils.get_separator()
  return '/'
end

function utils.join_paths(...)
  local separator = utils.get_separator()
  return table.concat({ ... }, separator)
end

function utils.get_home()
  return os.getenv('HOME')
end

function utils.get_config()
  return vim.fn.stdpath('config')
end

function utils.get_init_lua()
  return utils.get_config() .. '/init.lua'
end

function utils.create_custome_command(name, command, opts)
  vim.api.nvim_create_user_command(name, function()
    vim.api.nvim_command(command)
  end, opts)
end

function utils.keymap_set(tbl, opt)
  local o = opt or { noremap = true, silent = true }

  for _, v in ipairs(tbl) do
    vim.keymap.set(v[1], v[2], v[3], o)
  end
end

function utils.is_filetye(buf, ...)
  local result = false
  for _, v in ipairs { ... } do
    local r = vim.bo[buf].filetype == v
    if r then
      result = true
      break
    end
  end
  return result
end

return utils
