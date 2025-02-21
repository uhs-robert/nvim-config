local colors = require("tokyonight.colors").setup()
return {
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
      })
    end,
  },

  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      -- You don't need to set these options.
      require("colorful-menu").setup({})
    end,
  },

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
