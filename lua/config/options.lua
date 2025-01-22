-- temp fix for https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

-- Blinking cursor
-- Block in normal/visual mode, line in insert mode
vim.o.guicursor =
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- change the syntaxhighlighting using tree-sitter AST
-- this works for a bit but seems to get overwritten
-- vim.cmd [[hi @function.builtin.lua guifg=yellow]]

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

--  The nvim register called "plus" is synced with the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
-- vim.opt.breakindent = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
-- applies to nvim command bar
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.virtualedit = "block"

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.expandtab = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Show column line
vim.opt.colorcolumn = "88"

-- Minimal number of screen lines to keep above and below the cursor.
-- 999 keeps the cursor centered when scrolling up/down
vim.opt.scrolloff = 10

-- better colour support
vim.opt.termguicolors = true

-- show tabline (easier to see what file you're in imo)
vim.o.showtabline = 2
