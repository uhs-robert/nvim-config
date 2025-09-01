-- theme.lua
-- lua/plugins/theme.lua
-- Neon Dark Theme: Professional dark theme with vibrant neon accent colors
-- Modular plugin structure based on VSCode with custom enhancements

return {
  -- --VSCode base theme dependency
  -- {
  --   "Mofiqul/vscode.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Load our custom neon-dark theme
  --     -- require("neon-dark").setup()
  --   end,
  -- },
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000, -- Ensure it loads first
  -- },

  -- Lush theme creator
  {
    "rktjmp/lush.nvim",
    -- if you wish to use your own colorscheme:
    {
      dir = "~/Documents/github-uphill/oasis.nvim/",
      lazy = false,
      priority = 1000,
      config = function()
        vim.cmd("colorscheme oasis-lagoon")
      end,
    },
  },
  {
    "rktjmp/shipwright.nvim",
  },
  -- { "EdenEast/nightfox.nvim" },
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
        lualine_theme = "auto",
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
  -- { "rebelot/kanagawa.nvim", },
  -- {
  --   "uhs-robert/oasis.nvim",
  --   requires = { "rktjmp/lush.nvim" },
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("oasis").apply()
  --   end,
  -- },
  -- -- Or with configuration
  -- {
  --   "projekt0n/github-nvim-theme",
  --   name = "github-theme",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("github-theme").setup({
  --       -- ...
  --     })
  --
  --     vim.cmd("colorscheme github_dark")
  --   end,
  -- },
  -- {
  --   "uhs-robert/neon-dark.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("neon-dark").setup()
  --     vim.cmd([[colorscheme neon-dark]])
  --   end,
  -- },
}
