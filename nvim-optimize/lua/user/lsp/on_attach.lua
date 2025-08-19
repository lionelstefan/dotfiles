-- LSP on_attach function
-- Buffer-local keymaps and LSP-specific setup

local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  -- LSP keymaps
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gr", vim.lsp.buf.references, "Show references")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
  map("n", "K", vim.lsp.buf.hover, "Show hover")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
  map("i", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("v", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  
  -- Diagnostics
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
  map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostic loclist")

  -- Workspace folders
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")

  -- Formatting (if supported)
  if client.supports_method("textDocument/formatting") then
    map("n", "<leader>f", function()
      require("user.lsp.formatting").format()
    end, "Format document")
  end

  -- Range formatting (if supported)
  if client.supports_method("textDocument/rangeFormatting") then
    map("v", "<leader>f", function()
      require("user.lsp.formatting").format()
    end, "Format selection")
  end

  -- Attach navic if available
  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok and client.supports_method("textDocument/documentSymbol") then
    navic.attach(client, bufnr)
  end

  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

return M