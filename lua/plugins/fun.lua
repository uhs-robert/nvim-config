-- Fun and recreational plugins
-- Contains games, typing practice, and entertainment features for Neovim
return {
  -- Typr: Typing speed test and practice game
  -- Built-in typing game with statistics tracking, commands: :Typr, :TyprStats
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  -- Player One: Sound effects for typing (currently disabled)
  -- Adds retro gaming sound effects to keystrokes with customizable themes
  -- {
  --   "jackplus-xyz/player-one.nvim",
  --   opts = {
  --     ---@type boolean Whether the sound theme is enabled
  --     is_enabled = false,
  --
  --     ---@type number Minimum interval between sounds in seconds
  --     ---Prevents sound overlapping and potential audio flooding when
  --     ---multiple keystrokes happen in rapid succession
  --     min_interval = 0.05,
  --
  --     ---Available presets: "chiptune", "crystal", "synth"
  --     theme = "chiptune",
  --   },
  -- },
}
