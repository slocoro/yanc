local toggle_diagnostics = function()
  -- Check if enabled for the current buffer (0)
  local is_enabled = vim.diagnostic.is_enabled({ bufnr = 0 })

  -- Toggle the state for the current buffer
  vim.diagnostic.enable(not is_enabled, { bufnr = 0 })

  -- Optional: Print a message so you know it worked
  print("Diagnostics " .. (is_enabled and "Disabled" or "Enabled"))
end

vim.keymap.set(
  "n",
  "<leader>td",
  toggle_diagnostics,
  { noremap = true, silent = true, desc = "LSP [t]oggle [d]iagnostics" }
)

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = "●",
    spacing = 4,
  },
  virtual_lines = false, -- Split virtual text over multiple lines
  float = false,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.keymap.set("n", "<leader>yd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics > 0 then
    vim.fn.setreg("+", diagnostics[1].message)
    print("Diagnostic yanked to clipboard")
  end
end, { desc = "[y]ank [d]iagnostic to clipboard" })
