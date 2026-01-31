-- simplify colorscheme
-- the below autocommand runs after the colorscheme is set
-- makes the background a bit lighter than in the theme

local colorscheme = "default"

-- use the below as an example to change different highlight groups to adjust existing colorscheme/theme
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = colorscheme,
--   callback = function()
--     -- gray_bg is aligned with "backgroung" colour of Ghostty theme
--     local gray_bg = "#14161b"
--     local lighter_gray = "#23272f"
--
--     local set_hl = vim.api.nvim_set_hl
--
--     local gray_bg_hg_groups = {
--       "Normal",
--       "NormalNC",
--       "EndOfBuffer",
--     }
--     for _, hg_group in pairs(gray_bg_hg_groups) do
--       set_hl(0, hg_group, { bg = gray_bg })
--     end
--
--     local lighter_gray_hg_groups = {
--       "CursorLine",
--       "NormalFloat",
--     }
--     for _, hg_group in pairs(lighter_gray_hg_groups) do
--       set_hl(0, hg_group, { bg = lighter_gray })
--     end
--
--     set_hl(0, "VertSplit", {
--       fg = "#141414",
--       bg = "NONE",
--     })
--   end,
-- })

vim.cmd.colorscheme(colorscheme)
