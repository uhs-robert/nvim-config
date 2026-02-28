-- lua/plugins/filetypes.lua
-- Filetype-specific plugins and language support
-- Contains plugins that add syntax highlighting, indentation, and features for specific file types
return {
  {
    "elkowar/yuck.vim",
    ft = { "yuck" },
    -- Ensure it loads for the 'yuck' filetype
  },
  {
    "tridactyl/vim-tridactyl",
  },
}
