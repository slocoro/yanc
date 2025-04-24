-- TODO:
-- build nvim from source
-- update to newest version

-- this makes Ghostty show the working dir as tab name
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

require("config.lazy")
require("config.autocommands")
require("config.colorschemes")
require("config.options")
require("config.keymaps")
require("config.remotelink").setup()
