-- test function
-- can be run using :lua MyTestFunc()
MyTestFunc = function() print("hello from MyTestFunc") end

-- KEYMAPS
local k = vim.keymap
k.set("n", "<space><space>x", "<cmd>source %<CR>")
k.set("n", "<space>x", ":.lua<CR>")
k.set("v", "<space><space>x", ":lua<CR>")

k.set("i", "jj", "<ESC>")

-- Escape search mode, remaps <ESC> to sequence of keys+commands
k.set("n", "<ESC>", "<ESC>:noh<CR>")

-- highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- test autocommand from docs
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
-- 	pattern = {"*.c", "*.h", "*.lua"},
-- 	command = "echo 'Entering a C or C++ file'",
-- })

-- another test autocommand from the docs
-- these are the types of commands plugins expose
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   -- callback = function(ev)
--     --   print(string.format('event fired: %s', vim.inspect(ev)))
--     -- end
--     callback = function()
--         print('hellllllo')
--       end
--     })

require("config.lazy")
require("config.options")
require("config.remotelink")
