return {
  {
    "lukas-reineke/indent-blankline.nvim",
    -- See `:help ibl`
    main = "ibl",
    opts = {
      scope = { enabled = false },
      -- indent = { char = "|" },
      -- indent = { char = "⏐" },
      -- thinner vertical bad than default
      indent = { char = "┊" },
    },
  },
}
