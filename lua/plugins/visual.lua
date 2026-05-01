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
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({})
    end,
  },

  -- Highlight Colors: Live color preview for CSS colors, hex codes, and other color functions
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })
    end,
  },

  -- Mini HiPatterns: Pattern-based syntax highlighting (hex colors disabled)
  -- Provides additional syntax highlighting patterns, with hex color background disabled
  {
    "nvim-mini/mini.hipatterns",
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = nil, -- This disables background hex coloring
        },
      })
    end,
  },
}
