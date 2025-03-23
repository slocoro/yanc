-- Bootstrap lazy.nvim
-- Summary: copies the lazy plugin manager source code into "~/.local/share/nvim/lazy/..."
-- returns the path at which nvim stores "data"
-- (things that persist across sessions)
-- then appends "/lazy/..." to it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- checks if the path exists and clones the lazy repo if it doesn't
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- runs a git cli command to clone repo
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- debug new runtime path
-- print(vim.inspect(vim.opt.rtp:get()))

-- leader needs to be set before loading lazy
vim.g.mapleader = ","
vim.g.maplocalleader = ","

ToggleDarkMode = function()
  local colorschemes = {
    dark = "tokyonight-moon",
    light = "tokyonight-day",
  }
  -- somehow when using vim.g.colors_name directly in the if statement it doesn't work
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme == colorschemes.dark then
    vim.cmd.colorscheme(colorschemes.light)
  else
    vim.cmd.colorscheme(colorschemes.dark)
  end
end

-- Setup lazy.nvim
-- when lua encounters a "require" it searches the runtime path for a directory called
-- "lazy" and look for a file called "init.lua" and run it
require("lazy").setup({
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  spec = {
    -- import your plugins
    -- this needs to match the folder structure you use to organise
    -- your plugins, in this case lua/congig/plugins
    { import = "config.themes" },
    { import = "config.plugins" },
  },
})
