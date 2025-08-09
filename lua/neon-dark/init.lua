-- Neon Dark Theme - Main Plugin Entry Point
-- Professional dark theme with vibrant neon accent colors
-- Based on VSCode with custom enhancements

local M = {}

function M.setup()
  local colors_module = require("neon-dark.colors")
  local highlights_module = require("neon-dark.highlights")
  local terminal_module = require("neon-dark.terminal")

  local colors = colors_module.colors
  local color_overrides = colors_module.color_overrides
  local highlights = highlights_module.setup(colors)

  -- Setup VSCode theme with our customizations
  require("vscode").setup({
    style = "dark",
    transparent = false,
    italic_comments = true,
    disable_nvimtree_bg = true,
    color_overrides = color_overrides,
    group_overrides = highlights.group_overrides,
    terminal_colors = false, -- We handle terminal colors separately
  })

  -- Set the colorscheme
  vim.cmd("colorscheme vscode")

  -- Apply extended highlights after colorscheme loads
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      for group, val in pairs(highlights.extended_highlights) do
        vim.api.nvim_set_hl(0, group, val)
      end
    end,
  })

  -- Setup custom terminal colors
  terminal_module.setup()
end

return M