return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { "markdown", "quarto" },
      render_modes = { "n", "c", "t" }, -- only render in normal/command/terminal
      anti_conceal = {
        enabled = true,
        ignore = {
          code_background = true,
          sign = true,
        },
      },
      bullet = {
        enabled = true,
        render_modes = false,
        icons = { "●", "○", "◆", "◇" },
        ordered_icons = function(ctx)
          local value = vim.trim(ctx.value)
          local index = tonumber(value:sub(1, #value - 1))
          return ("%d."):format(index > 1 and index or ctx.index)
        end,
        left_pad = 0,
        right_pad = 0,
        highlight = "RenderMarkdownBullet",
        scope_highlight = {},
      },
      callout = {
        note = {
          raw = "[!NOTE]",
          rendered = "󰋽 Note",
          highlight = "RenderMarkdownInfo",
          category = "github",
        },
        tip = {
          raw = "[!TIP]",
          rendered = "󰌶 Tip",
          highlight = "RenderMarkdownSuccess",
          category = "github",
        },
        important = {
          raw = "[!IMPORTANT]",
          rendered = "󰅾 Important",
          highlight = "RenderMarkdownHint",
          category = "github",
        },
        warning = {
          raw = "[!WARNING]",
          rendered = "󰀪 Warning",
          highlight = "RenderMarkdownWarn",
          category = "github",
        },
        caution = {
          raw = "[!CAUTION]",
          rendered = "󰳦 Caution",
          highlight = "RenderMarkdownError",
          category = "github",
        },
        abstract = {
          raw = "[!ABSTRACT]",
          rendered = "󰨸 Abstract",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        summary = {
          raw = "[!SUMMARY]",
          rendered = "󰨸 Summary",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        tldr = {
          raw = "[!TLDR]",
          rendered = "󰨸 Tldr",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        info = {
          raw = "[!INFO]",
          rendered = "󰋽 Info",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        todo = {
          raw = "[!TODO]",
          rendered = "󰗡 Todo",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        hint = {
          raw = "[!HINT]",
          rendered = "󰌶 Hint",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        success = {
          raw = "[!SUCCESS]",
          rendered = "󰄬 Success",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        check = {
          raw = "[!CHECK]",
          rendered = "󰄬 Check",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        done = {
          raw = "[!DONE]",
          rendered = "󰄬 Done",
          highlight = "RenderMarkdownSuccess",
          category = "obsidian",
        },
        question = {
          raw = "[!QUESTION]",
          rendered = "󰘥 Question",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        help = {
          raw = "[!HELP]",
          rendered = "󰘥 Help",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        faq = {
          raw = "[!FAQ]",
          rendered = "󰘥 Faq",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        attention = {
          raw = "[!ATTENTION]",
          rendered = "󰀪 Attention",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        failure = {
          raw = "[!FAILURE]",
          rendered = "󰅖 Failure",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        fail = {
          raw = "[!FAIL]",
          rendered = "󰅖 Fail",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        missing = {
          raw = "[!MISSING]",
          rendered = "󰅖 Missing",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        danger = {
          raw = "[!DANGER]",
          rendered = "󱐌 Danger",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        error = {
          raw = "[!ERROR]",
          rendered = "󱐌 Error",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        bug = {
          raw = "[!BUG]",
          rendered = "󰨰 Bug",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        example = {
          raw = "[!EXAMPLE]",
          rendered = "󰉹 Example",
          highlight = "RenderMarkdownHint",
          category = "obsidian",
        },
        quote = {
          raw = "[!QUOTE]",
          rendered = "󱆨 Quote",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
        cite = {
          raw = "[!CITE]",
          rendered = "󱆨 Cite",
          highlight = "RenderMarkdownQuote",
          category = "obsidian",
        },
      },
      checkbox = {
        -- # Checkboxes
        --
        -- - [ ] Unchecked
        -- - [x] Checked
        -- - [-] Todo
        -- - [~] Custom
        enabled = true,
        position = "inline",
        unchecked = {
          highlight = "RenderMarkdownUnchecked",
          scope_highlight = nil,
        },
        checked = {
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox
          scope_highlight = nil,
        },
        custom = {
          question = { raw = "[?]", rendered = " ", highlight = "RenderMarkdownInfo" },
          hold = { raw = "[=]", rendered = " ", highlight = "RenderMarkdownWarn" },
          cancelled = { raw = "[c]", rendered = "󰅙 ", highlight = "RenderMarkdownError" },
          in_progress = { raw = "[/]", rendered = " ", highlight = "RenderMarkdownTodo" },
          waiting = { raw = "[.]", rendered = " ", highlight = "RenderMarkdownHint" },
          important = { raw = "[!]", rendered = "󱈸 ", highlight = "RenderMarkdownError" },
          info = { raw = "[i]", rendered = " ", highlight = "RenderMarkdownInfo" },
          note = { raw = "[n]", rendered = "󰎞 ", highlight = "RenderMarkdownInfo" },
          idea = { raw = "[*]", rendered = " ", highlight = "RenderMarkdownHint" },
          blocked = { raw = "[#]", rendered = " ", highlight = "RenderMarkdownError" },
        },
      },
      heading = {
        enabled = true,
        render_modes = false,
        atx = true,
        setext = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        position = "overlay",
        signs = { "󰫎 " },
        width = "full",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = "▄",
        below = "▀",
        backgrounds = {
          "MarkdownHeadlineH1",
          "MarkdownHeadlineH2",
          "MarkdownHeadlineH3",
          "MarkdownHeadlineH4",
          "MarkdownHeadlineH5",
          "MarkdownHeadlineH6",
        },
        foregrounds = {
          "MarkdownHeadlineH1",
          "MarkdownHeadlineH2",
          "MarkdownHeadlineH3",
          "MarkdownHeadlineH4",
          "MarkdownHeadlineH5",
          "MarkdownHeadlineH6",
        },
        custom = {},
        -- heading = {
        --   sign = false,
        --   icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        --   backgrounds = {
        -- "Headline1Bg",
        -- "Headline2Bg",
        -- "Headline3Bg",
        -- "Headline4Bg",
        -- "Headline5Bg",
        -- "Headline6Bg",
        --   },
        --   foregrounds = {
        --     "Headline1Fg",
        --     "Headline2Fg",
        --     "Headline3Fg",
        --     "Headline4Fg",
        --     "Headline5Fg",
        --     "Headline6Fg",
        --   },
      },
      link = {
        enabled = true,
        render_modes = false,
        footnote = {
          enabled = true,
          superscript = true,
          prefix = "",
          suffix = "",
        },
        image = "󰥶 ",
        email = "󰀓 ",
        hyperlink = "󰌹 ",
        highlight = "RenderMarkdownLink",
        wiki = {
          icon = "󱗖 ",
          body = function()
            return nil
          end,
          highlight = "RenderMarkdownWikiLink",
        },
        custom = {
          web = { pattern = "^http", icon = "󰖟 " },
          discord = { pattern = "discord%.com", icon = "󰙯 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
          gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
          google = { pattern = "google%.com", icon = "󰊭 " },
          neovim = { pattern = "neovim%.io", icon = " " },
          reddit = { pattern = "reddit%.com", icon = "󰑍 " },
          stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
          wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
          youtube = { pattern = "youtube%.com", icon = "󰗃 " },
        },
      },
    },
  },
}
