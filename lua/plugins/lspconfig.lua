return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        terraformls = {},
        gopls = {},
        tsserver = {},
        zls = {},
        postgres_lsp = {},
        marksman = {},
        gleam = {},
      },
      setup = {},
    },
    dependencies = {},
  },
}
