-- init.lua
-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.mapleader = " "
require("config.lazy")

vim.opt.path:append("**")
