return {

  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = "markdown",
  --
  --   dependencies = {
  --     -- You may not need this if you don't lazy load
  --     -- Or if the parsers are in your $RUNTIMEPATH
  --     "nvim-treesitter/nvim-treesitter",
  --
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("no-neck-pain").setup({
        width = 150,
        autocmds = {
          enableOnVimEnter = false,
          skipEnteringNoNeckPainBuffer = true,
        },
      })
    end,
  },

  {
    "anuvyklack/pretty-fold.nvim",
  },

  {
    "chrisgrieser/nvim-spider",
    event = "ModeChanged",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "x", "o" } },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "x", "o" } },
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "x", "o" } },
    },
    opts = {
      skipInsignificantPunctuation = false,
    },
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "InsertEnter",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
}
