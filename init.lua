-- TODO:
-- improve time to open files (quite slow to open first py at the moment, subsequent ones are ok, could be because first file starts lsp?)

-- this makes Ghostty show the working dir as tab name
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.remotelink").setup()
