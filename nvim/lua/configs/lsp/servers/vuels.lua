local M = {}

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  client.server_capabilities.document_formatting = false
end

M.filetypes = {
  'vue'
}

M.init_options = {
  config = {
    css = {},
    emmet = {},
    html = {
      suggest = {},
    },
    javascript = {
      format = {},
    },
    stylusSupremacy = {},
    typescript = {
      format = {},
    },
    vue = {
      hybridMode = false,
    },
    vetur = {
      completion = {
        autoImport = true,
        tagCasing = "kebab",
        useScaffoldSnippets = false,
      },
      format = {
        defaultFormatter = {
          html = "none",
          js = "none",
          ts = "none",
        },
        defaultFormatterOptions = {},
        scriptInitialIndent = false,
        styleInitialIndent = false,
      },
      useWorkspaceDependencies = false,
      validation = {
        script = true,
        style = true,
        template = true,
        templateProps = true,
        interpolation = true,
      },
      experimental = {
        templateInterpolationService = true,
      },
    },
  },
}

M.on_attach = on_attach

return M
