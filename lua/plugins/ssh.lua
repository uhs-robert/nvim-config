return {
  "uhs-robert/nvim-ssh",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    -- mount_directory = vim.fn.expand("~/.local/share/ssh_mounts"),
    -- ssh_config = { vim.fn.expand("~/.ssh/config") }, -- Allows multiple config file paths
  },
}
