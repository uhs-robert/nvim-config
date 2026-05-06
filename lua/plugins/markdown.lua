-- lua/plugins/markdown.lua
-- Markdown rendering and enhancement tools
-- Contains plugins for beautiful markdown preview, syntax highlighting, and callout support

---@param name string highlight group name
---@return vim.api.keyset.hl_info|nil
local get_hl = function(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
    name = name,
    link = false,
  })

  if not ok or vim.tbl_isempty(hl) then return nil end

  return hl
end

---@param hl vim.api.keyset.hl_info
---@return vim.api.keyset.hl_info
local normalize_hl = function(hl)
  return {
    fg = hl.fg,
    bg = hl.bg,
    bold = hl.bold or nil,
    italic = hl.italic or nil,
    underline = hl.underline or nil,
  }
end

--- Derives per-level RenderMarkdownH{1-6} highlight groups from treesitter heading highlights,
--- falling back to @markup.heading or Title. Called once at startup and on ColorScheme changes.
local setup_heading_hl_groups = function()
  local fallback = get_hl("@markup.heading") or get_hl("Title")

  if not fallback then return end

  for level = 1, 6 do
    local hl = get_hl(("@markup.heading.%d.markdown"):format(level))
      or get_hl(("@markup.heading.%d"):format(level))
      or fallback

    hl = normalize_hl(hl)

    vim.api.nvim_set_hl(0, ("RenderMarkdownH%d"):format(level), hl)
    vim.api.nvim_set_hl(0, ("RenderMarkdownH%dBg"):format(level), vim.tbl_extend("force", hl, { reverse = true }))
  end
end

return {
  -- Render Markdown: Beautiful in-buffer markdown rendering with syntax highlighting
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    ft = { "markdown", "md", "mdx", "codecompanion" },

    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons

    init = function()
      local group = vim.api.nvim_create_augroup("RenderMarkdownHeadingHighlights", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        desc = "Set render-markdown heading highlight groups",
        callback = function()
          vim.schedule(setup_heading_hl_groups)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VeryLazy",
        desc = "Refresh render-markdown heading highlight groups after lazy UI setup",
        callback = function()
          vim.schedule(setup_heading_hl_groups)
        end,
      })
    end,

    config = function(_, opts)
      require("render-markdown").setup(opts)
      setup_heading_hl_groups()
    end,

    opts = {
      file_types = { "markdown", "md", "mdx", "codecompanion" },
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
    },
  },
}
