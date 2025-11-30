-- lua/plugins/utility.lua

return {
  -- Emoji lookup (great for markdown and readme work)
  {
    "allaman/emoji.nvim",
    -- ft = "markdown", -- adjust to your needs
    dependencies = {
      -- util for handling paths
      "nvim-lua/plenary.nvim",
      -- -- optional for nvim-cmp integration
      -- "hrsh7th/nvim-cmp",
      -- -- optional for telescope integration
      -- "nvim-telescope/telescope.nvim",
      -- optional for fzf-lua integration via vim.ui.select
      "ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      -- enable_cmp_integration = true,
      -- optional if your plugin installation directory
      -- is not vim.fn.stdpath("data") .. "/lazy/
      -- plugin_path = vim.fn.expand("$HOME/plugins/"),
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      -- optional for telescope integration
      -- local ts = require("telescope").load_extension("emoji")
      -- vim.keymap.set("n", "<leader>se", ts.emoji, { desc = "[S]earch [E]moji" })
    end,
  },
  {
    "NTBBloodbath/color-converter.nvim",
    opts = {},
    config = function(_, opts)
      local cc = require("color-converter")
      cc.setup(opts)
      vim.keymap.set("n", "<leader>rC", cc.cycle, { desc = "Cycle hex/rgb/hsl color" })
    end,
  },
  {
    -- "uhs-robert/comment-filename.nvim",
    dir = "/home/roberth/Documents/github-uphill/comment-filename.nvim/",
    opts = {
      enabled = true,
      filetypes = {
        html = true, -- careful with this one
      },
    },
    config = function(_, opts)
      require("comment_filename").setup(opts)
      vim.keymap.set("n", "<leader>uy", "<cmd>CommentFilenameToggle<cr>", { desc = "Toggle Comment Filename (Global)" })
      vim.keymap.set(
        "n",
        "<leader>uY",
        "<cmd>CommentFilenameBufferToggle<cr>",
        { desc = "Toggle Comment Filename (Buffer)" }
      )
    end,
  },
}
