-- convention
local M = {}

-- print("hello from gitremotelink module")

-- get line number
-- print(vim.fn.line('.'))

-- remotelink generated from Zed
-- https://github.com/python/cpython/blob/fcc0a377cfc2fe6683443745739d3b16224d884d/Python/getcompiler.c#L15
-- permaling generated from VScode
-- https://github.je-labs.com/customer-data-science/customer-deduping/blob/54905b5bc2924a6004ea12844bcf35e8288be586/customer_deduping/components/bigquery.py#L17

-- git url examples:
-- git@github.je-labs.com:customer-data-science/customer-deduping.git
-- https://github.com/python/cpython.git

-- flow of generating remotelink
-- 1. get line number (or line range)
-- 2. get git url and blob number? and anything else
-- 3. print to console
-- 4. copy to clipbaord
-- 5. make money!!!!
--

local run_command = function(cmd)
  return vim.fn.system(cmd)
end

local get_sha = function()
  return run_command({ "git", "rev-parse", "HEAD" })
end

local get_git_root = function()
  -- removes the \n character at the end
  return run_command({ "git", "rev-parse", "--show-toplevel" }):match("[^/]+$"):gsub("\n", "")
end

local get_filepath = function()
  -- full file path
  return vim.fn.expand('%:p')
end

local get_repo_info = function()
  local git_url = run_command({ "git", "remote", "get-url", "origin" }):gsub("\n", "")
  -- print(git_url)
  -- parse url
  if git_url:find("https://") then
    local owner = git_url:match("github.com/([^/]+)")
    local repo = git_url:match("github.com/[^/]+/([^/]+)"):gsub(".git", "")
    -- print(owner, repo)
    return { owner, repo }
  end
  return { nil, nil }
end

local get_filename = function(filepath, git_root)
  -- Derives filename from filepath and git root. removes from final path as root
  -- can be different than the repo name (e.g. git clone into a specific dir)
  -- NOTE: Had issues with the matching because git_root contained \n character
  -- NOTE: Can't get the file path relative to the git root with lua match
  -- print(filepath)
  -- print(git_root)
  -- print(filepath:match(".*(nvim.*)"))
  -- print("^" .. git_root .. "/")
  return filepath:match(".*(" .. git_root .. ".*)"):gsub("^" .. git_root .. "/", "")
end

-- debug
-- print('sha: ' .. get_sha())
-- print('git root: ' .. get_git_root())
-- print('line number: ' .. vim.fn.line('.'))
-- print('file name: ' .. get_filename(get_filepath(), get_git_root()))
-- local repo_info = get_repo_info()
-- print('git repo info: ' .. repo_info[1])
-- print('git repo info: ' .. repo_info[2])
--
-- print(run_command({ "git", "rev-parse", "--show-toplevel" }))

M.get_remotelink = function()
  local line_number = vim.fn.line('.')
  local protocol = 'https://'
  -- this could be controlled by env variable (or setting from setup)
  local domain = 'github.com'
  local repo_info = get_repo_info()
  local owner = repo_info[1]
  local repo = repo_info[2]
  local sha = get_sha()
  local git_root = get_git_root()
  local filepath = get_filepath()
  local filename = get_filename(filepath, git_root)


  local remotelink = protocol ..
      domain .. '/' .. owner .. '/' .. repo .. '/blob/' .. sha .. '/' .. filename .. '#L' .. line_number

  return remotelink
end

-- print(M.get_remotelink())

M.setup = function(opts)
  opts = opts or {}

  -- Define a command
  vim.api.nvim_create_user_command(
    'RemoteLink',
    function()
      local remotelink = M.get_remotelink()
      -- copy variable to unnamedplus register
      vim.fn.setreg('+', remotelink)
      return M.get_remotelink()
    end,
    { desc = 'Run MyPluginCommand' }
  )
end

M.setup()

return M
