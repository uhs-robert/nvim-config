return {
  { -- plugin config for goto-preview
    "rmagatti/goto-preview",
    event = "LspAttach",
    config = function()
      require("goto-preview").setup({})
    end,
  },

  { -- extend LazyVim's LSP setup
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          init_options = {
            hostInfo = "neovim",
          },
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
              },
            },
          },
        },
      },
    },
  },
}
