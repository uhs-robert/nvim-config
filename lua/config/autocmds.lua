-- lua/config/autocmds.lua
-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Start terminal in insert mode
local api = vim.api
local termGrp = api.nvim_create_augroup("terminal", { clear = true })
api.nvim_create_autocmd("TermOpen", {
  group = termGrp,
  pattern = "*",
  command = "startinsert",
})

-- ephemeral windows close with q
api.nvim_create_autocmd("FileType", {
  pattern = { "aerial-nav", "help", "startuptime", "qf", "lspinfo" },
  callback = function()
    vim.keymap.set("n", "<Esc>", ":close<CR>", { buffer = true, silent = true })
  end,
})
api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.keymap.set("n", "<Esc>", ":quit<CR>", { buffer = true, silent = true })
  end,
})

-- Hyprlang LSP
api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

local allowed_ft = {
  -- web
  javascript = true,
  typescript = true,
  javascriptreact = true,
  typescriptreact = true,
  vue = true,
  svelte = true,
  astro = true,
  html = true,
  css = true,
  scss = true,
  less = true,
  -- scripts
  sh = true,
  bash = true,
  zsh = true,
  fish = true,
  -- general
  lua = true,
  python = true,
  ruby = true,
  perl = true,
  php = true,
  r = true,
  -- systems
  c = true,
  cpp = true,
  objc = true,
  objcpp = true,
  cuda = true,
  rust = true,
  go = true,
  -- JVM & friends
  java = true,
  kotlin = true,
  scala = true,
  groovy = true,
  -- mobile/other
  swift = true,
  dart = true,
  -- data / config (only those that accept a clear comment)
  sql = true,
  toml = true,
  conf = true,
  dosini = true,
  gitconfig = true,
  nginx = true,
  dockerfile = true,
  make = true,
  cmake = true,
  nix = true,
  helm = true,
  -- note: yaml/json have poor comment support; excluded intentionally
}

local fallback_by_ft = {
  lua = "-- %s",
  vim = '" %s',
  python = "# %s",
  sh = "# %s",
  bash = "# %s",
  zsh = "# %s",
  fish = "# %s",
  ruby = "# %s",
  perl = "# %s",
  r = "# %s",
  php = "// %s",
  javascript = "// %s",
  typescript = "// %s",
  javascriptreact = "// %s",
  typescriptreact = "// %s",
  vue = "<!-- %s -->",
  svelte = "<!-- %s -->",
  astro = "<!-- %s -->",
  html = "<!-- %s -->",
  css = "/* %s */",
  scss = "/* %s */",
  less = "/* %s */",
  c = "/* %s */",
  cpp = "/* %s */",
  objc = "/* %s */",
  objcpp = "/* %s */",
  cuda = "/* %s */",
  rust = "// %s",
  go = "// %s",
  java = "// %s",
  kotlin = "// %s",
  scala = "// %s",
  groovy = "// %s",
  swift = "// %s",
  dart = "// %s",
  sql = "-- %s",
  toml = "# %s",
  conf = "# %s",
  dosini = "; %s",
  gitconfig = "# %s",
  nginx = "# %s",
  dockerfile = "# %s",
  make = "# %s",
  cmake = "# %s",
  nix = "# %s",
  helm = "# %s",
}

local function trim(s)
  return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function comment_for_buf(bufnr, text)
  -- prefer 'commentstring' if valid
  local cs = vim.bo[bufnr].commentstring
  if cs and cs ~= "" and cs:find("%%s") then
    return (cs:gsub("%%s", text))
  end
  -- fallback by filetype
  local ft = vim.bo[bufnr].filetype
  local fb = fallback_by_ft[ft]
  if fb then
    return (fb:gsub("%%s", text))
  end
  -- last resort: shell-style
  return "# " .. text
end

local function already_has_comment(bufnr, target_line)
  local first = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
  local second = vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1] or ""
  return trim(first) == trim(target_line) or trim(second) == trim(target_line)
end

local function insertion_row_for_header(bufnr)
  local l1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
  -- skip UTF-8 BOM
  if l1:sub(1, 3) == "\239\187\191" then
    return 1
  end
  -- skip shebang
  if l1:match("^#!") then
    return 1
  end
  return 0
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.js",
    "*.jsx",
    "*.ts",
    "*.tsx",
    "*.mjs",
    "*.cjs",
    "*.lua",
    "*.py",
    "*.rb",
    "*.pl",
    "*.php",
    "*.r",
    "*.c",
    "*.h",
    "*.cpp",
    "*.hpp",
    "*.cc",
    "*.hh",
    "*.m",
    "*.mm",
    "*.cu",
    "*.rs",
    "*.go",
    "*.java",
    "*.kt",
    "*.kts",
    "*.scala",
    "*.groovy",
    "*.swift",
    "*.dart",
    "*.sh",
    "*.bash",
    "*.zsh",
    "*.fish",
    "*.html",
    "*.htm",
    "*.css",
    "*.scss",
    "*.less",
    "*.vue",
    "*.svelte",
    "*.astro",
    "*.sql",
    "*.toml",
    "*.conf",
    "*.ini",
    "*.gitconfig",
    "*.nginx",
    "Dockerfile",
    "dockerfile",
    "*.mk",
    "Makefile",
    "*.cmake",
    "CMakeLists.txt",
    "*.nix",
    "Chart.yaml",
  },
  callback = function(args)
    local bufnr = args.buf
    local filepath = args.file

    -- guard: only known code filetypes
    local ft = vim.bo[bufnr].filetype
    if not allowed_ft[ft] then
      return
    end

    -- find git root
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not git_root or git_root == "" then
      return
    end

    -- relative path
    local rel = filepath:gsub("^" .. git_root .. "/", "")
    local header = comment_for_buf(bufnr, rel)

    -- skip if already present
    if already_has_comment(bufnr, header) then
      return
    end

    -- Insert at the top
    local row = insertion_row_for_header(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, { header })
  end,
})
