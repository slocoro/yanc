local M = {}

-- TODO:
-- fix this and make it general so that it works with every colorscheme
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

-- TODO:
-- add https://github.com/bluz71/vim-moonfly-colors
M.colorscheme_conf = {
  dracula = function()
    vim.cmd.colorscheme("dracula")
  end,
  tokyonight = function()
    vim.cmd.colorscheme("tokyonight-moon")
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>tm", ToggleDarkMode, vim.tbl_extend("force", opts, { desc = "[t]oggle dark[m]ode" }))
  end,
  onedark = function()
    require("onedark").setup({
      style = "dark",
    })
    vim.cmd.colorscheme("onedark")
  end,
  gruvbox_material = function()
    -- foreground option can be material, mix, or original
    vim.g.gruvbox_material_foreground = "original"
    --background option can be hard, medium, soft
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_better_performance = 1
    vim.cmd.colorscheme("gruvbox-material")
  end,
  -- nightfox = function()
  --   vim.cmd([[colorscheme nordfox]])
  -- end,
  catppuccin = function()
    -- available option: latte, frappe, macchiato, mocha
    vim.g.catppuccin_flavour = "frappe"
    require("catppuccin").setup()

    vim.cmd.colorscheme("catppuccin")
  end,
  kanagawa = function()
    vim.cmd("colorscheme kanagawa-wave")
  end,
  rose_pine = function()
    vim.cmd("colorscheme rose-pine")
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.set_colorscheme = function(colorscheme)
  if not vim.tbl_contains(vim.tbl_keys(M.colorscheme_conf), colorscheme) then
    local msg = "Invalid colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
    return
  end

  -- Load the colorscheme and its settings
  M.colorscheme_conf[colorscheme]()

  if vim.g.logging_level == "debug" then
    local msg = "Colorscheme: " .. colorscheme
    vim.notify(msg, vim.log.levels.DEBUG, { title = "nvim-config" })
  end
end

-- Load a random colorscheme
M.set_colorscheme("onedark")
