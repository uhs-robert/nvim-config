-- init.lua

-- Set home regardless of user
vim.g.user_home = "/home/roberth"
vim.g.github = vim.g.user_home .. "/Documents/github-uphill"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.path:append("**")
