-- Neon Dark Theme - Highlight Groups
-- All highlight group definitions for the neon-dark theme

local M = {}

function M.setup(colors)
  local c = colors

  -- Basic highlight group overrides
  M.group_overrides = {
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

  -- Extended theme highlights
  M.extended_highlights = {
    -- Dashboard
    SnacksDashboardHeader = { fg = c.vscMediumBlue, bg = c.none },
    SnacksDashboardTitle = { fg = c.vscMediumBlue, bg = c.none, bold = true },
    SnacksDashboardDesc = { fg = c.vscBlueGreen, bg = c.none },
    SnacksDashboardFile = { fg = c.vscBlue, bg = c.none },
    BrandLink = { fg = c.vscBlueGreen, bg = c.none },
    SnacksDashboardFooter = { fg = c.vscBlue, bg = c.none },
    SnacksDashboardKey = { fg = c.vscOrange, bg = c.none },

    -- Lazy
    LazyButton = { fg = c.vscFront, bg = "#0979C9", bold = true },
    LazyH1 = { fg = c.vscFront, bg = c.vscGreen, bold = true },

    -- Git
    Added = { fg = c.neonGreen, bg = c.none },
    Changed = { fg = c.neonBlue, bg = c.none },
    Removed = { fg = c.neonRed, bg = c.none },

    -- Diagnostics
    DiagnosticError = { fg = c.neonRed, bg = c.none },
    DiagnosticWarn = { fg = c.vscDarkYellow, bg = c.none },
    DiagnosticInfo = { fg = c.vscBlue, bg = c.none },

    -- LazyGit via snacks.lua
    lazyActiveBorder = { fg = "#23d18b" },
    lazyCherryBg = { fg = "#3b8eea" },
    lazyCherryFg = { fg = "#f5f543" },
    lazyOptionsText = { fg = "#3b8eea" },
    lazyUnstagedChanges = { fg = "#ff5555" },

    -- Render Markdown Headings (color-coded)
    MarkdownHeadlineH1 = { bg = "#1c3d5a", fg = "#4FC1FF", bold = true }, -- Neon Blue
    MarkdownHeadlineH2 = { bg = "#5a3e22", fg = "#FF8C42", bold = true }, -- Neon Orange
    MarkdownHeadlineH3 = { bg = "#665c1e", fg = "#FFD700", bold = true }, -- Bright Gold
    MarkdownHeadlineH4 = { bg = "#234c3a", fg = "#39FF14", bold = true }, -- Neon Green
    MarkdownHeadlineH5 = { bg = "#274e54", fg = "#00FFFF", bold = true }, -- Neon Cyan
    MarkdownHeadlineH6 = { bg = "#4e2a4e", fg = "#FF10F0", bold = true }, -- Neon Pink
  }

  return M
end

return M