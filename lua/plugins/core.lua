-- lua/plugins/core.lua

local UID = (vim.uv or vim.loop).getuid()
local IS_SUDOEDIT = vim.env.SUDOEDIT == "1"
local IS_ROOT = IS_SUDOEDIT or UID == 0

local get_startup_colorscheme = function()
  local cwd = vim.uv.cwd() or ""
  if IS_ROOT then return "oasis-scorpion" end
  if vim.startswith(cwd, vim.fs.normalize("~/mnt/")) then return "oasis-mirage" end

  return "oasis"
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = get_startup_colorscheme(),
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
}
