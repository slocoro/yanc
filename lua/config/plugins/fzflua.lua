return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  command = { "Fzflua" },
  config = {
    fzf_opts = {
      ["--layout"] = "reverse",
    },
  },
  opts = {},
  keys = {
    -- find
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find buffers" },
    {
      "<leader>fc",
      function()
        require("fzf-lua").git_files({ cmd = "git ls-files --modified" })
      end,
      desc = "Find git files",
    },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Find help tags" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find key maps" },
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume previous find" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    {
      "<leader>go",
      function()
        require("fzf-lua").lsp_document_symbols({
          -- regex_filter = symbols_filter,
        })
      end,
      desc = "Goto Symbol",
    },
  },
}
