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
      -- only list modified files
      -- https://github.com/ibhagwan/fzf-lua/issues/18
      "<leader>fc",
      function()
        require("fzf-lua").git_files({ cmd = "git ls-files --modified" })
      end,
      desc = "Find git files",
    },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Find help tags" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find key maps" },
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume previous find" },
    {
      -- examples of how to filter results:
      -- (requires this option which is set by default https://github.com/ibhagwan/fzf-lua/blob/9a1f4b6f9e37d6fad6730301af58c29b00d363f8/README.md?plain=1#L975)
      -- https://www.reddit.com/r/neovim/comments/1hiwlsu/fzflua_live_grep_how_to_filter_by_path_or_paths/
      -- https://github.com/ibhagwan/fzf-lua/issues/167
      "<leader>fg",
      function()
        require("fzf-lua").live_grep({
          -- includes hidden files while respecting .gitignore
          -- explicitly excludes .git/
          rg_opts = "--hidden -g '!.git' --column --line-number --no-heading --color=always --smart-case",
        })
      end,
      desc = "Live grep",
    },
    -- {
    --   "<leader>fgg",
    --   function()
    --     require("fzf-lua").live_grep_glob({
    --       -- includes hidden files while respecting .gitignore
    --       -- explicitly excludes .git/
    --       rg_opts = "--hidden -g '!.git' --column --line-number --no-heading --color=always --smart-case",
    --     })
    --   end,
    --   desc = "Live grep glob",
    -- },
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
