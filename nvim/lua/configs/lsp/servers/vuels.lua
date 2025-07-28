local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	client.server_capabilities.document_formatting = false


  local capabilities = require("blink.cmp").get_lsp_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  capabilities.dynamicRegistration = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = false,
  }
  capabilities.codeActionProvider = true
  client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, capabilities or {})
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
      tsdk = os.getenv("HOME") .. '/.local/share/pnpm/global/5/node_modules/typescript/lib',
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

M.on_init = function(client)
  client.handlers['tsserver/request'] = function(_, result, context)
    local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
    if #clients == 0 then
      vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
      return
    end
    local ts_client = clients[1]

    local param = table.unpack(result)
    local id, command, payload = table.unpack(param)
    ts_client:exec_cmd({
      title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
      command = 'typescript.tsserverRequest',
      arguments = {
        command,
        payload,
      },
    }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
  end
end

return M
