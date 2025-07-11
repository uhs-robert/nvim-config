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

-- Add the relative file path from nearest git root to code files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function(args)
    local bufnr = args.buf
    local filepath = args.file

    -- Get Git root
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not git_root or git_root == "" then
      return
    end

    -- Compute relative path and comment
    local relpath = filepath:gsub("^" .. git_root .. "/", "")
    local comment = "// " .. relpath

    -- Check if it's already the first line
    local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
    if first_line == comment then
      return
    end

    -- Insert at the top
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, { comment })
  end,
})
