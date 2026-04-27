local map = vim.keymap.set

map("n", "<leader>ap", "<cmd>AvanteAsk position=right<CR>", { desc = "Side panel" })
map("n", "<leader>al", "<cmd>AvanteToggle<CR>", { desc = "Toggle panel" })
map("n", "<leader>aq", "<cmd>AvanteToggle<CR>", { desc = "Close panel" })
map("n", "<leader>ar", "<cmd>AvanteChat<CR>", { desc = "Resume chat" })
map("n", "<leader>an", "<cmd>AvanteChatNew<CR>", { desc = "New chat" })
map("n", "<leader>ac", "<cmd>AvanteFocus<CR>", { desc = "Focus chat" })
map("n", "<leader>ah", "<cmd>AvanteHistory<CR>", { desc = "Chat history" })
map("n", "<leader>aa", "<cmd>AvanteStop<CR>", { desc = "Abort response" })
map("n", "<leader>ak", "<cmd>AvanteSwitchProvider<CR>", { desc = "Switch provider" })
map("n", "<leader>aM", function()
  local avante = require("avante")
  local sidebar = avante.get()
  if not sidebar or not sidebar:is_open() then
    avante.toggle()
  end
  vim.defer_fn(function()
    vim.cmd("AvanteACPModels")
  end, 300)
end, { desc = "Select ACP model" })
