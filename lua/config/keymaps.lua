-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- This file is automatically loaded by lazyvim.config.initial
--
-- This file is automatically loaded by lazyvim.config.init
--

local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = "Hover types" }
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, bufopts)
vim.keymap.set(
  "n",
  "<leader>cg",
  "<cmd>lua vim.lsp.buf.declaration()<CR>",
  { noremap = true, silent = true, desc = "Jump to declaration" }
)
vim.keymap.set(
  "n",
  "<leader>cG",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true, desc = "Jump to definition" }
)
