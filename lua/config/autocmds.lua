-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start terminal in insert mode
local api = vim.api
local termGrp = api.nvim_create_augroup("terminal", { clear = true })
api.nvim_create_autocmd("TermOpen", {
  group = termGrp,
  pattern = "*",
  command = "startinsert",
})

-- ephemeral windows close with q
api.nvim_create_autocmd("FileType", {
  pattern = { "aerial-nav", "help", "startuptime", "qf", "lspinfo" },
  callback = function()
    vim.keymap.set("n", "<Esc>", ":close<CR>", { buffer = true, silent = true })
  end,
})
api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.keymap.set("n", "<Esc>", ":quit<CR>", { buffer = true, silent = true })
  end,
})
