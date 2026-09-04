-- Contextual PR review mode: reviews a PR's full delta in normal source buffers via Gitsigns,
-- with cross-file [r/]r navigation. Git is authoritative for the diff; gh only supplies PR metadata.

local M = {}

M.state = {
  active = false,
  base = nil,
  files = {},
  file_index = nil,
}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Git Review", timeout = 5000 })
end

local function system(cmd)
  local result = vim.fn.system(cmd)
  return vim.trim(result), vim.v.shell_error
end

local function git_root()
  local out, code = system({ "git", "rev-parse", "--show-toplevel" })
  if code ~= 0 or out == "" then return nil end
  return out
end

local function resolve_pr_target()
  local out, code = system({ "gh", "pr", "view", "--json", "number,title,baseRefName,headRefName" })
  if code ~= 0 or out == "" then
    return nil, "No pull request found for the current branch, or gh is unavailable/unauthenticated"
  end
  local ok, decoded = pcall(vim.json.decode, out)
  if not ok or not decoded or not decoded.baseRefName then return nil, "Failed to parse PR metadata from gh" end
  return decoded, nil
end

-- Resolves the base branch to a usable git revision, fetching from origin if needed.
local function resolve_base_ref(base_branch)
  local candidates = { base_branch, "origin/" .. base_branch }
  for _, ref in ipairs(candidates) do
    local _, code = system({ "git", "rev-parse", "--verify", ref })
    if code == 0 then return ref end
  end

  system({ "git", "fetch", "origin", base_branch })
  local origin_ref = "origin/" .. base_branch
  local _, code = system({ "git", "rev-parse", "--verify", origin_ref })
  if code == 0 then return origin_ref end
  return nil
end

local function merge_base(base_ref)
  local out, code = system({ "git", "merge-base", base_ref, "HEAD" })
  if code ~= 0 or out == "" then return nil end
  return out
end

