-- lua/plugins/theme.lua
-- Themes and thematic elements
-- Contains colorschemes, status lines, and elements which use themes

return {
  -- -- Melange
  -- { "savq/melange-nvim" },
  --
  -- -- Nightfox
  -- { "EdenEast/nightfox.nvim" },
  --
  -- -- kanagawa
  -- { "rebelot/kanagawa.nvim" },

  {
    -- "uhs-robert/color-chameleon.nvim",
    dir = "/home/roberth/Documents/github-uphill/color-chameleon.nvim/",
    lazy = false,
    priority = 900,
    config = function()
      local uid = (vim.uv or vim.loop).getuid()
      local is_sudoedit = vim.env.SUDOEDIT == "1" -- This requires your shell's config to export a flag like: SUDO_EDITOR="env SUDOEDIT=1 /usr/bin/nvim"
      local is_root = is_sudoedit or uid == 0

      -- stylua: ignore start
      require("color-chameleon").setup({
        enabled = true,
        rules = {
          { colorscheme = "oasis-sol", condition = function() return is_root end },
          { path = "~/mnt/", colorscheme = "oasis-mirage" },
        },
        default = "oasis",
      })
      -- stylua: ignore end

      -- -- stylua: ignore start
      -- require("color-chameleon").setup({
      --   enabled = true,
      --   rules = {
      --     { colorscheme = "oasis-sol", condition = function() return is_root end },
      --     { path = "~/mnt/", colorscheme = "oasis-canyon" },
      --     { path = "~/demo/project-a/", colorscheme = "oasis-desert" },
      --     { filetype = "markdown", colorscheme = "oasis-twilight" },
      --     { buftype = "terminal", colorscheme = "oasis-cactus" },
      --   },
      --   default = "oasis-lagoon"
      -- })
      -- -- stylua: ignore end

      -- Demo helper: Show directory and colorscheme on buffer enter
      -- local first_enter = true
      -- vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
      --   callback = function()
      --     if first_enter then
      --       first_enter = false
      --       return
      --     end
      --     local bufname = vim.fn.expand("%")
      --     if bufname == "" then
      --       return -- Skip empty buffers
      --     end
      --     local bufdir = vim.fn.expand("%:p:h") -- Buffer's directory
      --     local colorscheme = vim.g.colors_name or "none"
      --     vim.api.nvim_echo({
      --       { "📂 " .. bufdir, "Normal" },
      --       { "\n🎨 " .. colorscheme, "Normal" },
      --     }, false, {})
      --   end,
      -- })
    end,
  },
  -- Oasis
  {
    -- "uhs-robert/oasis.nvim",
    dir = "/home/roberth/Documents/github-uphill/oasis.nvim/",
    lazy = false,
    priority = 1000,
    config = function()
      require("oasis").setup({
        -- style = "lagoon",
        -- dark_style = "auto",
        -- light_style = "dune",
        light_intensity = 3,
        -- contrast = {
        -- min_ratio = 5.8,
        -- force_aaa = false,
        -- },
        -- themed_syntax = false,
        -- use_legacy_comments = true,
        -- styles = {
        --   italic = false,
        --   underline = false,
        --   undercurl = false,
        --   bold = false,
        --   strikethrough = false,
        -- },
        -- terminal_colors = false,
        -- transparent = true,
        -- highlight_overrides = function(c, colors)
        --   ---@type OasisHighlightOverrides
        --   return {
        --     -- Comment = { fg = c.fg.dim },
        --     desert = {
        --       Comment = { fg = c.syntax.preproc },
        --     },
        --     lagoon = {
        --       light_3 = {
        --         Comment = { fg = "#FFF000" },
        --       },
        --     },
        --     light = {
        --       Comment = { fg = "#FF0000" },
        --     },
        --     light_5 = {
        --       Comment = { fg = "#FFA000" },
        --     },
        --   }
        -- end,
        -- palette_overrides = function(c, colors)
        --   ---@type OasisPaletteOverrides
        --   return {
        --     desert = {
        --       syntax = {
        --         string = colors.rose[500],
        --       },
        --     },
        --   }
        -- end,
      })
      vim.keymap.set("n", "<leader>uB", function()
        require("oasis").cycle_intensity()
      end, { desc = "Cycle Oasis light mode intensity" })
      -- require("oasis").setup()
    end,
  },

  -- All Your Base
  -- {
  --   -- "uhs-robert/allyourbase.nvim",
  --   dir = "/home/roberth/Documents/github-uphill/allyourbase.nvim/",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("allyourbase").setup({
  --       colors = {
  --         color0 = "#101825",
  --       },
  --     })
  --   end,
  -- },

  -- Lush
  -- {
  --   "rktjmp/lush.nvim",
  -- },
  -- {
  --   "rktjmp/shipwright.nvim",
  -- },

  -- Lualine: Enhanced statusline with time display and file manager integration
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "oasis"
      opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, {
        lualine_z = {
          {
            function()
              return os.date("%I:%M:%S %p")
            end,
            icon = "󰥔",
          },
        },
      })
      if opts.sections and opts.sections.lualine_c then
        for _, section in ipairs(opts.sections.lualine_c) do
          section.on_click = function()
            local file_path = vim.fn.expand("%:p:h") -- Get file's directory
            vim.fn.jobstart({ "dolphin", file_path }, { detach = true }) -- Open Dolphin
          end
        end
      end
    end,
  },

  -- Tabby: Enhanced tab viewer with slanted element design and which-key binds
  {
    "nanozuki/tabby.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      -- always show tabline; sessions will restore tab pages + names
      vim.o.showtabline = 2
      vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
    end,
    ---@type TabbyConfig
    opts = {
      preset = "active_wins_at_tail",
      option = {
        nerdfont = true,
        buf_name = { mode = "unique" },
        -- lualine_theme = "auto",
      },
    },
    config = function(_, opts)
      require("tabby").setup(opts)
      local map = vim.keymap.set
      local optsn = { silent = true, noremap = true }

      -- next / prev tab
      map("n", "<leader><tab>h", ":tabp<CR>", vim.tbl_extend("force", optsn, { desc = "Prev tab" }))

      -- close (delete)
      map("n", "<leader><tab>d", ":tabclose<CR>", vim.tbl_extend("force", optsn, { desc = "Delete tab" }))

      -- move next / prev
      map("n", "<leader><tab>L", ":+tabmove<CR>", vim.tbl_extend("force", optsn, { desc = "Move tab right" }))
      map("n", "<leader><tab>H", ":-tabmove<CR>", vim.tbl_extend("force", optsn, { desc = "Move tab left" }))

      -- pick window (Tabby)
      map("n", "<leader><tab>w", ":Tabby pick_window<CR>", vim.tbl_extend("force", optsn, { desc = "Pick tab window" }))

      -- jump mode (Tabby) on f
      map("n", "<leader><tab>j", ":Tabby jump_to_tab<CR>", vim.tbl_extend("force", optsn, { desc = "Jump to tab" }))
    end,
  },
}
