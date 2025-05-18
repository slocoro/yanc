-- TODO:
-- fix start screen shortcuts (pressing f doesn't work as it tries to use telescope)
-- add live_grep that allows excluding files using -- https://github.com/ibhagwan/fzf-lua/issues/167

-- this makes Ghostty show the working dir as tab name
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true
  vim.opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"
end

-- order matters
require("config.lazy") -- plugin loading happens here
require("config.lsp")
require("config.autocommands")
require("config.colorschemes")
require("config.options")
require("config.keymaps")
require("config.remotelink").setup()
