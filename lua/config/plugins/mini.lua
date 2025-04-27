return {
  "echasnovski/mini.nvim",
  version = false,
  -- enabled=false,
  config = function()
    -- local statusline = require("mini.statusline")
    -- statusline.setup({ use_icons = true })

    require("mini.pairs").setup({})
    require("mini.surround").setup({})
    require("mini.files").setup({})

    -- require('mini.git').setup({})
  end,
}
