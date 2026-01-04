-- lua/config/keymaps.lua
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local
local wk = require("which-key")
local keymap = vim.keymap

-- disable keymaps
keymap.del("n", "<leader><tab>l")
keymap.del("n", "<leader><tab>]")
keymap.del("n", "<leader><tab>[")

-- Tab Settings
keymap.set("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- Movement adjustments
keymap.set({ "n", "v" }, "H", "^", { desc = "Go to beginning of line" })
keymap.set({ "n", "v" }, "L", "$g_", { desc = "Go to end of line" })
-- keymap.set("n", "J", "30j zz", { desc = "Move down by n spaces" })
-- keymap.set("n", "K", "30k zz", { desc = "Move down by n spaces" })

-- % Modifications
keymap.set("n", "mm", "%") -- Jump to matching pair
keymap.set("x", "m", "%") -- Select to matching pair
keymap.set("o", "m", "%") -- Delete until matching pair

-- Visual mode paste without overwriting the unnamed register
keymap.set("x", "p", '"_dP', { desc = "Paste without replacing register" })

-- Fixes for missing icons in which-key
wk.add({
  { "<leader>a", desc = "ai", icon = { icon = "", color = "blue", h1 = "WhichKey" } },
  { "<leader>o", desc = "overseer", icon = { icon = "󱢇", color = "red", h1 = "WhichKey" } },
  { "<leader>y", desc = "yazi", icon = { icon = "󰇥", color = "green", h1 = "WhichKey" } },
  { "<leader>K", desc = "Open Man Page", icon = { icon = "", color = "cyan", h1 = "WhichKey" } },
  -- { "<leader>U", desc = "UFO Undo", icon = { icon = "󱃄", color = "green", h1 = "WhichKey" } },
})

-- Change directory to the active file
keymap.set("n", "<leader>cd", function()
  vim.cmd("cd %:p:h")
  local cwd = vim.fn.getcwd()
  vim.notify(
    "Changed directory to:\n" .. cwd,
    vim.log.levels.INFO,
    { title = "Directory Changed", timeout = 5000, max_width = 200 }
  )
end, { noremap = true, silent = true, desc = "Change directory to open file" })

-- Open the current file in the file explorer
keymap.set(
  "n",
  "<leader>fo",
  "<cmd>:!dolphin %:p:h<cr>",
  { noremap = true, silent = true, desc = "Open in file explorer" }
)

-- Save file without auto-formatting
keymap.set(
  "n",
  "<leader>fs",
  "<cmd>noautocmd w<cr>",
  { noremap = true, silent = true, desc = "Save file (no formatting)" }
)

--Return to Snacks Dashboard
keymap.set("n", "<leader>1", function()
  if vim.bo.filetype == "snacks_dashboard" then
    vim.notify("Hey, you're already here! Welcome home 󰟒", vim.log.levels.INFO, { titlekeym = "Dashboard" })
  else
    pcall(function()
      require("snacks").dashboard.open()
    end)
  end
end, { desc = "Home" })
wk.add({
  { "<leader>1", icon = { icon = "", color = "blue", h1 = "WhichKey" } },
})

-- Github Clone Repository
keymap.set("n", "<leader>gC", function()
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
        vim.notify("Cloned and changed directory to: " .. repo_folder, vim.log.levels.INFO)
      else
        vim.cmd("cd " .. path)
        vim.notify("Cloned and changed directory to: " .. path, vim.log.levels.INFO)
      end
    else
      vim.notify("Error cloning repository:\n" .. result, vim.log.levels.ERROR)
    end
  end
end, { desc = "Clone Git Repository" })

-- Find and Replace (without confirmation)
vim.keymap.set("v", "<leader>rn", '"hy:%s/<C-r>h//g<left><left>', { desc = "Rename selected text" })
vim.keymap.set("n", "<leader>rn", ":%s/<C-r>=expand('<cword>')<CR>//g<left><left>", { desc = "Rename current word" })

-- Find and Replace (with confirmation)
vim.keymap.set("v", "<leader>rN", '"hy:%s/<C-r>h//gc<left><left>', { desc = "Rename selected text with confirmation" })
vim.keymap.set(
  "n",
  "<leader>rN",
  ":%s/<C-r>=expand('<cword>')<CR>//gc<left><left><left>",
  { desc = "Rename current word with confirmation" }
)

-- Sort selected lines
vim.keymap.set("v", "<leader>rS", "<cmd>sort<cr>", { desc = "Sort selected lines" })

--Telescope (Hidden Files)
keymap.set(
  "n",
  "<leader>fh",
  ":Telescope find_files hidden=true<CR>",
  { noremap = true, silent = true, desc = "Find Files (Hidden)" }
)

--Snacks Explorer
---Find visible files
keymap.set("n", "<leader>e", function()
  require("snacks.explorer").open({ hidden = false, cwd = LazyVim.root() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (root)" })
keymap.set("n", "<leader>E", function()
  require("snacks.explorer").open({ hidden = false, cwd = vim.fn.getcwd() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (cwd)" })
---Find hidden files
keymap.set("n", "<leader>fe", function()
  require("snacks.explorer").open({ hidden = true, cwd = LazyVim.root() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (root -hidden)" })
keymap.set("n", "<leader>fE", function()
  require("snacks.explorer").open({ hidden = true, cwd = vim.fn.getcwd() })
end, { noremap = true, silent = true, desc = "Explorer Snacks (cwd -hidden)" })

-- Fzf Lua
keymap.set("n", "<leader>f/", ":FzfLua<CR>")
