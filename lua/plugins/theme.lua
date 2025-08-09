-- Neon Dark Theme: Professional dark theme with vibrant neon accent colors
-- Modular plugin structure based on VSCode with custom enhancements

return {
  --VSCode base theme dependency
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load our custom neon-dark theme
      require("neon-dark").setup()
    end,
  },
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
