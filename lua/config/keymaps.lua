-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local
-- Change directory to the active file
vim.keymap.set("n", "<leader>cd", function()
  vim.cmd("cd %:p:h")
  local cwd = vim.fn.getcwd()
  vim.notify(
    "Changed directory to:\n" .. cwd,
    vim.log.levels.INFO,
    { title = "Directory Changed", timeout = 5000, max_width = 200 }
  )
end, { noremap = true, silent = true, desc = "Change directory to open file" })

-- Open the current file in the file explorer
vim.keymap.set(
  "n",
  "<leader>fo",
  ":!dolphin %:p:h<CR>",
  { noremap = true, silent = true, desc = "Open in file explorer" }
)

-- Save file without auto-formatting
vim.keymap.set(
  "n",
  "<leader>fs",
  ":noautocmd w<CR>",
  { noremap = true, silent = true, desc = "Save file (no formatting)" }
)

--Return to Snacks Dashboard
vim.keymap.set("n", "<leader>0", function()
  if vim.bo.filetype == "snacks_dashboard" then
    vim.notify("Hey, you're already here! Welcome home 󰟒", vim.log.levels.INFO, { title = "Dashboard" })
  else
    pcall(function()
      require("snacks").dashboard.open()
    end)
  end
end, { desc = "Home Tab" })

-- Github Clone Repository
vim.keymap.set("n", "<leader>gC", function()
  local default_clone_dir = "~/Documents/github-uphill/"
  local url = vim.fn.input("Git Repository URL: ")
  local path = vim.fn.input(string.format("Clone to Directory (default: %s): ", default_clone_dir))

  -- Use the default directory if none provided
  if path == "" then
    local repo_name = url:match(".*/(.*).git$") or "repo"
    path = vim.fn.expand(default_clone_dir .. "/" .. repo_name)
  else
    path = vim.fn.expand(path)
  end

  if url ~= "" then
    local result = vim.fn.system({ "git", "clone", url, path })
    if vim.v.shell_error == 0 then
      -- Try to cd into the actual repo directory
      local repo_folder = path .. "/" .. (url:match(".*/(.*).git$") or "repo")
      if vim.fn.isdirectory(repo_folder) == 1 then
        vim.cmd("cd " .. repo_folder)
        vim.notify("✅ Cloned and changed directory to: " .. repo_folder, vim.log.levels.INFO)
      else
        vim.cmd("cd " .. path)
        vim.notify("✅ Cloned and changed directory to: " .. path, vim.log.levels.INFO)
      end
    else
      vim.notify("❌ Error cloning repository:\n" .. result, vim.log.levels.ERROR)
    end
  end
end, { desc = "Clone Git Repository" })

--Inc-Rename
vim.keymap.set("n", "<leader>rn", ":IncRename", { desc = "Rename (from scratch)" })
vim.keymap.set("n", "<leader>rN", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "Rename (from word)" })

--Telescope (Hidden Files)
vim.keymap.set(
  "n",
  "<leader>fh",
  ":Telescope find_files hidden=true<CR>",
  { noremap = true, silent = true, desc = "Find Files (Hidden)" }
)

--Snacks Explorer
---Find visible files
vim.keymap.set("n", "<leader>e", function()
  require("snacks.explorer").open({ hidden = false, cwd = LazyVim.root() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (root)" })
vim.keymap.set("n", "<leader>E", function()
  require("snacks.explorer").open({ hidden = false, cwd = vim.fn.getcwd() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (cwd)" })
---Find hidden files
vim.keymap.set("n", "<leader>fe", function()
  require("snacks.explorer").open({ hidden = true, cwd = LazyVim.root() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (root -hidden)" })
vim.keymap.set("n", "<leader>fE", function()
  require("snacks.explorer").open({ hidden = true, cwd = vim.fn.getcwd() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (cwd -hidden)" })

--Navigate vim panes better
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
