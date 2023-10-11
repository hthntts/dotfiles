vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', {fg='#E06C75'})
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', {fg='#56B6C2'})
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', {fg='#E5C07B'})
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', {fg='#3B4252'})
vim.api.nvim_set_hl(0, 'DiagnosticSignError', {fg='#E06C75'})
vim.api.nvim_set_hl(0, 'DiagnosticSignHint', {fg='#56B6C2'})
vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', {fg='#E5C07B'})
vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', {fg='#3B4252'})

local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    -- virtual_text = {
    --   prefix = " ❯❯❯",
    --   spacing = 0,
    -- },
    -- signs = true,
    underline = true,
    virtual_improved = {
      severity = nil, -- Same usage as virtual_text.severity
      spacing = 0, -- Same usage as virtual_text.spacing
      prefix = ' ❯❯❯', -- Same usage as virtual_text.prefix
      suffix = '', -- Same usage as virtual_text.suffix
      current_line = 'only', -- Current Line: 'only', 'hide', 'default'
      code = nil, -- Show diagnostic code.
    },
  }
)


-- -- Show line diagnostics automatically in hover window 1 -----------------------
-- vim.o.updatetime = 500
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- -- Show line diagnostics automatically in hover window 2 -----------------------
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
-- vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = 'rounded',
--       -- border = 'single',
--       -- border = 'double',
--       -- border = 'shadow',
--       source = 'always',
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end
-- })

require('lspconfig').pyright.setup {}
require('lspconfig').bashls.setup {}
require('lspconfig').ansiblels.setup{}
