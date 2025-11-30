-- lua/plugins/core.lua
local is_root = vim.loop and vim.loop.getuid and vim.loop.getuid() == 0
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = is_root and "oasis-sol" or "oasis",
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
}
