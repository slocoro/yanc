-- organised based on: https://github.com/jdhao/nvim-config/blob/8cba1ba234604069cee272eb55649203c21d9dde/init.lua
return {
  { "Mofiqul/dracula.nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    -- "name" is required for lazy.lua not to return "nil" when saving
    name = "catppuccin",
    lazy = true,
  },
}
