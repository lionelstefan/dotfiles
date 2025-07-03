local M = {}

local filter = require("configs.lsp.utils.filter").filter
local filterReactDTS = require("configs.lsp.utils.filterReactDTS").filterReactDTS

local handlers = {
  ["textDocument/hover"] = function()
    return vim.lsp.buf.hover({
      silent = true,
      border = "rounded",
    })
  end,

  ["textDocument/signatureHelp"] = function()
    return vim.lsp.buf.signature_help({
      border = "rounded",
    })
  end,

  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = true }
  ),

  ["textDocument/definition"] = function(err, result, method, ...)
    if vim.islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
    end
    return vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
  end,
}

local settings = {
  -- Performance settings
  separate_diagnostic_server = true,
  publish_diagnostic_on = "insert_leave",
  tsserver_max_memory = "auto",

  -- Formatting preferences (from default_format_options)
  tsserver_format_options = {
    insertSpaceAfterCommaDelimiter = true,
    insertSpaceAfterConstructor = false,
    insertSpaceAfterSemicolonInForStatements = true,
    insertSpaceBeforeAndAfterBinaryOperators = true,
    insertSpaceAfterKeywordsInControlFlowStatements = true,
    insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
    insertSpaceBeforeFunctionParenthesis = false,
    insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
    insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
    insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
    insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
    insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
    insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
    insertSpaceAfterTypeAssertion = false,
    placeOpenBraceOnNewLineForFunctions = false,
    placeOpenBraceOnNewLineForControlBlocks = false,
    semicolons = "ignore",
    indentSwitchCase = true,
  },

  -- File preferences (combining your inlay hints with default preferences)
  tsserver_file_preferences = {
    -- Your current inlay hint settings
    includeInlayParameterNameHints = "all",
    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    includeInlayFunctionParameterTypeHints = true,
    includeInlayVariableTypeHints = false,
    includeInlayVariableTypeHintsWhenTypeMatchesName = false,
    includeInlayPropertyDeclarationTypeHints = false,
    includeInlayFunctionLikeReturnTypeHints = false,
    includeInlayEnumMemberValueHints = true,

    -- Important default preferences
    quotePreference = "auto",
    importModuleSpecifierEnding = "auto",
    jsxAttributeCompletionStyle = "auto",
    allowTextChangesInNewFiles = true,
    providePrefixAndSuffixTextForRename = true,
    allowRenameOfImportPath = true,
    includeAutomaticOptionalChainCompletions = true,
    provideRefactorNotApplicableReason = true,
    generateReturnInDocTemplate = true,
    includeCompletionsForImportStatements = true,
    includeCompletionsWithSnippetText = true,
    includeCompletionsWithClassMemberSnippets = true,
    includeCompletionsWithObjectLiteralMethodSnippets = true,
    useLabelDetailsInCompletionEntries = true,
    allowIncompleteCompletions = true,
    displayPartsForJSDoc = true,
    disableLineTextInReferences = true,
  },

  -- Feature settings
  expose_as_code_action = "all",
  complete_function_calls = false,
  include_completions_with_insert_text = true,
  code_lens = "implementations_only",
}

local on_attach = function(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr })
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

local init_options = {
  plugins = {
    {
      name = "@vue/typescript-plugin",
      location = "/home/lionelstefan/.local/share/pnpm/global/5/node_modules/@vue/typescript-plugin",
      languages = {"javascript", "typescript", "vue"},
    },
  },
}

local filetypes = {
  "javascript",
  "typescript",
  "vue",
}

M.handlers = handlers
M.settings = settings
M.on_attach = on_attach
M.init_options = init_options
M.filetypes = filetypes

return M
