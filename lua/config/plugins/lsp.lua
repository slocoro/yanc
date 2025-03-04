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
      {
        "saghen/blink.cmp",
      },
    },
    opts = {
      servers = {
        lua_ls = {},
        pyright = {},
        terraformls = {},
        ts_ls = {},
        dockerls = {},
        bashls = {},
        clangd = {},
        html = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      -- pass config to each lsp
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      local toggle_diagnostics = function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        -- this autocommand runs after every LspAttach event inside Neovim
        -- callback function receives one arg, "event-data" which contains
        -- data about the event
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          -- debug
          -- print('ID of client attached to LSP: ' .. args.data.client_id)

          local bufopts = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            vim.tbl_extend("force", bufopts, { desc = "Go to Declaration" })
          )
          vim.keymap.set(
            "n",
            "gd",
            -- vim.lsp.buf.definition,
            require("telescope.builtin").lsp_definitions,
            vim.tbl_extend("force", bufopts, { desc = "Go to Definition" })
          )
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Open Hover Menu" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "go", function()
            require("telescope.builtin").lsp_document_symbols({ ignore_symbols = "variable" })
          end, { desc = "View Document Symbols (outline)" })
          -- ("go", require("telescope.builtin").lsp_type_definitions, "Type Definition")
          vim.keymap.set(
            "n",
            "<C-k>",
            vim.lsp.buf.signature_help,
            vim.tbl_extend("force", bufopts, { desc = "Open Hover Menu" })
          )
          -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", bufopts, { desc = "LSP rename" })
          )
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", bufopts, { desc = "LSP code action" })
          )
          vim.keymap.set(
            "n",
            "gr",
            require("telescope.builtin").lsp_references,
            -- vim.lsp.buf.references,
            vim.tbl_extend("force", bufopts, { desc = "LSP references" })
          )

          vim.keymap.set(
            "n",
            "<leader>td",
            toggle_diagnostics,
            vim.tbl_extend("force", bufopts, { desc = "LSP [t]oggle [d]iagnostics" })
          )
          -- if client.supports_method("textDocument/formatting") and vim.bo.filetype == "lua" then
          --   -- or use this condition that checks what file type the current buffer has
          --   -- if vim.bo.filetype == "lua" then
          --   -- format current buffer on save (just before we write a buffer)
          --   -- only listen to those events inside this current buffer
          --   -- (that's why we use "buffer = args.buf")
          --   vim.api.nvim_create_autocmd("BufWritePre", {
          --     buffer = args.buf,
          --     -- not passing "args" to function below because it's available
          --     -- in the scope of the enclosing function
          --     callback = function()
          --       vim.lsp.buf.format({
          --         bufbr = args.buf,
          --         id = client.id,
          --         formatting_options = { insert_final_newline = true }, -- doesn't work
          --         async = false,
          --       })
          --     end,
          --   })
          -- end
        end,
      })
    end,
  },
}
