vim.keymap.set("n", "<leader>cj", ":%!jq .<CR>", {
  buffer = true,
  silent = true,
  desc = "Format JSON with jq",
})
