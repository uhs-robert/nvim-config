-- Language Server Protocol configurations and enhancements
-- Contains LSP-related plugins for code navigation, previews, and server settings
return {
  -- Goto Preview: Floating window previews for LSP definitions
  -- Shows definitions, implementations, references in popup windows without leaving current location
  { -- plugin config for goto-preview
    "rmagatti/goto-preview",
    event = "LspAttach",
    config = function()
      require("goto-preview").setup({})
    end,
  },

  -- LSP Config: Extended TypeScript server configuration
  -- Enhances LazyVim's LSP setup with TypeScript inlay hints and custom filetypes
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
