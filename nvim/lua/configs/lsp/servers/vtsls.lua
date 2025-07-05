local M = {}

local settings = {
  complete_function_calls = true,
  vtsls = {
    enableMoveToFileCodeAction = true,
    autoUseWorkspaceTsdk = true,
    experimental = {
      maxInlayHintLength = 30,
      completion = {
        enableServerSideFuzzyMatch = true,
      },
    },
  },
  typescript = {
    updateImportsOnFileMove = { enabled = "always" },
    suggest = {
      completeFunctionCalls = true,
    },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = "literals" },
      parameterTypes = { enabled = true },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  },
}

local filetypes = {
  "javascript",
  "typescript",
}

local on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr })
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

M.settings = settings
M.filetypes = filetypes
M.on_attach = on_attach

return M
