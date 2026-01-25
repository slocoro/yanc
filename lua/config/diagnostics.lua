local diagnostic_config = {
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
}

local toggle_virtual_text = function()
  local current_conf = vim.diagnostic.config().virtual_text

  if current_conf then
    vim.diagnostic.config({ virtual_text = false })
    print("Virtual Text Off")
  else
    vim.diagnostic.config(diagnostic_config)
    print("Virtual Text On")
  end
end

local toggle_diagnostics = function()
  local is_enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(not is_enabled, { bufnr = 0 })
  print("Diagnostics " .. (is_enabled and "Disabled" or "Enabled"))
end

vim.diagnostic.config(diagnostic_config)

vim.keymap.set(
  "n",
  "<leader>td",
  toggle_virtual_text,
  { noremap = true, silent = true, desc = "Toggle [t]ext [d]iagnostics" }
)

vim.keymap.set("n", "<leader>yd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics > 0 then
    vim.fn.setreg("+", diagnostics[1].message)
    print("Diagnostic yanked to clipboard")
  end
end, { desc = "[y]ank [d]iagnostic to clipboard" })
