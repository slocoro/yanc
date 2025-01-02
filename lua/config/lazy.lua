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
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- debug new runtime path
print(vim.inspect(vim.opt.rtp:get()))


-- Setup lazy.nvim
-- when lua encounters a "require" it searches the runtime path for a directory called
-- "lazy" and look for a file called "init.lua" and run it
require("lazy").setup({
  spec = {
    -- {
    -- 	"folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end
    -- },
    {
      'sainnhe/gruvbox-material',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        -- (remember, lazy "installs" the plugin (i.e. downloads the code
        -- it doesn't actually set the color theme which is why it's set
        -- in the config function)
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme('gruvbox-material')
      end
    },
    -- import your plugins
    -- this needs to match the folder structure you use to organise
    -- your plugins, in this case lua/congig/plugins
    { import = "config.plugins" },
  },
})
