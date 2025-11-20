-- config in here gets combined with config from nvim-lspconfig
return {
  settings = {
    python = {
      pyrefly = {
        -- https://github.com/facebook/pyrefly/issues/1240
        -- without this you need to configure pyrefly in pyproject.toml for each project
        displayTypeErrors = "force-on",
      },
    },
  },
}
