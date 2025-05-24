return {
  "stevearc/conform.nvim",
  -- lazy load from docs:
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    log_level = vim.log.levels.DEBUG,
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 2500,
    },
    formatters_by_ft = {
      -- go = { 'gofmt' },
      -- rust = { 'rustfmt' },
      bash = { "shfmt", "shellcheck" },
      c = { "clang-format" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "jq" },
      lua = { "stylua" },
      python = { "black" },
      sh = { "shfmt", "shellcheck" },
      yaml = { "yq" },
      zsh = { "shfmt", "shellcheck" },
    },
    formatters = {
      shfmt = {
        -- couldn't get this to work with pre/append and inherit=true
        -- command had -i 4 at the end which caused the indentation to be 4
        inherit = false,
        command = "shfmt",
        args = { "-i", "2", "-ci", "-sr", "-filename", "$FILENAME" },
      },
    },
  },
}
