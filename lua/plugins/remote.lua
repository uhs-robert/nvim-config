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
}
