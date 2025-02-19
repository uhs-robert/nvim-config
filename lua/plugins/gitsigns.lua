return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" }, -- Line added
          change = { text = "~" }, -- Line changed
          delete = { text = "-" }, -- Line deleted
          topdelete = { text = "‾" }, -- Top line deleted
          changedelete = { text = "*" }, -- Line changed then deleted
        },
        current_line_blame = true, -- Show blame info inline
      })
    end,
  },
}
