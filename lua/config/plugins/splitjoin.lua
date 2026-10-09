return {
  "Wansmer/treesj",
  keys = {
    {
      "gS",
      function()
        require("treesj").split()
      end,
      desc = "Split node",
    },
    {
      "gJ",
      function()
        require("treesj").join()
      end,
      desc = "Join node",
    },
    {
      "gT",
      function()
        require("treesj").toggle()
      end,
      desc = "Toggle split/join node",
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
    max_join_length = 160,
  },
}
