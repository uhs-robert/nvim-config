-- lua/plugins/core.lua

local uid = (vim.uv or vim.loop).getuid()
local is_root = uid == 0
local is_remote = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_TTY ~= nil
local is_sudoedit = (not is_root) and vim.env.SUDOEDIT == "1"

local function pick_colorscheme()
  local is_elevated = is_root or is_sudoedit
  if is_remote then
    return is_elevated and "oasis-abyss" or "oasis-mirage"
  else
    return is_elevated and "oasis-sol" or "oasis"
  end
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oasis",
      -- colorscheme = pick_colorscheme(),
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
}
