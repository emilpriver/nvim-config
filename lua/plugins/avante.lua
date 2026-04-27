return {
  -- 🧠 Completion (blink + avante source)
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

  -- 🤖 Avante (AI)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,

    opts = {
      debug = false,
      instructions_file = "avante.md",

      behaviour = {
        auto_set_keymaps = false,
      },

      -- 🔌 Default provider
      provider = "opencode",
      model = "deepseek-v4-pro",

      input = {
        provider = "snacks",
      },

      -- ⚙️ ACP backends
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
          command = "agent",
          args = { "acp" },
          env = {
            CURSOR_API_KEY = os.getenv("CURSOR_API_KEY"),
          },
        },
      },

      -- 🧠 Providers + models
      providers = {
        opencode = {
          __inherited_from = "acp",
          model = "qwen3.6-plus",
        },

        cursor = {
          __inherited_from = "acp",
          model = "composer-2-fast",
        },
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      "ibhagwan/fzf-lua",

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
        ft = { "markdown", "Avante" },
        opts = {
          file_types = { "markdown", "Avante" },
        },
      },
    },
  },
}
