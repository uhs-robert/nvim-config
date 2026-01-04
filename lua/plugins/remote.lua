-- lua/plugins/remote.lua
-- Remote server and filesystem tools
-- Contains plugins for SSHFS mounting and remote development workflows
return {
  -- SSHFS: Remote filesystem mounting and management
  -- Mount remote directories via SSHFS with integrated file picker support (Yazi)
  {
    -- Remote SSHFS Mount/Unmount
    -- "uhs-robert/sshfs.nvim",
    dir = "/home/roberth/Documents/github-uphill/sshfs.nvim/",
    opts = {
      global_paths = {
        "~/.config",
        "/var/www",
        -- "/srv",
        -- "/opt",
        "/var/log",
        "/etc",
        -- "/tmp",
        -- "/usr/local",
        -- "/data",
        -- "/var/lib",
      },
      host_paths = {
        -- Optionally define default mount paths for specific hosts
        ["whatbox"] = {
          "~/files",
        },
        ["civil-communicator"] = {
          "/var/www/civil-communicator-server/",
        },
        -- ["host_who_uses_password"] = {
        --   "~/files",
        -- },
        -- ["host_who_uses_key"] = {
        --   "/var/log/",
        --   "/var/www/",
        --   -- "/var/www/civil-communicator-server/",
        -- },
      },
      -- hooks = {
      --   on_exit = {
      --     auto_unmount = true,        -- auto-disconnect all mounts on :q or exit
      --     clean_mount_folders = true, -- optionally clean up mount folders after disconnect
      --   },
      --   on_mount = {
      --     auto_change_to_dir = false, -- auto-change current directory to mount point
      --     auto_run = "find",          -- "find" (default), "grep", "live_find", "live_grep", "terminal", "none", or a custom function(ctx)
      --   },
      -- },
      ui = {
        local_picker = {
          preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "mini", "telescope", "oil", "neo-tree", "nvim-tree", "yazi", "lf", "nnn", "ranger", "netrw"
          -- preferred_picker = "snacks",       -- DONE
          -- preferred_picker = "yazi",         -- DONE
          -- preferred_picker = "telescope",    -- DONE
          -- preferred_picker = "mini",         -- DONE
          -- preferred_picker = "neo-tree",     -- DONE
          -- preferred_picker = "oil",          -- DONE
          -- preferred_picker = "nvim-tree",    -- DONE
          -- preferred_picker = "lf",           -- DONE
          -- preferred_picker = "nnn",          -- DONE
          -- preferred_picker = "ranger",       -- DONE
          -- preferred_picker = "fzf-lua",      -- DONE
          -- preferred_picker = "netrw",
          fallback_to_netrw = true, -- fallback to netrw if no picker is available
          netrw_command = "Lexplore", -- netrw command: "Explore", "Lexplore", "Sexplore", "Vexplore", "Texplore"
        },
        remote_picker = {
          preferred_picker = "auto", -- one of: "auto", "snacks", "fzf-lua", "telescope", "mini"
        },
      },
    },
  },
  -- NOTE: For testing integrations

  -- NVIM TREE
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup({})
  --   end,
  -- },

  -- NEO TREE
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons", -- optional, but recommended
  --   },
  --   lazy = false, -- neo-tree will lazily load itself
  -- },

  -- OIL
  -- {
  --   "stevearc/oil.nvim",
  --   ---@module 'oil'
  --   ---@type oil.SetupOpts
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  --   -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  --   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  --   lazy = false,
  -- },

  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- NNN
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup()
    end,
  },

  -- LF
  -- {
  --   "lmburns/lf.nvim",
  --   config = function()
  --     -- This feature will not work if the plugin is lazy-loaded
  --     vim.g.lf_netrw = 1
  --
  --     require("lf").setup({
  --       escape_quit = false,
  --       border = "rounded",
  --     })
  --
  --     vim.keymap.set("n", "<M-o>", "<Cmd>Lf<CR>")
  --   end,
  --   requires = { "toggleterm.nvim" },
  -- },
  -- { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- MINI
  -- { "nvim-mini/mini.nvim", version = false },

  -- RANGER
  -- {
  --   "kelly-lin/ranger.nvim",
  --   config = function()
  --     require("ranger-nvim").setup({ replace_netrw = true })
  --     vim.api.nvim_set_keymap("n", "<leader>ef", "", {
  --       noremap = true,
  --       callback = function()
  --         require("ranger-nvim").open(true)
  --       end,
  --     })
  --   end,
  -- },
}
