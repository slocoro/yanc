-- test function
-- can be run using :lua MyTestFunc()
MyTestFunc = function()
  print("hello from MyTestFunc")
end

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- highlighting of cursor using lsp
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})
-- undo highlighting when moving cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- this makes Ghostty show the working dir as tab name
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

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
require("config.keymaps")
require("config.remotelink").setup()
