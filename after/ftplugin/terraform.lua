-- options dedicated to .tf files
local set = vim.opt_local

set.shiftwidth = 2

-- https://neovim.discourse.group/t/commentstring-for-terraform-files-not-set/4066
-- fixes "gcc" (commenting code) not working for terraform because "commentstring" is not set
vim.bo.commentstring = "# %s"
