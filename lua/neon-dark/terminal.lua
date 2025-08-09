-- Neon Dark Theme - Terminal Colors
-- Custom terminal color configuration

local M = {}

function M.setup()
  vim.g.terminal_color_0 = "#000000" -- Black
  vim.g.terminal_color_8 = "#555555" -- Bright Black

  vim.g.terminal_color_1 = "#ff5555" -- Red
  vim.g.terminal_color_9 = "#ff3333" -- Bright Red

  vim.g.terminal_color_2 = "#23d18b" -- Green
  vim.g.terminal_color_10 = "#0dbc79" -- Bright Green

  vim.g.terminal_color_3 = "#f5f543" -- Yellow
  vim.g.terminal_color_11 = "#e5e510" -- Bright Yellow

  vim.g.terminal_color_4 = "#3b8eea" -- Blue
  vim.g.terminal_color_12 = "#1f66cc" -- Bright Blue

  vim.g.terminal_color_5 = "#d670d6" -- Magenta
  vim.g.terminal_color_13 = "#bc3fbc" -- Bright Magenta

  vim.g.terminal_color_6 = "#29b8db" -- Cyan
  vim.g.terminal_color_14 = "#11a8cd" -- Bright Cyan

  vim.g.terminal_color_7 = "#e5e5e5" -- White
  vim.g.terminal_color_15 = "#ffffff" -- Bright White
end

return M