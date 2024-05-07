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

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions

	-- local map = vim.keymap.set
	-- local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- map('n', '<space>e', vim.diagnostic.open_float, bufopts)
	-- map('n', '[d', vim.diagnostic.goto_prev, bufopts)
	-- map('n', ']d', vim.diagnostic.goto_next, bufopts)
	-- map('n', '<space>q', vim.diagnostic.setloclist, bufopts)
	--
	-- map('n', 'gD', vim.lsp.buf.declaration, bufopts)
	-- map('n', 'gd', vim.lsp.buf.definition, bufopts)
	-- map('n', 'K', vim.lsp.buf.hover, bufopts)
	-- map('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- map('n', '<space>wl', function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	-- map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	-- map('n', 'gr', vim.lsp.buf.references, bufopts)
	-- map('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities({
-- 	dynamicRegistration = true
-- })

local capabilities = require("cmp_nvim_lsp").default_capabilities({
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
})

require("lspconfig").eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"svelte",
		"astro",
	},
})

require("lspconfig").intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "php" },
	settings = {
		intelephense = {
			filetypes = { "php" },
			format = {
				enable = true,
				braces = "allman",
			},
		},
	},
})

require("lspconfig").html.setup({
	-- on_attach = on_attach,
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

require("lspconfig").bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
})

require("lspconfig").jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("neodev").setup()

require("lspconfig").lua_ls.setup({
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

require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").vuels.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "vue" },
	cmd = { "/home/stefanlionel/.nvm/versions/node/v20.7.0/bin/vls" },
})

require("lspconfig").biome.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"astro",
		"svelte",
		"vue",
	},
})

local tsserver_capabilities = require("cmp_nvim_lsp").default_capabilities({
	dynamicRegistration = true,
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
})

require("lspconfig").tsserver.setup({
	init_options = { hostInfo = "neovim" },
	cmd = { "typescript-language-server", "--stdio" },
	on_attach = on_attach,
	capabilities = tsserver_capabilities,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
})

require("lspconfig").ruff_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

require("lspconfig").svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "svelte" },
})

require("lspconfig").tailwindcss.setup({
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

require("lspconfig").gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

require("lspconfig").marksman.setup({
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
