-- Neon Dark Theme - Color Definitions
-- Professional dark theme with vibrant neon accent colors

local M = {}

-- Base VSCode color overrides
M.color_overrides = {
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

-- Extended color palette
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
  -- Neon accent colors
  neonGreen = "#39FF14",
  neonBlue = "#1F51FF",
  neonRed = "#FF073A",
  neonYellow = "#FFFF33",
  neonOrange = "#FF5F1F",
  neonPurple = "#B026FF",
  neonPink = "#FF10F0",
  neonCyan = "#0FF0FC",
}

-- Merge base overrides with extended palette
M.colors = vim.tbl_extend("force", palette, M.color_overrides)

return M