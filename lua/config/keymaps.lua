-- KEYMAPS
local k = vim.keymap
k.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source file" })
k.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute current line" })
k.set("v", "<leader><leader>x", ":lua<CR>")

k.set("i", "jj", "<ESC>")

-- Escape search mode, remaps <ESC> to sequence of keys+commands
k.set("n", "<ESC>", "<ESC>:noh<CR>")

-- quick fix list
k.set("n", "[q", "<cmd>cprevious<CR>")
k.set("n", "]q", "<cmd>cnext<CR>")
