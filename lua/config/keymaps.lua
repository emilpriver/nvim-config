-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- This file is automatically loaded by lazyvim.config.initial
--
-- This file is automatically loaded by lazyvim.config.init
--

local bufopts = {
  noremap = true,
  silent = true,
  buffer = bufnr,
  desc = "Hover types",
}
local wk = require("which-key")

wk.register({
  t = {
    name = "Tau",
    p = {
      "<cmd>Tau layout=side<CR>",
      "Open tau side panel",
    },
    f = { "<cmd>Tau layout=float<CR>", "Open tau float" },
    l = { "<cmd>TauToggle<CR>", "Toggle tau" },
    c = { "<cmd>TauGoToChat<CR>", "Go to tau chat" },
    h = { "<cmd>TauGoToHistory<CR>", "Go to tau history" },
    r = { "<cmd>TauResume<CR>", "Resume past session" },
    m = { "<cmd>TauModel<CR>", "Select model" },
    a = { "<cmd>TauAbort<CR>", "Abort current turn" },
    z = { "<cmd>TauZen<CR>", "Toggle zen mode" },
    q = { "<cmd>TauClose<CR>", "Close tau chat" },
    t = { "<cmd>TauToggleThinking<CR>", "Toggle thinking" },
  },
}, { prefix = "<leader>" })
