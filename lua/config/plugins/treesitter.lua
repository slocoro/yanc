return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- build tells lazy that whenever we update the plugin it should run :TSUpate
    -- makes sure that when new queries get downloaded, the parsers get rebuilt
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "css",
          "html",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true,
          -- don't turn treesitter on for very big files
          disable = function(lang, buf)
            -- debug
            -- print(lang)
            -- print(buf)
            local max_filesize = 1024 * 1024 -- 1 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        modules = {},
        sync_install = true,
        ignore_install = {},
      })
    end,
  },
}
