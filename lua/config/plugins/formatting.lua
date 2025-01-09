return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    notify_on_error = false,
    format_on_save = true,
    formatters_by_ft = {
      -- go = { 'gofmt' },
      -- rust = { 'rustfmt' },
      python = { 'black' },
      c = { 'clang_format' },
      lua = { 'stylua' },
      bash = { 'shfmt', 'shellcheck' },
      zsh = { 'shfmt', 'shellcheck' },
      sh = { 'shfmt', 'shellcheck' },
    },
  },
}
