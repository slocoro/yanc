-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- show diagnostics for symbol under cursor
-- https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/5
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    -- TODO: revisit as it doesn't work with tressitter context
    -- -- List of filetypes to ignore when checking for floating windows
    -- -- (if you don't ignore windows from nvim-treesitter-context you won't be able to view diagnostics and context at the same time)
    -- local ignore_float_filetypes = { ["nvim-treesitter-context"] = true }
    --
    -- -- checks for windows with a zindex, if there is any window with z-index not in ignore list return from autocommand
    -- -- prevents having mulitple floating windows
    -- for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    --   local win_config = vim.api.nvim_win_get_config(winid)
    --   if win_config.zindex then
    --     local buf = vim.api.nvim_win_get_buf(winid)
    --     -- TODO: change function call below as deprecated
    --     local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    --     if not ignore_float_filetypes[ft] then
    --       return
    --     end
    --   end
    -- end

    vim.diagnostic.open_float({
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
      border = "single",
    })
  end,
})

-- highlighting of cursor using lsp
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "terraform" or vim.bo.filetype == "terraform-vars" then
      return
    end
    vim.lsp.buf.document_highlight()
  end,
})

-- undo highlighting when moving cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- stop nvim from adding comment leader on newline after commented line
-- see :h fo-table for more info
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- turn off highlighting of TODO (only necessary with themes that define this hgroup?)
-- commands runs after loading colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight clear Todo")
    vim.cmd("highlight link Todo comment")
  end,
})
