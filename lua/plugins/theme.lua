--https://github.com/Mofiqul/vscode.nvim
---@diagnostic disable: undefined-global

-- Define colors and overrides
local color_overrides = {
  vscFront = "#D4D4D4",
  vscBack = "#000000",
  vscCursorDarkDark = "#000000",
  vscTabCurrent = "#000000",
  vscTabOther = "#1F1F1F",
  vscTabOutside = "#FFFFFF",
  vscPopupBack = "#080808",
  vscSplitDark = "#084671",
  vscSelection = "#264F78",
}
local palette = {
  none = "NONE",
  vscLineNumber = "#5A5A5A",
  -- Syntax colors
  vscGray = "#808080",
  vscViolet = "#646695",
  vscBlue = "#569CD6",
  vscAccentBlue = "#4FC1FF",
  vscDarkBlue = "#223E55",
  vscMediumBlue = "#18a2fe",
  vscDisabledBlue = "#729DB3",
  vscLightBlue = "#9CDCFE",
  vscGreen = "#6A9955",
  vscBlueGreen = "#4EC9B0",
  vscLightGreen = "#B5CEA8",
  vscRed = "#F44747",
  vscOrange = "#CE9178",
  vscLightRed = "#D16969",
  vscYellowOrange = "#D7BA7D",
  vscYellow = "#DCDCAA",
  vscDarkYellow = "#FFD602",
  vscPink = "#C586C0",
  -- UI colors
  vscUiBlue = "#084671",
  vscUiOrange = "#f28b25",
  vscPopupHighlightLightBlue = "#d7eafe",
  neonGreen = "#39FF14",
  neonBlue = "#1F51FF",
  neonRed = "#FF073A",
  neonYellow = "#FFFF33",
  neonOrange = "#FF5F1F",
  neonPurple = "#B026FF",
  neonPink = "#FF10F0",
  neonCyan = "#0FF0FC",
}
local c = vim.tbl_extend("force", palette, color_overrides)

-- Define group overrides
local group_overrides = {
  Normal = { fg = c.vscFront, bg = c.none },
  Concel = { fg = c.vscFront, bg = c.none },
  Directory = { fg = c.vscMediumBlue, bg = c.none },
  LineNR = { fg = c.vscLineNumber, bg = c.none },
  VertSplit = { fg = c.vscSplitDark, bg = c.none },
  Delimiter = { fg = c.vscSplitDark, bg = c.none },
  FloatTitle = { fg = c.vscFront, bg = c.vscPopupBack },

  -- Git Signs
  GitSignsAdd = { fg = c.neonGreen, bg = "None" },
  GitSignsChange = { fg = c.neonBlue, bg = "None" },
  GitSignsDelete = { fg = c.neonRed, bg = "None" },
  GitSignsAddLn = { fg = c.vscBack, bg = c.neonGreen },
  GitSignsChangeLn = { fg = c.vscBack, bg = c.neonBlue },
  GitSignsDeleteLn = { fg = c.vscBack, bg = c.neonRed },
}

-- Define custom highlights
local extendTheme = {
  SnacksDashboardHeader = { fg = c.vscMediumBlue, bg = c.none },
  SnacksDashboardTitle = { fg = c.vscMediumBlue, bg = c.none, bold = true },
  SnacksDashboardDesc = { fg = c.vscBlueGreen, bg = c.none },
  SnacksDashboardFile = { fg = c.vscBlue, bg = c.none },
  BrandLink = { fg = c.vscBlueGreen, bg = c.none },
  SnacksDashboardFooter = { fg = c.vscBlue, bg = c.none },
  SnacksDashboardKey = { fg = c.vscOrange, bg = c.none },
  LazyButton = { fg = c.vscFront, bg = "#0979C9", bold = true },
  LazyH1 = { fg = c.vscFront, bg = c.vscGreen, bold = true },
  Added = { fg = c.neonGreen, bg = c.none },
  Changed = { fg = c.neonBlue, bg = c.none },
  Removed = { fg = c.neonRed, bg = c.none },
  DiagnosticError = { fg = c.neonRed, bg = c.none },
  DiagnosticWarn = { fg = c.vscDarkYellow, bg = c.none },
  DiagnosticInfo = { fg = c.vscBlue, bg = c.none },

  --LazyGit via snacks.lua
  lazyActiveBorder = { fg = "#23d18b" },
  lazyCherryBg = { fg = "#3b8eea" },
  lazyCherryFg = { fg = "#f5f543" },
  -- defaultFgColor = { fg = "Normal" },
  -- FloatBorder = { fg = "FloatBorder" },
  lazyOptionsText = { fg = "#3b8eea" },
  --lazySearchingBorder = { fg = "lazySearchingBorder", bold = true },
  --lazySelectedLine = { bg = "lazySelectedLine" },
  lazyUnstagedChanges = { fg = "#ff5555" },

  -- Render Markdown Heading Backgrounds (color-coded)
  Headline1Bg = { bg = c.neonBlue, fg = c.vscFront, bold = true }, -- Blue
  Headline2Bg = { bg = c.vscUiOrange, fg = c.vscBack, bold = true }, -- Orange
  Headline3Bg = { bg = c.vscDarkYellow, fg = c.vscBack, bold = true }, -- Yellow
  Headline4Bg = { bg = c.neonGreen, fg = c.vscBack, bold = true }, -- Green
  Headline5Bg = { bg = c.neonCyan, fg = c.vscBack, bold = true }, -- Cyan
  Headline6Bg = { bg = c.neonPink, fg = c.vscBack, bold = true }, -- Pink
}

-- Custom terminal colors
local terminal_colors = false
local set_terminal_colors = function()
  vim.g.terminal_color_0 = "#000000" -- Black
  vim.g.terminal_color_8 = "#555555" -- Bright Black

  vim.g.terminal_color_1 = "#ff5555" -- Red
  vim.g.terminal_color_9 = "#ff3333" -- Bright Red

  vim.g.terminal_color_2 = "#23d18b" -- Green
  vim.g.terminal_color_10 = "#0dbc79" -- Bright Green

  vim.g.terminal_color_3 = "#f5f543" -- Yellow
  vim.g.terminal_color_11 = "#e5e510" -- Bright Yellow

  vim.g.terminal_color_4 = "#3b8eea" -- Blue
  vim.g.terminal_color_12 = "#1f66cc" -- Bright Blue

  vim.g.terminal_color_5 = "#d670d6" -- Magenta
  vim.g.terminal_color_13 = "#bc3fbc" -- Bright Magenta

  vim.g.terminal_color_6 = "#29b8db" -- Cyan
  vim.g.terminal_color_14 = "#11a8cd" -- Bright Cyan

  vim.g.terminal_color_7 = "#e5e5e5" -- White
  vim.g.terminal_color_15 = "#ffffff" -- Bright White
end

return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000, -- Ensures it loads first
    config = function()
      -- Load the theme
      require("vscode").setup({
        style = "dark", -- Options: "dark" or "light"
        transparent = false, -- Keeps a solid background
        italic_comments = true,
        disable_nvimtree_bg = true, -- Remove background color in NvimTree
        color_overrides = color_overrides,
        group_overrides = group_overrides,
        terminal_colors = terminal_colors,
      })

      -- Set the theme
      vim.cmd("colorscheme vscode")

      -- Load the custom highlights
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          for group, val in pairs(extendTheme) do
            vim.api.nvim_set_hl(0, group, val)
          end
        end,
      })
      -- Load custom terminal colors
      if not terminal_colors then
        set_terminal_colors()
      end
    end,
  },
}
