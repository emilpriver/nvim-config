return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              checkOnSave = true,
              check = {
                command = "check",
              },
              diagnostics = {
                enable = true,
              },
              cargo = {
                allFeatures = false,
                loadOutDirsFromCheck = false,
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                chainingHints = { enable = true },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },
      }
    end,
  },
}
