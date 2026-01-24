return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      theme = {
        -- `bg` color matches gray_bg in colorschemes.lua
        normal = { fg = "#c0caf5", bg = "#14161b" },
      },
    },
  },
  -- { "nvim-treesitter/nvim-treesitter-context", enabled = true, mode = "cursor", max_lines = 3 },
}
