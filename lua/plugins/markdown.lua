-- lua/plugins/markdown.lua
-- Markdown rendering and enhancement tools
-- Contains plugins for beautiful markdown preview, syntax highlighting, and callout support

-- Return info for hl_name or nil if it does not exist.
local get_hl = function(hl_name)
  local hl_info = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
  return not vim.tbl_isempty(hl_info) and hl_info or nil
end

local setup_heading_hl_groups = function()
  local fallback_hl_info = get_hl("@markup.heading") or get_hl("Title")

  for lvl = 1, 6 do
    local hl_name = "@markup.heading." .. lvl
    local hl_info = get_hl(hl_name .. ".markdown") or get_hl(hl_name) or fallback_hl_info
    assert(hl_info, "Must set one of 'Title', '@markup.heading', '@markup.heading.N', or '@markup.heading.N.markdown'")

    local hl_spec = {}
    if hl_info.fg then hl_spec.fg = hl_info.fg end
    if hl_info.bg then hl_spec.bg = hl_info.bg end
    if hl_info.bold then hl_spec.bold = true end
    if hl_info.italic then hl_spec.italic = true end

    vim.api.nvim_set_hl(0, "RenderMarkdownH" .. lvl, hl_spec)
    hl_spec.reverse = true
    vim.api.nvim_set_hl(0, "RenderMarkdownH" .. lvl .. "Bg", hl_spec)
  end
end

return {
  -- Render Markdown: Beautiful in-buffer markdown rendering with syntax highlighting
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "md", "codecompanion" },
        render_modes = { "n", "no", "c", "t", "i", "ic" },
        code = {
          sign = false,
          border = "thin",
          position = "right",
          width = "block",
          above = "▁",
          below = "▔",
          language_left = "█",
          language_right = "█",
          language_border = "▁",
          left_pad = 1,
          right_pad = 1,
        },
        heading = {
          sign = false,
          width = "block",
          left_pad = 1,
          right_pad = 0,
          position = "right",
          icons = function(ctx)
            return (""):rep(ctx.level) .. ""
          end,
        },
      })

      setup_heading_hl_groups()
      vim.api.nvim_create_autocmd("Colorscheme", {
        desc = "Setup up heading hl groups for render markdown.",
        callback = setup_heading_hl_groups,
      })
      require("render-markdown").setup({})
    end,
  },
}
