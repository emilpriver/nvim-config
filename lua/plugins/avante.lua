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

    keys = {
      { "<leader>aa", function() require("avante.api").ask() end, desc = "Ask", mode = { "n", "v" } },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "Edit", mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "Refresh" },
      { "<leader>ap", "<cmd>AvanteAsk position=right<CR>", desc = "Side panel" },
      { "<leader>al", "<cmd>AvanteToggle<CR>", desc = "Toggle panel" },
      { "<leader>aq", "<cmd>AvanteToggle<CR>", desc = "Close panel" },
      { "<leader>aC", "<cmd>AvanteChat<CR>", desc = "Resume chat" },
      { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New chat" },
      { "<leader>ac", "<cmd>AvanteFocus<CR>", desc = "Focus chat" },
      { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Chat history" },
      { "<leader>ab", function() require("avante.api").add_selected_file(vim.api.nvim_buf_get_name(0)) end, desc = "Add current buffer" },
      { "<leader>aB", function() require("avante.api").add_buffer_files() end, desc = "Add all buffers" },
      { "<leader>ax", "<cmd>AvanteStop<CR>", desc = "Abort response" },
      { "<leader>ak", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch provider" },
      { "<leader>aM", function()
        local avante = require("avante")
        local sidebar = avante.get()
        if not sidebar or not sidebar:is_open() then
          avante.toggle()
        end
        vim.defer_fn(function()
          vim.cmd("AvanteACPModels")
        end, 300)
      end, desc = "Select ACP model" },
    },

    opts = {
      debug = false,
      instructions_file = "avante.md",

      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      disabled_tools = {
        "list_files",
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",
      },

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
