return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {

      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup {}

      -- could format through a command but might be nicer to do this
      -- automatically
      -- vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
      vim.api.nvim_create_autocmd('LspAttach', {
        -- this autocommand runs after every LspAttach event inside Neovim
        -- callback function receives one arg, "event-data" which contains
        -- data about the event
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          -- debug
          -- print('ID of client attached to LSP: ' .. args.data.client_id)
          if client.supports_method('textDocument/formatting') then
            -- or use this condition that checks what file type the current buffer has
            -- if vim.bo.filetype == "lua" then
            -- format current buffer on save (just before we write a buffer)
            -- only listen to those events inside this current buffer
            -- (that's why we use "buffer = args.buf")
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              -- not passing "args" to function below because it's available
              -- in the scope of the enclosing function
              callback = function()
                vim.lsp.buf.format({ bufbr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  } }
