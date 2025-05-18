-- local lspconfig = require("lspconfig")
-- -- pass config to each lsp
-- for server, config in pairs(opts.servers) do
--   -- passing config.capabilities to blink.cmp merges with the capabilities in your
--   -- `opts[server].capabilities, if you've defined it
--   config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
--   lspconfig[server].setup(config)
-- end

vim.lsp.enable({
  "bashls",
  "clangd",
  "cssls",
  "dockerls",
  "html",
  "lua_ls",
  "pyright",
  "terraformls",
})

-- pyright was always using up all of the CPU, the below seems to fix it
-- https://github.com/neovim/neovim/issues/23819
-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
  -- disable lsp watcher. Too slow on linux
  wf._watchfunc = function()
    return function() end
  end
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
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "Go to Declaration" }))

    -- goes to definition or lists them if there are multiple
    vim.keymap.set(
      "n",
      "gd",
      require("fzf-lua").lsp_definitions,
      vim.tbl_extend("force", bufopts, { desc = "Go to Definition" })
    )

    -- add border to hover menu
    -- https://www.reddit.com/r/neovim/comments/1gdgz5x/customize_lsp_hover_window/
    local function bordered_lsp_buf_hover()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })
      vim.lsp.buf.hover()
    end

    vim.keymap.set("n", "K", bordered_lsp_buf_hover, vim.tbl_extend("force", bufopts, { desc = "Open Hover Menu" }))

    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

    -- filter out specific symbols
    -- https://github.com/ibhagwan/fzf-lua/issues/1517
    vim.keymap.set("n", "go", function()
      require("fzf-lua").lsp_document_symbols({ regex_filter = { "Variable", exclude = true } })
    end, { desc = "View Document Symbols (outline)" })

    -- add border to signature help
    -- https://www.reddit.com/r/neovim/comments/1gdgz5x/customize_lsp_hover_window/
    local function bordered_lsp_buf_signature_help()
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
      })
      vim.lsp.buf.signature_help()
    end

    vim.keymap.set(
      "n",
      "<C-k>",
      bordered_lsp_buf_signature_help,
      vim.tbl_extend("force", bufopts, { desc = "Open Hover Menu" })
    )

    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP rename" }))

    vim.keymap.set(
      "n",
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", bufopts, { desc = "LSP code action" })
    )

    vim.keymap.set(
      "n",
      "gr",
      require("fzf-lua").lsp_references,
      vim.tbl_extend("force", bufopts, { desc = "LSP references" })
    )

    vim.keymap.set(
      "n",
      "<leader>td",
      toggle_diagnostics,
      vim.tbl_extend("force", bufopts, { desc = "LSP [t]oggle [d]iagnostics" })
    )
  end,
})
