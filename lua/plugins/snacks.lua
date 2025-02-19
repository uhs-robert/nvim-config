local header = [[
      ████ ██████           █████      ██    UpHill Solutions
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]

return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",

    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- lazy.nvim
  {
    "folke/snacks.nvim",
    opts = {
      ---@class snacks.dashboard.Config
      dashboard = {
        sections = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          { padding = 0, align = "center", text = { header, hl = "header" } },
          ---@diagnostic disable-next-line: assign-type-mismatch
          { padding = 2, align = "center", text = { "[ https://uphillsolutions.tech ]", hl = "BrandLink" } },
          --{ section = "terminal", align = "center", cmd = "curl -s 'wttr.in/?0'", indent = 20 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      lazygit = {
        theme = {
          [241] = { fg = "Special" },
          activeBorderColor = { fg = "lazyActiveBorder", bold = true },
          cherryPickedCommitBgColor = { fg = "lazyCherryBg" },
          cherryPickedCommitFgColor = { fg = "lazyCherryFg" },
          defaultFgColor = { fg = "Normal" },
          inactiveBorderColor = { fg = "FloatBorder" },
          optionsTextColor = { fg = "lazyOptionsText" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
          unstagedChangesColor = { fg = "lazyUnstagedChanges" },
        },
      },
    },
  },
}
