local M = {}

local function hex_to_rgb(hex)
  hex = hex:gsub('^#', '')
  if #hex ~= 6 then
    return nil
  end

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  if not r or not g or not b then
    return nil
  end

  return { r = r, g = g, b = b }
end

local function rgb_to_hex(color)
  return string.format('#%02x%02x%02x', color.r, color.g, color.b)
end

local function blend(foreground, background, alpha)
  local fg = hex_to_rgb(foreground)
  local bg = hex_to_rgb(background)
  if not fg or not bg then
    return nil
  end

  alpha = math.max(0, math.min(1, alpha))
  return rgb_to_hex {
    r = math.floor(fg.r * alpha + bg.r * (1 - alpha) + 0.5),
    g = math.floor(fg.g * alpha + bg.g * (1 - alpha) + 0.5),
    b = math.floor(fg.b * alpha + bg.b * (1 - alpha) + 0.5),
  }
end

local function hl_color(name, key)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  local color = hl[key]
  if type(color) ~= 'number' then
    return nil
  end

  return string.format('#%06x', color)
end

local function setup_diagnostic_line_highlights()
  local background = hl_color('Normal', 'bg')
  if not background then
    return
  end

  local diagnostic_groups = {
    DiagnosticErrorLine = 'DiagnosticError',
    DiagnosticWarnLine = 'DiagnosticWarn',
    DiagnosticInfoLine = 'DiagnosticInfo',
    DiagnosticHintLine = 'DiagnosticHint',
  }

  for line_group, diagnostic_group in pairs(diagnostic_groups) do
    local foreground = hl_color(diagnostic_group, 'fg')
    local line_background = foreground and blend(foreground, background, 0.15)
    if line_background then
      vim.api.nvim_set_hl(0, line_group, { bg = line_background })
    end
  end
end

M.init = function()
  vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_python3_provider = 0
  vim.g.mapleader = ','
  vim.g.terminal_emulator = 'fish'
  vim.opt.exrc = true
  vim.opt.autoread = true
  vim.opt.clipboard = 'unnamedplus'
  vim.opt.cmdheight = 0
  vim.opt.winbar = '%f'
  vim.opt.laststatus = 0
  vim.opt.signcolumn = 'yes:1'
  vim.opt.splitkeep = 'screen'
  vim.opt.termguicolors = true
  vim.opt.ignorecase = true
  vim.opt.winborder = 'rounded'

  vim.diagnostic.config {
    virtual_text = { current_line = true },
    signs = {
      linehl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticErrorLine',
        [vim.diagnostic.severity.WARN] = 'DiagnosticWarnLine',
        [vim.diagnostic.severity.INFO] = 'DiagnosticInfoLine',
        [vim.diagnostic.severity.HINT] = 'DiagnosticHintLine',
      },
    },
  }

  vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('diagnostic_line_highlights', { clear = true }),
    callback = setup_diagnostic_line_highlights,
  })
  setup_diagnostic_line_highlights()
end

return M
