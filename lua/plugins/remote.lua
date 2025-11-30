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
      mounts = {
        -- auto_change_dir_on_mount = true,
      },
      ui = {
        file_picker = {
          -- auto_open_on_mount = false,
          preferred_picker = "yazi",
        },
      },
    },
  },
}
