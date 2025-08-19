-- LSP capabilities configuration
-- Merges default LSP capabilities with completion engine capabilities

local M = {}

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- Try to merge with blink.cmp capabilities
  local ok, blink = pcall(require, "blink.cmp")
  if ok then
    capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
  else
    -- Fallback to nvim-cmp if available
    local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_ok then
      capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
    end
  end

  -- Additional capabilities
  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }

  return capabilities
end

return M