-- Returns a list of { path, status } entries, excluding binaries; also returns skipped-binary count.
local function collect_changed_files(base)
  local status_out, status_code = system({ "git", "diff", "--name-status", "-M", base, "HEAD" })
  if status_code ~= 0 then return {}, 0 end

  local numstat_out = system({ "git", "diff", "--numstat", "-M", base, "HEAD" })
  local binary_paths = {}
  for line in numstat_out:gmatch("[^\n]+") do
    local added, removed, path = line:match("^(%S+)\t(%S+)\t(.+)$")
    if added == "-" and removed == "-" then binary_paths[path] = true end
  end

  local files = {}
  local skipped_binaries = 0
  if status_out ~= "" then
    for line in status_out:gmatch("[^\n]+") do
      local fields = {}
      for field in line:gmatch("[^\t]+") do
        table.insert(fields, field)
      end
      local status, path = fields[1], fields[#fields]
      if binary_paths[path] then
        skipped_binaries = skipped_binaries + 1
      else
        table.insert(files, { path = path, status = status })
      end
    end
  end
  return files, skipped_binaries
end

local function root_relative(path)
  local root = git_root()
  if not root then return path end
  return root .. "/" .. path
end

-- Resolves the current buffer's position in state.files, self-healing if the user
-- manually switched buffers instead of using [r/]r.
local function current_file_index()
  local buf_name = vim.api.nvim_buf_get_name(0)
  for i, file in ipairs(M.state.files) do
    if buf_name == root_relative(file.path) or buf_name == file.path .. " (deleted)" then return i end
  end
  return M.state.file_index
end

-- Buffer-local nav keymaps; needed on deleted-file scratch buffers since gitsigns
-- never attaches to them (git.lua's on_attach covers ordinary file buffers).
local function bind_review_keys(buf)
  vim.keymap.set("n", "]r", M.next_hunk, { buffer = buf, desc = "Next Review Hunk" })
  vim.keymap.set("n", "[r", M.prev_hunk, { buffer = buf, desc = "Prev Review Hunk" })
  vim.keymap.set("n", "<leader>gr", M.toggle, { buffer = buf, desc = "Git Review" })
end

-- Opens a readonly scratch buffer with the file's content at the merge base, for deleted files.
local function open_deleted_file(path)
  local out, code = system({ "git", "show", M.state.base .. ":" .. path })
  if code ~= 0 then
    notify("Failed to read deleted file from merge base: " .. path, vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(out, "\n"))
  vim.api.nvim_buf_set_name(buf, path .. " (deleted)")
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].filetype = vim.filetype.match({ filename = path }) or ""
  vim.bo[buf].modifiable = false
  vim.api.nvim_win_set_buf(0, buf)
  bind_review_keys(buf)
end

local function open_file_at_index(index)
  local file = M.state.files[index]
  if not file then return end
  M.state.file_index = index

  if file.status == "D" then
    open_deleted_file(file.path)
  else
    vim.cmd.edit(vim.fn.fnameescape(root_relative(file.path)))
  end
end

-- Waits for gitsigns to finish attaching/diffing the buffer before navigating, since
-- change_base()/attach are async and a fixed vim.schedule can fire before hunks exist.
local function nav_when_ready(land, tries)
  tries = tries or 20
  vim.schedule(function()
    local gs = package.loaded.gitsigns
    if not gs then return end
    local hunks = gs.get_hunks()
    if (hunks and #hunks > 0) or tries <= 0 then
      gs.nav_hunk(land)
    else
      vim.defer_fn(function()
        nav_when_ready(land, tries - 1)
      end, 50)
    end
  end)
end

function M.start()
  if M.state.active then
    notify("Review already active", vim.log.levels.WARN)
    return
  end

  if not git_root() then
    notify("Not inside a git repository", vim.log.levels.ERROR)
    return
  end

  local pr, err = resolve_pr_target()
  if not pr then
    notify(err, vim.log.levels.ERROR)
    return
  end

  local base_ref = resolve_base_ref(pr.baseRefName)
  if not base_ref then
    notify("Could not resolve target branch: " .. pr.baseRefName, vim.log.levels.ERROR)
    return
  end

  local base = merge_base(base_ref)
  if not base then
    notify("Could not calculate merge base with " .. base_ref, vim.log.levels.ERROR)
    return
  end

  local files, skipped_binaries = collect_changed_files(base)
  if #files == 0 then
    notify("No changes to review", vim.log.levels.INFO)
    return
  end

  M.state.active = true
  M.state.base = base
  M.state.files = files
  M.state.file_index = nil

  local ok, gitsigns = pcall(require, "gitsigns")
  if ok then gitsigns.change_base(base, true) end

  if skipped_binaries > 0 then
    notify(string.format("Skipped %d binary file(s)", skipped_binaries), vim.log.levels.INFO)
  end

  open_file_at_index(1)
  nav_when_ready("first")

  notify(string.format("Reviewing PR #%d: %s (%d files)", pr.number, pr.title, #files))
end

function M.stop()
  if not M.state.active then
    notify("Review not active", vim.log.levels.WARN)
    return
  end

  local ok, gitsigns = pcall(require, "gitsigns")
  if ok then gitsigns.change_base(nil, true) end

  M.state.active = false
  M.state.base = nil
  M.state.files = {}
  M.state.file_index = nil

  notify("Review mode stopped")
end

function M.toggle()
  if M.state.active then
    M.stop()
  else
    M.start()
  end
end

-- Crosses into the file at M.state.files[index] and lands on its first or last hunk.
local function jump_into_file(index, land)
  open_file_at_index(index)
  nav_when_ready(land)
end

function M.next_hunk()
  if not M.state.active then
    notify("Review not active", vim.log.levels.WARN)
    return
  end

  local gs = package.loaded.gitsigns
  local hunks = gs and gs.get_hunks() or nil
  if hunks and #hunks > 0 then
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    for _, hunk in ipairs(hunks) do
      if hunk.added.start > cursor_line then
        gs.nav_hunk("next")
        return
      end
    end
  end

  local index = current_file_index() or 1
  if index >= #M.state.files then
    notify("End of review")
    return
  end
  jump_into_file(index + 1, "first")
end

function M.prev_hunk()
  if not M.state.active then
    notify("Review not active", vim.log.levels.WARN)
    return
  end

  local gs = package.loaded.gitsigns
  local hunks = gs and gs.get_hunks() or nil
  if hunks and #hunks > 0 then
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    for i = #hunks, 1, -1 do
      local hunk = hunks[i]
      if hunk.added.start < cursor_line then
        gs.nav_hunk("prev")
        return
      end
    end
  end

  local index = current_file_index() or 1
  if index <= 1 then
    notify("Start of review")
    return
  end
  jump_into_file(index - 1, "last")
end

return M
