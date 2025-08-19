-- Diagnostics configuration
-- Signs, virtual text, and diagnostic display settings

local M = {}

-- Guard to prevent duplicate sign definition
local signs_defined = false

function M.setup()
  if signs_defined then
    return
  end

  -- Define diagnostic signs
  local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn", text = "▲" },
    { name = "DiagnosticSignHint", text = "⚑" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  signs_defined = true

  -- Configure diagnostic display
  vim.diagnostic.config({
    virtual_text = {
      enabled = true,
      source = "if_many",
      prefix = "●",
      spacing = 4,
    },
    signs = {
      enabled = true,
      priority = 10,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })
end

-- Auto-setup on module load
M.setup()

return M