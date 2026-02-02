-- lua/config/autocmds.lua
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

-- Quick Fix `dd` to delete items
api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  desc = "Attach keymaps for quickfix list",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local qf_list = vim.fn.getqflist()

      local current_line_number = vim.fn.line(".")

      if qf_list[current_line_number] then
        table.remove(qf_list, current_line_number)

        vim.fn.setqflist(qf_list, "r")

        local new_line_number = math.min(current_line_number, #qf_list)
        vim.fn.cursor(new_line_number, 1)
      end
    end, {
      buffer = true,
      noremap = true,
      silent = true,
      desc = "Remove quickfix item under cursor",
    })
  end,
})

-- Hyprlang LSP
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
