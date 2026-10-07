-- migrate lsp config to v0.11 spec (https://www.youtube.com/watch?v=oBiBEx7L000)

-- the lsp gets configured nvim/lsp/<lsp-name>.lua
-- or it uses the configs from nvim-lspconfig if not provided (assuming plugin is installed)
vim.lsp.enable({
  "bashls",
  "clangd",
  "csharp_ls",
  "cssls",
  "dockerls",
  "gopls",
  "html",
  "lua_ls",
  "pyrefly",
  "sqlls",
  "terraformls",
  "vtsls",
  "yamlls",
})

-- for debugging
-- vim.lsp.set_log_level(vim.log.levels.DEBUG)
-- vim.lsp.log.set_format_func(vim.inspect)

local symbol_attribute_kinds = {
  Field = true,
  Property = true,
  Variable = true,
}

local function lsp_symbols_without_attributes()
  require("fzf-lua").lsp_document_symbols({
    regex_filter = function(item)
      return not symbol_attribute_kinds[item.kind]
    end,
  })
end

-- define lsp related keymaps in here so that they are only available if lsp is attached
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

    -- -- add border to hover menu
    -- -- https://www.reddit.com/r/neovim/comments/1gdgz5x/customize_lsp_hover_window/
    -- local function bordered_lsp_buf_hover()
    --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --     border = "single",
    --   })
    --   vim.lsp.buf.hover()
    -- end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Open Hover Menu" }))

    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

    vim.keymap.set(
      "n",
      "go",
      require("fzf-lua").lsp_document_symbols,
      vim.tbl_extend("force", bufopts, { desc = "View document symbols" })
    )
    vim.keymap.set(
      "n",
      "<leader>go",
      lsp_symbols_without_attributes,
      vim.tbl_extend("force", bufopts, { desc = "View document symbols without attributes" })
    )

    -- add border to signature help
    -- https://www.reddit.com/r/neovim/comments/1gdgz5x/customize_lsp_hover_window/
    -- local function bordered_lsp_buf_signature_help()
    --   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    --     border = "single",
    --   })
    --   vim.lsp.buf.signature_help()
    -- end

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
  end,
})
