-- TODO: reorganise colorschemes based on
-- https://github.com/jdhao/nvim-config/blob/8cba1ba234604069cee272eb55649203c21d9dde/init.lua
return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme("tokyonight-moon")
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>tm", ToggleDarkMode, vim.tbl_extend("force", opts, { desc = "[t]oggle dark[m]ode" }))
    end,
    lazy = false,
    priority = 1000,
  },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   -- config = function()
  --   --   require("rose-pine").setup({
  --   --     variant = "dawn", -- auto, main, moon, or dawn
  --   --   })
  --   --   vim.cmd("colorscheme rose-pine")
  --   -- end,
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   -- config = function()
  --   --   vim.cmd.colorscheme("kanagawa-wave")
  --   -- end,
  --   -- lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "navarasu/onedark.nvim",
  --   -- config = function()
  --   --   require("onedark").setup({ style = "dark" })
  --   --   vim.cmd.colorscheme("onedark")
  --   -- end,
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     -- (remember, lazy "installs" the plugin (i.e. downloads the code
  --     -- it doesn't actually set the color theme which is why it's set
  --     -- in the config function)
  --     -- vim.g.gruvbox_material_enable_italic = true
  --     -- vim.cmd.colorscheme("gruvbox-material")
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   lazy = false,
  --   name = "catppuccin",
  --   priority = 1000,
  --   -- config = function()
  --   --   vim.cmd.colorscheme("catppuccin-frappe")
  --   -- end,
  -- },
}
