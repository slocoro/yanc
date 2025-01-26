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
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "python",
          "html",
          "css",
        },
        auto_install = true,
        highlight = {
          enable = true,
          -- don't turn treesitter on for very big files
          disable = function(lang, buf)
            -- debug
            -- print(lang)
            -- print(buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
