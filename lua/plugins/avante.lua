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

    -- 🔑 Keymaps (auto which-key integration)
    keys = {
      { "<leader>a", group = "Avante" },

      -- UI
      {
        "<leader>ap",
        "<cmd>AvanteAsk position=right<CR>",
        desc = "Side panel",
      },
      {
        "<leader>af",
        "<cmd>AvanteAsk position=float<CR>",
        desc = "Floating window",
      },
      {
        "<leader>al",
        "<cmd>AvanteToggle<CR>",
        desc = "Toggle panel",
      },
      {
        "<leader>aq",
        "<cmd>AvanteToggle<CR>",
        desc = "Close panel",
      },

      -- Chat lifecycle
      {
        "<leader>ar",
        "<cmd>AvanteChat<CR>",
        desc = "Resume chat",
      },
      {
        "<leader>an",
        "<cmd>AvanteChatNew<CR>",
        desc = "New chat",
      },
      {
        "<leader>ac",
        "<cmd>AvanteFocus<CR>",
        desc = "Focus chat",
      },
      {
        "<leader>ah",
        "<cmd>AvanteHistory<CR>",
        desc = "Chat history",
      },
      {
        "<leader>aa",
        "<cmd>AvanteStop<CR>",
        desc = "Abort response",
      },

      -- AI config
      {
        "<leader>ak",
        "<cmd>AvanteSwitchProvider<CR>",
        desc = "Switch provider",
      },
    },

    opts = {
      debug = false,
      instructions_file = "avante.md",

      -- 🔌 Default provider
      provider = "opencode",

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
          command = "cursor-agent",
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
          model = "minimax-m2.7",
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
        ft = { "markdown", "Avante" },
        opts = {
          file_types = { "markdown", "Avante" },
        },
      },
    },
  },
}
