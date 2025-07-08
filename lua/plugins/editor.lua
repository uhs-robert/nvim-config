return {

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function(_, _, _)
          return { "treesitter", "indent" }
        end,
      })

      local ufo = require("ufo")

      -- Keymaps using WhichKey labels
      vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds (skip comments/imports)" })
      vim.keymap.set("n", "zm", function()
        ufo.closeFoldsWith(1)
      end, { desc = "Close folds (level 1)" })

      vim.keymap.set("n", "K", function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek folded lines or hover" })
    end,
  },

  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("no-neck-pain").setup({
        width = 150,
        autocmds = {
          enableOnVimEnter = false,
          skipEnteringNoNeckPainBuffer = true,
        },
      })
    end,
  },

  {
    "anuvyklack/pretty-fold.nvim",
  },

  {
    "chrisgrieser/nvim-spider",
    event = "ModeChanged",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "x", "o" } },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "x", "o" } },
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "x", "o" } },
    },
    opts = {
      skipInsignificantPunctuation = false,
    },
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    event = "InsertEnter",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
}
