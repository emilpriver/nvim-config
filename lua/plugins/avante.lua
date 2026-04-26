return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
    },
    opts = {
      sources = {
        default = {
          "avante",
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
          },
        },
      },
    },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      debug = false,
      instructions_file = "avante.md",
      provider = "opencode",
      input = {
        provider = "snacks",
      },
      acp_providers = {
        opencode = {
          command = "opencode",
          args = { "acp" },
          env = {
            OPENCODE_API_KEY = os.getenv(
              "OPENCODE_API_KEY"
            ),
          },
        },
        cursor = {
          command = "cursor-agent",
          args = { "acp" },
          env = {
            CURSOR_API_KEY = os.getenv("CURSOR_API_KEY"),
          },
        },
      },
      providers = {},
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
