-- Git integration and version control tools
-- Contains plugins for git diffs, signs, GitHub integration, and repository management
return {
  -- DiffView: Advanced git diff and merge tool
  -- Provides side-by-side diff views, merge conflict resolution, and git history browsing
  {
    "sindrets/diffview.nvim",
    enabled = true,
    config = function()
      require("diffview").setup()
    end,
  },

  -- Open GitHub URL: Quick navigation to GitHub from code
  -- Opens GitHub URLs, files, and line numbers directly from Neovim with <leader>gw
  {
    "tetzng/open-github-url.nvim",

    -- recommended
    keys = {
      {
        "<leader>gw",
        "<cmd>OpenGitHubUrlUnderCursor<cr>",
        desc = "Open GitHub URL under cursor",
      },
    },

    config = function()
      require("open-github-url").setup()
    end,
  },

  -- GitSigns: Git status in the sign column
  -- Shows git changes, additions, deletions in the gutter with navigation keymaps
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      end,
    },
  },
}
