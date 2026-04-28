return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup({
      config = vim.fn.expand("~/.config/mcphub/servers.json"),
      port = 37373,
      shutdown_delay = 5 * 60 * 1000,
      mcp_request_timeout = 60000,
      auto_approve = false,
      auto_toggle_mcp_servers = true,
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
      ui = {
        window = {
          width = 0.8,
          height = 0.8,
          align = "center",
          relative = "editor",
          zindex = 50,
          border = "rounded",
        },
        wo = {
          winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
        },
      },
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
        prefix = "MCPHub",
      },
    })
  end,
}
