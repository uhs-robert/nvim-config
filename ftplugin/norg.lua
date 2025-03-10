vim.api.nvim_create_autocmd("FileType", {
  pattern = "norg",
  callback = function()
    -- Keymaps
    vim.keymap.set("n", "M-SPACE", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { buffer = true }) -- toggle task state
    vim.keymap.set("n", "<localLeader>toc", "<cmd>Neorg toc<CR>", { buffer = true }) -- Generate TOC

    local wk = require("which-key")
    wk.add({
      { "<leader>n", group = "Neorg" }, -- Creates a submenu for Neorg

      -- 📝 **Editing & Organization**
      { "<leader>nt", "<Plug>(neorg.pivot.list.toggle)", desc = "Toggle List Type" },
      { "<leader>np", "<Plug>(neorg.promo)", desc = "Promote/Demote List Item" },
      { "<leader>nc", "<cmd>Neorg toggle-concealer<CR>", desc = "Toggle Concealer" },
      { "<leader>ni", "<Plug>(neorg.itero.next)", desc = "Continue List / Heading" },

      -- 🔗 **Link Navigation**
      { "<leader>no", "<Plug>(neorg.keybinds.hop-link)", desc = "Follow Link" },
      { "<leader>nl", "<cmd>Neorg return<CR>", desc = "Return to Previous Location" },

      -- 📅 **Journal & Notes**
      { "<leader>nj", "<cmd>Neorg journal today<CR>", desc = "Open Today’s Journal" },
      { "<leader>ny", "<cmd>Neorg journal yesterday<CR>", desc = "Open Yesterday’s Journal" },

      -- 📑 **Table of Contents**
      { "<leader>ntc", "<cmd>Neorg toc<CR>", desc = "Generate TOC" },

      -- 📂 **Workspace & File Management**
      { "<leader>nw", "<cmd>Neorg workspace notes<CR>", desc = "Open Notes Workspace" },
      { "<leader>nn", "<cmd>Neorg index<CR>", desc = "Open Neorg Index" },
      { "<leader>nf", "<cmd>Telescope find_files cwd=~/notes<CR>", desc = "Find File in Notes" },

      -- ✅ **Task Management**
      { "<leader>nd", "<Plug>(neorg.qol.todo_items.toggle)", desc = "Toggle TODO Item" },
      { "<leader>ndp", "<cmd>Neorg inject-metadata<CR>", desc = "Insert Metadata (Date, Tags)" },
    }, { mode = "n", buffer = 0 }) -- Restrict to `.norg` files
  end,
})
