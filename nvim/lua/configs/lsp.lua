vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level('debug')

local lspconfig = require("lspconfig")
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
	local opts = {
		noremap = true,
		silent = true,
	}

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	vim.lsp.inlay_hint.enable(true, { bufnr })

	print("LSP attached!")
end

require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.textDocument.colorProvider = { dynamicRegistration = false }
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			-- lspconfig.eslint.setup({
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   filetypes = {
			--     "javascript",
			--     "javascriptreact",
			--     "javascript.jsx",
			--     "typescript",
			--     "typescriptreact",
			--     "typescript.tsx",
			--     "vue",
			--     "svelte",
			--     "astro",
			--   },
			-- })

			-- vim.lsp.enable("biome")
			-- lspconfig.biome.setup({
			--   cmd = { "biome", "lsp-proxy" },
			--   on_attach = on_attach,
			--   capabilities = capabilities,
			--   filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
			-- })

			lspconfig.phpactor.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "php" },
			})

			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "html" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
			})

			lspconfig.bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "bash-language-server", "start" },
				filetypes = { "sh", "zsh" },
			})

			lspconfig.jsonls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			require("lazydev").setup()

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				settings = {
					cmd = {
						'"/home/lionelstefan/homebrew/bin/lua-language-server" "$@"',
					},
					runtime = {
						version = "LuaJIT",
					},
					format = {
						enable = true,
						defaultConfig = {
							indent_style = "space",
							indent_size = "2",
						},
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.vls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- local tsserver_capabilities = require("cmp_nvim_lsp").default_capabilities({
			--   dynamicRegistration = true,
			--   textDocument = {
			--     foldingRange = {
			--       dynamicRegistration = false,
			--       lineFoldingOnly = true,
			--     },
			--   },
			-- })

			lspconfig.ts_ls.setup({
				init_options = { hostInfo = "neovim" },
				cmd = { "typescript-language-server", "--stdio" },
				on_attach = on_attach,
				capabilities = tsserver_capabilities,
				filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
			})

			lspconfig.ruff.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "python" },
			})

			lspconfig.svelte.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "svelte" },
			})

			lspconfig.tailwindcss.setup({
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"aspnetcorerazor",
					"astro",
					"astro-markdown",
					"clojure",
					"django-html",
					"htmldjango",
					"edge",
					"eelixir",
					"elixir",
					"ejs",
					"erb",
					"eruby",
					"gohtml",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"html-eex",
					"heex",
					"jade",
					"leaf",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
			})

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
			})

			lspconfig.marksman.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "markdown" },
			})

			require("ufo").setup({
				open_fold_hl_timeout = 100,
				fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
					local newVirtText = {}
					local suffix = (" 󰁂 %d "):format(endLnum - lnum)
					local sufWidth = vim.fn.strdisplaywidth(suffix)
					local targetWidth = width - sufWidth
					local curWidth = 0
					for _, chunk in ipairs(virtText) do
						local chunkText = chunk[1]
						local chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if targetWidth > curWidth + chunkWidth then
							table.insert(newVirtText, chunk)
						else
							chunkText = truncate(chunkText, targetWidth - curWidth)
							local hlGroup = chunk[2]
							table.insert(newVirtText, { chunkText, hlGroup })
							chunkWidth = vim.fn.strdisplaywidth(chunkText)
							-- str width returned from truncate() may less than 2nd argument, need padding
							if curWidth + chunkWidth < targetWidth then
								suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
							end
							break
						end
						curWidth = curWidth + chunkWidth
					end
					table.insert(newVirtText, { suffix, "MoreMsg" })
					return newVirtText
				end,
			})
		end,
	},
})
