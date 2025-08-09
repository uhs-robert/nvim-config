-- Remote server and filesystem tools
-- Contains plugins for SSHFS mounting and remote development workflows
return {
  -- SSHFS: Remote filesystem mounting and management
  -- Mount remote directories via SSHFS with integrated file picker support (Yazi)
  {
    -- Remote SSHFS Mount/Unmount
    "uhs-robert/sshfs.nvim",
    opts = {
      ui = {
        file_picker = {
          preferred_picker = "yazi",
        },
      },
    },
  },
}
