return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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
}
