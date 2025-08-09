-- User interface enhancements and visual improvements
-- Contains scrollbars, colorizers, statusline customizations, and UI polish plugins
local colors = require("tokyonight.colors").setup()
return {
  -- Scrollbar: Visual scrollbar with search and diagnostic markers
  -- Shows scroll position, search results, git changes, and LSP diagnostics in the gutter
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = colors.cyan,
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
        handlers = {
          gitsigns = true,
        },
      })
    end,
  },

  -- Colorful Menu: Enhanced completion menu with better visual distinction
  -- Improves the appearance of completion popups with color coding
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({})
    end,
  },

  -- Colorizer: Live color preview for CSS colors, hex codes, and color functions
  -- Shows background colors for hex codes, CSS colors, and color function calls
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        mode = "background",
        css = true,
        css_fn = true,
      },
    },
  },

  -- Mini HiPatterns: Pattern-based syntax highlighting (hex colors disabled)
  -- Provides additional syntax highlighting patterns, with hex color background disabled
  {
    "echasnovski/mini.hipatterns",
    config = function()
      require("mini.hipatterns").setup({
        highlighters = {
          hex_color = nil, -- This disables background hex coloring
        },
      })
    end,
  },

  -- Lualine: Enhanced statusline with time display and file manager integration
  -- Custom statusline showing time and clickable file path that opens Dolphin file manager
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
        lualine_z = {
          {
            function()
              return os.date("%I:%M:%S %p")
            end,
            icon = "󰥔",
          },
        },
      })
      if opts.sections and opts.sections.lualine_c then
        for _, section in ipairs(opts.sections.lualine_c) do
          section.on_click = function()
            local file_path = vim.fn.expand("%:p:h") -- Get file's directory
            vim.fn.jobstart({ "dolphin", file_path }, { detach = true }) -- Open Dolphin
          end
        end
      end
    end,
  },
}
