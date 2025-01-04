-- convention
local M = {}

print("hello from gitpermalink module")

-- get line number
print(vim.fn.line('.'))

-- permalink generated from Zed
-- https://github.com/python/cpython/blob/fcc0a377cfc2fe6683443745739d3b16224d884d/Python/getcompiler.c#L15
-- permaling generated from VScode
-- https://github.je-labs.com/customer-data-science/customer-deduping/blob/54905b5bc2924a6004ea12844bcf35e8288be586/customer_deduping/components/bigquery.py#L17

-- git url examples:
-- git@github.je-labs.com:customer-data-science/customer-deduping.git
-- https://github.com/python/cpython.git

-- flow of generating permalink
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
  print(git_url)
  -- parse url
  if git_url:find("https//:") then
    local owner = git_url:match("github.com/([^/]+)")
    local repo = git_url:match("github.com/[^/]+/([^/]+)")
    return { owner, repo }
  end
  return { nil, nil }
end

local get_filename = function(filepath, git_root)
  -- Derives filename from filepath and git root.
  -- NOTE: Had issues with the matching because git_root contained \n character
  -- NOTE: Can't get the file path relative to the git root with lua match
  -- print(filepath)
  -- print(git_root)
  -- print(filepath:match(".*(nvim.*)"))
  return filepath:match(".*(" .. git_root .. ".*)")
end

-- debug
print('sha: ' .. get_sha())
print('git root: ' .. get_git_root())
print('line number: ' .. vim.fn.line('.'))
print('file name: ' .. get_filename(get_filepath(), get_git_root()))
print('git repo info: ' .. get_repo_info())

print(run_command({ "git", "rev-parse", "--show-toplevel" }))
M.get_permalink = function()
  local line_number = vim.fn.line('.')
  local protocol = 'https://'
  -- this could be controlled by env variable (or setting from setup)
  local domain = 'github.com'
  local owner = ''
  local repo = ''
  local sha = get_sha()
  local git_root = get_git_root()
  local filepath = get_filepath()
  local filename = get_filename(filepath, git_root)


  local permalink = protocol ..
      domain .. '/' .. owner .. '/' .. repo .. '/blob/' .. sha .. '/' .. filename .. '#L' .. line_number

  return permalink
end

print(M.get_permalink())

return M
