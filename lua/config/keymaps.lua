-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- This file is automatically loaded by lazyvim.config.initial
--
-- This file is automatically loaded by lazyvim.config.init
--

local wk = require("which-key")

wk.register({
  a = {
    name = "Avante",
    p = { "<cmd>AvanteAsk position=right<CR>", "Open avante side panel" },
    f = { "<cmd>AvanteAsk position=float<CR>", "Open avante float" },
    l = { "<cmd>AvanteToggle<CR>", "Toggle avante" },
    c = { "<cmd>AvanteFocus<CR>", "Focus avante chat" },
    h = { "<cmd>AvanteHistory<CR>", "Avante chat history" },
    r = { "<cmd>AvanteChat<CR>", "Resume/open avante" },
    k = { "<cmd>AvanteSwitchProvider<CR>", "Select avante provider" },
    a = { "<cmd>AvanteStop<CR>", "Abort current avante turn" },
    q = {
      "<cmd>AvanteToggle<CR>",
      "Close avante chat",
    },
    n = {
      "<cmd>AvanteChatNew<CR>",
      "New avante chat",
    },
  },
}, { prefix = "<leader>", mode = { "n", "x" } })

