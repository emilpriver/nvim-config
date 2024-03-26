local cmp = require("cmp")
local lspkind = require("lspkind")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      max_width = 50,
      symbol_map = { Copilot = "" },
    }),
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "emoji", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  },
})

-- lspkind.lua
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
