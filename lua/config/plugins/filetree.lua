return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  event = "VeryLazy",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
          ".DS_store",
        },
      },
    },
  },
  keys = {
    { "<leader>E", ":Neotree toggle left<CR>", silent = true, desc = "Left File Explorer" },
    { "<leader>e", ":Neotree toggle float<CR>", silent = true, desc = "Float File Explorer" },
  },
}
