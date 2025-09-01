-- lua/plugins/coding.lua
-- Code manipulation and formatting tools
-- Contains plugins for joining/splitting code structures, text alignment, and syntax enhancement
return {

  -- TreeSJ: Smart join/split tool for code structures using treesitter
  -- Toggle between single-line and multi-line code blocks (arrays, objects, function parameters)
  -- {
  --   "Wansmer/treesj",
  --   keys = {
  --     { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
  --   },
  --   opts = { use_default_keymaps = false, max_join_length = 150 },
  -- },

  -- Mini.align: Text alignment tool with customizable delimiters
  -- Aligns text around characters like =, :, |, etc. with 'ga' and 'gA' keymaps
  {
    "echasnovski/mini.align",
    opts = {},
    keys = {
      { "ga", mode = { "n", "v" } },
      { "gA", mode = { "n", "v" } },
    },
  },

  -- Treesitter Endwise: Automatically adds 'end' statements for various languages
  -- Smart completion for Ruby, Lua, Bash, and other languages that use end keywords
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
