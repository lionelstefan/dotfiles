local M = {}

local before_init = function(_, config)
	local vue_language_server_path = vim.fn.stdpath("data")
		.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
	local vue_plugin = {
		name = "@vue/typescript-plugin",
		location = vue_language_server_path,
		languages = { "vue" },
		configNamespace = "typescript",
		enableForWorkspaceTypeScriptVersions = true,
	}
	config.settings.vtsls.tsserver.globalPlugins = { vue_plugin }
end

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
		tsserver = {
			globalPlugins = {
        vue_plugin
      },
		},
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
	},
}

local filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
  client.server_capabilities.document_formatting = false

	-- Disable LSP semantic tokens (semantic highlighting)
	client.server_capabilities.semanticTokensProvider = nil
end

M.settings = settings
M.filetypes = filetypes
M.on_attach = on_attach
M.before_init = before_init

return M
