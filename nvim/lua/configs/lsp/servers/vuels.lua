local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	client.server_capabilities.document_formatting = false

	-- Disable LSP semantic tokens (semantic highlighting)
	client.server_capabilities.semanticTokensProvider = nil

end

M.filetypes = {
	"vue",
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

M.on_init = function(client)
	client.handlers["tsserver/request"] = function(_, result, context)
		local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
		if #clients == 0 then
			vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
			return
		end
		local ts_client = clients[1]

		if not result or type(result) ~= "table" or #result < 3 then
			return
		end

		local id, command, payload = table.unpack(result)
		ts_client:exec_cmd({
			title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
			command = "typescript.tsserverRequest",
			arguments = {
				command,
				payload,
			},
		}, { bufnr = context.bufnr }, function(_, r)
			local response_data = { { id, r.body } }
			---@diagnostic disable-next-line: param-type-mismatch
			client:notify("tsserver/response", response_data)
		end)
	end
end

return M
