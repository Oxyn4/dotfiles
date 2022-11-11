-- diagnostics setting
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})



icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum =  "",
  EnumMember = "",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "",
  Interface = "",
  Keyword = " ",
  Method = "ƒ",
  Module = " ",
  Property = " ",
  Snippet = "﬌",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
end
-- change sign colum lsp symbols
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- show floating diagnostics window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
