return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", group = "ai", desc = "ai" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }, desc = " Action Panel" },
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true }, desc = " Open Chat" },
    { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", { noremap = true, silent = true }, desc = " Explain Code" },
    { "<leader>af", "<cmd>CodeCompanion /fix<cr>", { noremap = true, silent = true }, desc = " Fix Code" },
    { "<leader>at", "<cmd>CodeCompanion /test<cr>", { noremap = true, silent = true }, desc = " Test Code" },
    {
      "<leader>ag",
      "<cmd>CodeCompanion /commit<cr>",
      { noremap = true, silent = true },
      desc = " Github Commit Message",
    },
    { "<leader>ao", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true }, desc = " Add to Chat" },
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
      },
      display = {
        chat = {
          intro_message = "CodeCompanion ✨! Press ? for options",
          show_header_separator = false,
          separator = "─", -- The separator between the different messages in the chat buffer
          show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = false, -- Show the token count for each response?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
        },
      },
    })
  end,
}
