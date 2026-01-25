-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- highlighting of cursor using lsp
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    local exclude_ft = {
      ["terraform"] = true,
      ["terraform-vars"] = true,
      ["sql"] = true,
    }
    if exclude_ft[vim.bo.filetype] then
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
