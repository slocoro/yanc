return { {
	'echasnovski/mini.nvim',
	version = false,
	-- enabled=false,
	config = function()
		local statusline = require 'mini.statusline'
		statusline.setup { use_icons = true }
	end
} }
