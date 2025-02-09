return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    -- scroll = { enabled = true },
    lazygit = { configure = false },
  },
  keys = {
    {
      "<leader>lg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Open [L]azy[g]it",
    },
  },
}
