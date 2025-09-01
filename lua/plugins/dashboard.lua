-- lua/plugins/dashboard.lua
local header = [[
      ████ ██████           █████      ██    UpHill Solutions
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]]

-- Dashboard configuration and startup screen customization
-- Contains Snacks.nvim dashboard setup with UpHill Solutions branding and custom theming
return {
  -- Snacks: Multi-purpose UI and utility plugin with dashboard and word highlighting
  -- Custom dashboard with UpHill Solutions branding and enhanced word navigation
  {
    "folke/snacks.nvim",
    opts = {
      ---@class snacks.dashboard.Config
      dashboard = {
        sections = {
          ---@diagnostic disable-next-line: assign-type-mismatch
          { padding = 0, align = "center", text = { header, hl = "header" } },
          ---@diagnostic disable-next-line: assign-type-mismatch
          { padding = 2, align = "center", text = { "[ https://uphillsolutions.tech ]", hl = "Identifier" } },
          --{ section = "terminal", align = "center", cmd = "curl -s 'wttr.in/?0'", indent = 20 },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      words = { enabled = true },
    },
  },
}
