return {
  "stevearc/conform.nvim",
  -- TODO: figure how to load this at a better time e.g. before saving
  lazy = false,
  opts = {
    log_level = vim.log.levels.DEBUG,
    notify_on_error = false,
    format_on_save = true,
    formatters_by_ft = {
      -- go = { 'gofmt' },
      -- rust = { 'rustfmt' },
      python = { "black" },
      c = { "clang-format" },
      lua = { "stylua" },
      bash = { "shfmt", "shellcheck" },
      zsh = { "shfmt", "shellcheck" },
      sh = { "shfmt", "shellcheck" },
      css = { "prettier" },
      html = { "prettier" },
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
