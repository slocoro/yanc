return {
  "stevearc/conform.nvim",
  -- lazy load from docs:
  -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
  event = { "LspAttach", "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function(_, opts)
    -- NOTE: if you use "config" and "opts" you need to do the setup manually
    require("conform").setup(opts)

    -- inspired from the below
    -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    vim.api.nvim_create_user_command("ToggleAutoFormat", function(args)
      if args.bang then
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Buffer autoformat: " .. (vim.b.disable_autoformat and "OFF" or "ON"))
      else
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Global autoformat: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
      end
    end, {
      desc = "Toggle autoformat-on-save (add ! for buffer-local)",
      bang = true,
    })
  end,
  opts = {
    log_level = vim.log.levels.DEBUG,
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 2500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      -- go = { 'gofmt' },
      -- rust = { 'rustfmt' },
      python = {
        -- To fix auto-fixable lint errors.
        "ruff_fix",
        -- To run the Ruff formatter.
        "ruff_format",
        -- To organize the imports.
        "ruff_organize_imports",
      },
      c = { "clang-format" },
      lua = { "stylua" },
      bash = { "shfmt", "shellcheck" },
      zsh = { "shfmt", "shellcheck" },
      sh = { "shfmt", "shellcheck" },
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "biome", "biome-organize-imports" },
      javascriptreact = { "biome", "biome-organize-imports" },
      typescript = { "biome", "biome-organize-imports" },
      typescriptreact = { "biome", "biome-organize-imports" },
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
