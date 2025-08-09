return {

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "uhs-robert/sshfs.nvim",
    opts = {
      ui = {
        file_picker = {
          preferred_picker = "yazi",
        },
      },
    },
  },

  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
  },

  -- {
  --   "RRethy/nvim-treesitter-endwise",
  --   event = "BufEnter",
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       endwise = {
  --         enable = true,
  --       },
  --     })
  --   end,
  -- },
}
