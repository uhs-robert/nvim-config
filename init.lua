-- init.lua

-- Developer settings for local development
local ENABLE_LOCAL_DEV = true
local DEV_USER = "roberth"
local GITHUB_PATH = "/home/" .. DEV_USER .. "/Development"

--Returns the local development path for a plugin if it exists, otherwise nil for lazy.nvim remote fallback.
---@param name string plugin directory name (e.g. "oasis.nvim")
---@return string|nil
_G.local_plugin = function(name)
  if not ENABLE_LOCAL_DEV then return nil end

  local path = GITHUB_PATH .. "/" .. name
  return vim.fn.isdirectory(path) == 1 and path or nil
end

-- Vim settings
vim.g.mapleader = " "
vim.opt.path:append("**")

-- bootstrap lazy.nvim, LazyVim, and plugins
require("config.lazy")
