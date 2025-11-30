-- lua/plugins/theme.lua
-- Themes and thematic elements
-- Contains colorschemes, status lines, and elements which use themes

return {
  -- -- Melange
  -- { "savq/melange-nvim" },
  --
  -- -- Nightfox
  -- { "EdenEast/nightfox.nvim" },
  --
  -- -- kanagawa
  -- { "rebelot/kanagawa.nvim" },

  -- Oasis
  {
    -- "uhs-robert/oasis.nvim",
    dir = "/home/roberth/Documents/github-uphill/oasis.nvim/",
    lazy = false,
    priority = 1000,
    config = function()
      require("oasis").setup({
        dark_style = "lagoon",
        light_style = "desert",
        -- themed_syntax = false,
        -- use_legacy_comments = true,
        -- styles = {
        --   italic = false,
        --   underline = false,
        --   undercurl = false,
        --   bold = false,
        --   strikethrough = false,
        -- },
        -- terminal_colors = false,
        -- transparent = true,
      })
      -- require("oasis").setup()
    end,
  },

  -- All Your Base
  {
    -- "uhs-robert/allyourbase.nvim",
    dir = "/home/roberth/Documents/github-uphill/allyourbase.nvim/",
    lazy = false,
    priority = 1000,
    config = function()
      require("allyourbase").setup({
        colors = {
          color0 = "#101825",
        },
      })
    end,
  },

  -- Lush
  -- {
  --   "rktjmp/lush.nvim",
  -- },
  -- {
  --   "rktjmp/shipwright.nvim",
  -- },

  -- Lualine: Enhanced statusline with time display and file manager integration
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "oasis"
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

  -- Tabby: Enhanced tab viewer with slanted element design and which-key binds
  {
    "nanozuki/tabby.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- always show tabline; sessions will restore tab pages + names
      vim.o.showtabline = 2
      vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
    end,
    ---@type TabbyConfig
    opts = {
      preset = "active_wins_at_tail",
      option = {
        nerdfont = true,
        buf_name = { mode = "unique" },
        -- lualine_theme = "auto",
      },
    },
    config = function(_, opts)
      require("tabby").setup(opts)
      local map = vim.keymap.set
      local optsn = { silent = true, noremap = true }

      -- next / prev tab
      map("n", "<leader><tab>h", ":tabp<CR>", vim.tbl_extend("force", optsn, { desc = "Prev tab" }))

      -- close (delete)
      map("n", "<leader><tab>d", ":tabclose<CR>", vim.tbl_extend("force", optsn, { desc = "Delete tab" }))

      -- move next / prev
      map("n", "<leader><tab>L", ":+tabmove<CR>", vim.tbl_extend("force", optsn, { desc = "Move tab right" }))
      map("n", "<leader><tab>H", ":-tabmove<CR>", vim.tbl_extend("force", optsn, { desc = "Move tab left" }))

      -- pick window (Tabby)
      map("n", "<leader><tab>w", ":Tabby pick_window<CR>", vim.tbl_extend("force", optsn, { desc = "Pick tab window" }))

      -- jump mode (Tabby) on f
      map("n", "<leader><tab>j", ":Tabby jump_to_tab<CR>", vim.tbl_extend("force", optsn, { desc = "Jump to tab" }))
    end,
  },
}
