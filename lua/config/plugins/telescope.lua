-- plugins/telescope.lua:
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local theme = require("telescope.themes").get_ivy({})

      require("telescope").setup({
        defaults = vim.tbl_extend("force", theme, {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            -- search hidden files
            "--hidden",
            -- but don't search the below hidden files
            "--glob=!.git/",
            "--glob=!**/.git/**",
            "--glob=!**/.venv/**",
          },
        }),
        -- },
      })

      -- set individual themes for pickers
      -- pickers = {
      --   find_files = {
      --     theme = theme
      --   },
      --   live_grep = {
      --     theme = theme
      --   },
      --   buffers = {
      --     theme = theme
      --   },
      --   help_tags = {
      --     theme = theme
      --   },
      -- }
      -- })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true })
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })

      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Telescope key maps" })

      vim.keymap.set("n", "<leader>en", function()
        -- local opts = require('telescope.themes').get_ivy({
        --   cwd = vim.fn.stdpath('config')
        -- })
        -- print(opts)
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Telescope nvim config" })

      -- "ivy" changes to theme of the window, pops up from the bottom
      -- vim.keymap.set('n', '<leader>ff', function()
      --     local opts = require('telescope.themes').get_ivy({})
      --     print(opts)
      --     builtin.find_files(opts)
      --   end,
      --   { desc = 'Telescope find files' }
      -- )
      -- vim.keymap.set('n', '<leader>fg', function()
      --     local opts = require('telescope.themes').get_ivy({})
      --     print(opts)
      --     builtin.live_grep(opts)
      --   end,
      --   { desc = 'Telescope live grep' }
      -- )
      -- vim.keymap.set('n', '<leader>fb', function()
      --     local opts = require('telescope.themes').get_ivy({})
      --     print(opts)
      --     builtin.buffers(opts)
      --   end,
      --   { desc = 'Telescope buffers' }
      -- )
      -- vim.keymap.set('n', '<leader>fh', function()
      --     local opts = require('telescope.themes').get_ivy({})
      --     print(opts)
      --     builtin.help_tags(opts)
      --   end,
      --   { desc = 'Telescope help tags' }
      -- )
      -- vim.keymap.set('n', '<leader>en', function()
      --     local opts = require('telescope.themes').get_ivy({
      --       cmw = vim.fn.stdpath('config')
      --     })
      --     print(opts)
      --     builtin.find_files(opts)
      --   end,
      --   { desc = 'Telescope nvim config' }
      -- )
    end,
  },
}
