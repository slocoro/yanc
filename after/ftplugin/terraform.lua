-- https://neovim.discourse.group/t/commentstring-for-terraform-files-not-set/4066
-- fixes "gcc" (commenting code) not working for terraform because "commentstring" is not set
vim.bo.commentstring = "# %s"
