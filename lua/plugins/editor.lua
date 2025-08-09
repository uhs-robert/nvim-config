-- Core editor enhancements and productivity tools
-- Contains plugins for folding, undo management, centering, text objects, syntax parsing, and editor behavior improvements
return {

  -- Treesitter: Syntax highlighting and parsing engine
  -- Extended parser list for better syntax support across multiple languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- UFO: Advanced folding with treesitter and LSP integration
  -- Provides intelligent code folding with peek functionality and custom fold levels
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

  -- Undotree: Visual undo history browser
  -- Navigate through undo/redo history with a tree-like interface, toggle with <leader>U
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>U", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },

  -- No Neck Pain: Center buffer content for comfortable reading
  -- Centers content in the middle of the screen with configurable width (150 chars)
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

  -- Pretty Fold: Enhanced fold text display
  -- Improves the appearance of folded code blocks with better formatting
  {
    "anuvyklack/pretty-fold.nvim",
  },

  -- Spider: Enhanced word movement that skips punctuation
  -- Smarter w, e, b motions that ignore insignificant punctuation for cleaner navigation
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

  -- Various Text Objects: Additional text objects for enhanced editing
  -- Provides extra text objects like entire buffer, visible area, URLs, numbers, etc.
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "InsertEnter",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },

  -- HelpView: Enhanced help documentation with better formatting and syntax highlighting
  -- Improves the appearance and readability of Neovim's built-in help files
  {
    "OXY2DEV/helpview.nvim",
    lazy = false,
  },
}
