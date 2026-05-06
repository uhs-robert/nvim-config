-- lua/plugins/visual.lua
-- Visual enhancements and appearance customization
-- Contains scrollbars, colorizers, and visual polish plugins

return {

  -- Colorful Menu: Enhanced completion menu with better visual distinction
  -- Improves the appearance of completion popups with color coding
  {
    "xzbdmw/colorful-menu.nvim",
    lazy = true,
    event = "InsertEnter",
    opts = {},
  },

  -- Highlight Colors: Live color preview for CSS colors, hex codes, and other color functions
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    opts = {
      render = "background",
      enable_tailwind = true,
    },
  },

  -- Mini HiPatterns: Pattern-based syntax highlighting (hex colors disabled)
  -- Provides additional syntax highlighting patterns, with hex color background disabled
  {
    "nvim-mini/mini.hipatterns",
    lazy = true,
    event = "BufReadPost",
    opts = {
      highlighters = {
        hex_color = nil, -- This disables background hex coloring
      },
    },
  },
}
