-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/dockerls.lua
return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
}
