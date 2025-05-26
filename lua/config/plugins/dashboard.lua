-- taken from https://github.com/adibhanna/nvim/blob/main/lua/plugins/alfa-nvim.lua
return {
  "goolord/alpha-nvim",
  enabled = true,
  event = "VimEnter",
  lazy = true,
  -- persistence needs to be loaded separately for plugin to work
  -- specifying as dependency isn't enough
  -- dependencies = "folke/persistence.nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    -- from: https://github.com/eric-parsons/dotfiles/blob/78aedf6e80faa6fb5d000fb0642411ceb23978bb/.config/nvim/lua/plugins/alpha.lua#L13C1-L22C10
    dashboard.section.header.val = {
      "⠀⠀⠀⣾⣿⣿⣿⣿⣦⡀⢸⣿⣿⣿⣿⠃⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⢸⣿⣿⣿⣿⡄⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⡿⢁⣿⣿⣿⣿⡇⠀⣸⣿⣿⣿⣿⣷⣄⠀⢀⣴⣿⣿⣿⣿⡟",
      "⠀⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠟⠸⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠇⠘⠿⠿⠿⠿⠇⠀⠀⠀⠰⠿⠿⠿⠿⠿⠟⠀⠸⠿⠿⠿⠿⠀⠀⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠇",
      "⠀⠀⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀⢠⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡆⠀⣰⣶⣶⣶⡶⠀⠀⠀⣶⣶⣶⣶⡆⠀⣶⣶⣶⣶⣶⠀⢀⣶⣶⣶⣶⣶⡶⠀⠀⠀⣶⣶⣶⣶⡆⠀⢰⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⠀",
      "⠀⢰⣿⣿⣿⣿⠉⠻⣿⣿⣿⣿⣿⡟⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⠇⠀⠀⢸⣿⣿⣿⣿⠀⠀⢸⣿⣿⣿⣿⣧⣾⣿⣿⣿⣿⠟⠁⠀⠀⢸⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⠇⠙⢿⣿⠟⢹⣿⣿⣿⣿⡇⠀",
      "⠀⣾⣿⣿⣿⡟⠀⠀⢸⣿⣿⣿⣿⠃⢠⣿⣿⣿⣿⡿⠉⠉⠉⠉⠉⠉⠀⢸⣿⣿⣿⡿⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⢸⣿⣿⣿⣿⠀⠀⠈⠁⠀⣼⣿⣿⣿⡿⠀⠀",
      "⢠⣿⣿⣿⣿⠁⠀⠀⣿⣿⣿⣿⡿⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⢸⣿⣿⣿⣷⣶⣶⣾⣿⣿⣿⡟⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⣸⣿⣿⣿⣿⠁⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⢰⣿⣿⣿⣿⠇⠀⠀",
      "⣼⣿⣿⣿⡏⠀⠀⢸⣿⣿⣿⣿⡇⢀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡟⠀⢸⣿⣿⣿⣿⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⠀⠀⠀",
      "",
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", "<cmd>lua require('fzf-lua').files()<cr>"),
      -- dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", "<cmd>lua require('fzf-lua').oldfiles()<cr>"),
      dashboard.button("g", " " .. " Find text", "<cmd>lua require('fzf-lua').live_grep()<CR>"),
      dashboard.button("s", " " .. "Restore Session", "<cmd>lua require('persistence').load()<cr>"),
      -- dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/ <CR>"),
      -- dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
