-- KEYMAPS
local k = vim.keymap
k.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source file" })
k.set("n", "<leader>x", ":.lua<CR>", { desc = "E[x]ecute current [l]ine" })
k.set("v", "<leader><leader>x", ":lua<CR>")

k.set("i", "jj", "<ESC>")

-- Escape search mode, remaps <ESC> to sequence of keys+commands
k.set("n", "<ESC>", "<ESC>:noh<CR>")

-- quick fix list
k.set("n", "[q", "<cmd>cprevious<CR>")
k.set("n", "]q", "<cmd>cnext<CR>")

-- don't add entry to jumplist when using [ or ]
k.set("n", "}", ":<C-u>execute 'keepjumps norm!' . v:count1 . '}'<CR>", { noremap = true, silent = true })
k.set("n", "{", ":<C-u>execute 'keepjumps norm!' . v:count1 . '{'<CR>", { noremap = true, silent = true })

-- quick save
k.set("n", "WW", "<cmd>w<cr>", { desc = "Save file" })
k.set("n", "WQ", "<cmd>wq<cr>", { desc = "Save file and quit" })

-- yank filename
-- k.set("n", "yf", ":let @+ = expand('%')<CR>", { desc = "[y]ank [f]ile name relative to root", silent = true })
k.set("n", "yp", function()
  -- Get the absolute path
  local path = vim.fn.expand("%:p")
  -- Get the git root or current dir if not in git
  local root = vim.loop.cwd()
  -- This replaces the root part of the string with nothing, leaving the relative path
  local relative = path:sub(#root + 2)
  vim.fn.setreg("+", relative)
  print("Yanked: " .. relative)
end, { desc = "[y]ank [p]ath relative to Project Root" })
