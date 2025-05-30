-- TODO:
-- add error handling and testing
-- make config handling nicer and allow passing of config through setup (config should be merged with defaults)

-- convention
local M = {}

-- remotelink generated from Zed
-- https://github.com/python/cpython/blob/fcc0a377cfc2fe6683443745739d3b16224d884d/Python/getcompiler.c#L15
-- permaling generated from VScode
-- https://github.je-labs.com/customer-data-science/customer-deduping/blob/54905b5bc2924a6004ea12844bcf35e8288be586/customer_deduping/components/bigquery.py#L17

-- git url examples:
-- git@github.je-labs.com:customer-data-science/customer-deduping.git
-- https://github.com/python/cpython.git

M.opts = {
  debug = false,
  domains = {
    ["default"] = "github.com",
    ["jet"] = "github.je-labs.com",
  },
}

---@param cmd table
---@return string
local run_command = function(cmd)
  -- TODO: refactor to use vim.system as preferred in docs
  return vim.fn.system(cmd)
end

---@param pattern string
---@return string
local escape_magic = function(pattern)
  -- this escapes magic characters (^$()%.[]*+-?) so the string can be used in a pattern
  -- (e.g. :match, :gsub, ...)
  -- https://stackoverflow.com/questions/70495415/lua-variable-in-pattern-match-with-special-characters
  return (pattern:gsub("%W", "%%%1"))
end

---@return string
local get_sha = function()
  return run_command({ "git", "rev-parse", "HEAD" })
end

---@return string
local get_git_root = function()
  -- removes the \n character at the end
  return run_command({ "git", "rev-parse", "--show-toplevel" }):match("[^/]+$"):gsub("\n", "")
end

---@return string
local get_filepath = function()
  -- full file path
  return vim.fn.expand("%:p")
end

---@return table
local get_repo_info = function()
  local git_url = run_command({ "git", "remote", "get-url", "origin" }):gsub("\n", "")
  -- parse url
  if git_url:find("https://") then
    local domain = M.opts.domains["default"]
    -- match returns the substring in the capture group () not the entire matched string
    local owner = git_url:match(domain .. "/([^/]+)")
    local repo = git_url:match(domain .. "/[^/]+/([^/]+)"):gsub(".git", "")
    return { domain, owner, repo }
  end
  if git_url:find("git@") then
    local domain = M.opts.domains["jet"]
    local owner = git_url:match(escape_magic(domain) .. ":([^/]+)")
    local repo = git_url:match(escape_magic(domain) .. ":[^/]+/([^/]+)"):gsub(".git", "")
    return { domain, owner, repo }
  end
  return { nil, nil, nil }
end

---@param filepath string
---@param git_root string
---@return string
local get_filename = function(filepath, git_root)
  -- Derives filename from filepath and git root. removes from final path as root
  -- can be different than the repo name (e.g. git clone into a specific dir)
  -- NOTE: Had issues with the matching because git_root contained \n character
  return filepath:match(".*(" .. escape_magic(git_root) .. ".*)"):gsub("^" .. escape_magic(git_root) .. "/", "")
end

---@return boolean
local is_git_repo = function()
  local git_status = run_command({ "git", "status" })
  if git_status:match("fatal: not a git repository") then
    return false
  end
  return true
end

---@return string|nil
M.get_remotelink = function()
  -- validate if git repo and return if not
  if not is_git_repo() then
    print("WARNING: RemoteLink only works in git repos")
    return
  end

  local line_number = vim.fn.line(".")
  local protocol = "https://"
  -- this could be controlled by env variable (or setting from setup)
  local repo_info = get_repo_info()
  local domain = repo_info[1]
  local owner = repo_info[2]
  local repo = repo_info[3]
  local sha = get_sha()
  local git_root = get_git_root()
  local filepath = get_filepath()
  local filename = get_filename(filepath, git_root)

  local remotelink = protocol
    .. domain
    .. "/"
    .. owner
    .. "/"
    .. repo
    .. "/blob/"
    .. sha
    .. "/"
    .. filename
    .. "#L"
    .. line_number

  return remotelink
end

M.setup = function()
  local opts = M.opts or {}

  if opts.debug == true then
    -- debug
    print("--------------------")
    print("Start debug:")
    print("sha: " .. get_sha())
    print("git root: " .. get_git_root())
    print("line number: " .. vim.fn.line("."))
    print("file name: " .. get_filename(get_filepath(), get_git_root()))
    local repo_info = get_repo_info()
    print("git repo info: " .. repo_info[1])
    print("git repo info: " .. repo_info[2])
    print("End debug.")
    print("--------------------")
  end

  -- Define command
  vim.api.nvim_create_user_command("RemoteLink", function()
    local remotelink = M.get_remotelink()
    if not remotelink then
      return
    end
    -- copy variable to unnamedplus register
    vim.fn.setreg("+", remotelink)
    vim.print("Created remote link: " .. remotelink)
    return M.get_remotelink()
  end, { desc = "Run MyPluginCommand" })
end

return M
