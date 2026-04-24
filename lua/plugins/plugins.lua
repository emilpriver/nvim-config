-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

local lspconfig = require("lspconfig")

return {
  -- themes
  { "ellisonleao/gruvbox.nvim" },
  { "olimorris/onedarkpro.nvim" },
  { "sainnhe/everforest" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },

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

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },

  -- context
  { "nvim-treesitter/nvim-treesitter-context" },

  -- disable notify
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  -- Svelte
  { "evanleck/vim-svelte" },
  { "pangloss/vim-javascript" },
  { "HerringtonDarkholme/yats.vim" },

  -- Disable Noice
  {
    "folke/noice.nvim",
    enabled = false,
  },

  -- Elixir
  "mhanberg/elixir.nvim",
  "elixir-editors/vim-elixir",

  -- Golang functions
  "ray-x/go.nvim",
  "fatih/vim-go",
  -- Git
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({})
    end,
  },

  { "f-person/git-blame.nvim" },

  -- Zig
  { "ziglang/zig.vim" },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
  },

  -- fff.nvim - fast file finder with frecency
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    keys = {
      {
        "ff",
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
      {
        "sg",
        function()
          require("fff").live_grep()
        end,
        desc = "LiFFFe grep",
      },
      {
        "fz",
        function()
          require("fff").live_grep({
            grep = { modes = { "fuzzy", "plain" } },
          })
        end,
        desc = "Live fuzzy grep",
      },
      {
        "fc",
        function()
          require("fff").live_grep({
            query = vim.fn.expand("<cword>"),
          })
        end,
        desc = "Search current word",
      },
    },
  },

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
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(
          function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
            vim.keymap.set(
              "n",
              "<leader>cR",
              "TypescriptRenameFile",
              { desc = "Rename File", buffer = buffer }
            )
          end
        )
      end,
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rust",
        "go",
        "elixir",
        "eex",
        "heex",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- add tsx and treesitter
        ensure_installed = {
          "tsx",
          "typescript",
        },
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col =
          unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- rust crates
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
  -- Preview
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        default_mappings = true,
      })
    end,
  },

  {
    "gleam-lang/gleam.vim",
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-x>",
            accept_word = false,
            accept_line = false,
            next = "<C-n>",
            prev = "<C-p>",
            dismiss = "<C-]>",
          },
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
    end,
  },

  {
    "ocaml/vim-ocaml",
  },

  "reasonml-editor/vim-reason-plus",

  "tyrannicaltoucan/vim-deep-space",

  "gleam-lang/gleam.vim",

  "shaunsingh/nord.nvim",

  -- {
  --   "kristijanhusak/vim-dadbod-ui",
  --   dependencies = {
  --     { "tpope/vim-dadbod", lazy = true },
  --     {
  --       "kristijanhusak/vim-dadbod-completion",
  --       ft = { "sql", "mysql", "plsql" },
  --       lazy = true,
  --     },
  --   },
  --   cmd = {
  --     "DBUI",
  --     "DBUIToggle",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --   },
  --   init = function()
  --     -- Your DBUI configuration
  --     vim.g.db_ui_use_nerd_fonts = 1
  --   end,
  -- },
  --
  "othree/html5.vim",
  "pangloss/vim-javascript",
  "evanleck/vim-svelte",

  {
    "iamcco/markdown-preview.nvim",
    cmd = {
      "MarkdownPreviewToggle",
      "MarkdownPreview",
      "MarkdownPreviewStop",
    },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },

  {
    "alex35mil/pi.nvim",
    dependencies = { "HakonHarnes/img-clip.nvim" },
    opts = {
      diff = {
        keys = {
          accept = "<Leader>da",
          reject = "<Leader>dr",
          expand_context = "<Leader>de",
          shrink_context = "<Leader>ds",
        },
      },
      zen = {
        keys = {
          toggle = { "<M-z>", modes = { "n", "i" } },
          exit = { { "<Esc>", modes = "n" } },
        },
      },
    },
    keys = {
      {
        "<Leader>pp",
        function()
          vim.cmd("Pi layout=side")
        end,
        desc = "Pi side",
        mode = { "n", "v" },
      },
      {
        "<Leader>pf",
        function()
          vim.cmd("Pi layout=float")
        end,
        desc = "Pi float",
        mode = { "n", "v" },
      },
      {
        "<Leader>pl",
        function()
          vim.cmd("PiToggleLayout")
        end,
        desc = "Pi toggle layout",
        mode = { "n", "v" },
      },
      {
        "<Leader>pc",
        function()
          vim.cmd("PiContinue")
        end,
        desc = "Pi continue last session",
        mode = { "n", "v" },
      },
      {
        "<Leader>pr",
        function()
          vim.cmd("PiResume")
        end,
        desc = "Pi resume past session",
        mode = { "n", "v" },
      },
      {
        "<Leader>pm",
        function()
          vim.cmd("PiSendMention")
        end,
        desc = "Pi mention file/selection",
        mode = { "n", "v" },
      },
      {
        "<Leader>pa",
        function()
          vim.cmd("PiAttention")
        end,
        desc = "Pi open next attention request",
        mode = { "n", "v" },
      },
      {
        "<Leader>pq",
        function()
          vim.cmd("PiStop")
        end,
        desc = "Pi stop and close",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local pi = require("pi")
      pi.setup(opts)

      local group = vim.api.nvim_create_augroup(
        "pi-keymaps",
        { clear = true }
      )
      local function map(buf, key, action, modes)
        vim.keymap.set(
          modes or { "n", "i", "v" },
          key,
          action,
          { buffer = buf }
        )
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = {
          "pi-chat-history",
          "pi-chat-prompt",
          "pi-chat-attachments",
        },
        callback = function(event)
          map(event.buf, "<C-q>", "<Cmd>PiToggleChat<CR>")
          map(event.buf, "<M-c>", "<Cmd>PiAbort<CR>")
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "pi-chat-history",
        callback = function(event)
          map(event.buf, "<S-Down>", pi.focus_chat_prompt)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "pi-chat-prompt",
        callback = function(event)
          map(event.buf, "<S-Up>", pi.focus_chat_history)
          map(
            event.buf,
            "<S-Down>",
            pi.focus_chat_attachments
          )
          map(event.buf, "<C-Up>", function()
            pi.scroll_chat_history("up", 2)
          end)
          map(event.buf, "<C-Down>", function()
            pi.scroll_chat_history("down", 2)
          end)
          map(event.buf, "<M-m>", pi.cycle_model)
          map(event.buf, "<M-M>", pi.select_model)
          map(event.buf, "<M-t>", pi.cycle_thinking_level)
          map(event.buf, "<M-T>", pi.select_thinking_level)
          map(event.buf, "<M-n>", pi.new_session)
          map(event.buf, "<M-x>", pi.compact)
          map(event.buf, "<C-v>", pi.paste_image)

          -- Tab to trigger completion for / commands
          -- When typing /, Tab will show command completions
          map(event.buf, "<Tab>", function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.fn.col(".")
            local cur_text = line:sub(1, col)

            -- If we're after a / on the first line, trigger pi completion
            if
              vim.fn.line(".") == 1 and cur_text:match("^/")
            then
              -- Use the native omnifunc for pi completions
              local completefunc = require(
                "pi.completion.omnifunc"
              ).completefunc
              vim.fn.complete(col + 1, completefunc(0, "/"))
            else
              -- Otherwise let blink.cmp handle it normally
              vim.cmd('execute "normal! \\<Tab>"')
            end
          end, { "i" })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "pi-chat-attachments",
        callback = function(event)
          map(event.buf, "<S-Up>", pi.focus_chat_prompt)
          map(event.buf, "<C-v>", pi.paste_image)
        end,
      })
    end,
  },

  -- Configure blink.cmp for pi.nvim @mentions and /commands completion
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "pi" },
        providers = {
          pi = {
            name = "Pi",
            module = "pi.completion.blink",
          },
        },
      },
    },
  },

  -- tua.nvim — local dev build of a native Neovim coding agent
  {
    dir = "/Users/emilpriver/code/tau.nvim",
    name = "tau.nvim",
    lazy = false,
    config = function()
      require("tau").setup({
        plugins = { "plugin.opencode-go" },
      })
    end,
  },
}
