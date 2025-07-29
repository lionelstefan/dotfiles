local colors = {
	bg = "#282828",
	fg = "#fbf1c7",
	yellow = "#f9bd2a",
	gray = "#7c6f64",
	dark_gray = "#3c3836",
	green = "#a9b665",
	orange = "#f28534",
	blue = "#7daea3",
	purple = "#d3869b",
	scrollbar = "#665c54",
}

local signs = {
	Error = " ",
	Warn = " ",
	Hint = "󰌵 ",
	Info = " ",
}

local signConf = {
	text = {},
	texthl = {},
	numhl = {},
}

for type, icon in pairs(signs) do
	local severityName = string.upper(type)
	local severity = vim.diagnostic.severity[severityName]
	local hl = "DiagnosticSign" .. type
	signConf.text[severity] = icon
	signConf.texthl[severity] = hl
	signConf.numhl[severity] = hl
end

vim.diagnostic.config({
	virtual_text = false,
	signs = signConf,
	underline = true,
	severity_sort = true,
})

-- NEOVIM LSPCONFIG
require("lspconfig")

local on_attach = function(client, bufnr)
	local opts = {
		buffer = bufnr,
		noremap = true,
		silent = true,
	}
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	vim.lsp.inlay_hint.enable(true, { bufnr })

	-- Hover
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local buftype = vim.bo[bufnr].buftype
	if bufname ~= "" and buftype == "" then
		-- Only apply these capabilities for real files

		-- snippetSupport
		if
			client.server_capabilities.completionProvider
			and client.server_capabilities.completionProvider.triggerCharacters
		then
			client.server_capabilities.completionProvider.resolveProvider = true
		end

		-- colorProvider
		client.server_capabilities.colorProvider = {
			dynamicRegistration = false,
		}

		-- dynamicRegistration (for top-level capabilities)
		client.server_capabilities.dynamicRegistration = true

		-- codeActionProvider
		client.server_capabilities.codeActionProvider = true

		-- foldingRange
		client.server_capabilities.foldingRangeProvider = {
			dynamicRegistration = false,
			lineFoldingOnly = false,
		}

		-- Optional debug print
		print("🧠 Enhanced capabilities applied for:", client.name, bufname)
	end

	print("LSP attached!")
end

local handlers = {
	["textDocument/signatureHelp"] = vim.lsp.buf.signature_help, {
	  border = "rounded",
	},
	["textDocument/publishDiagnostics"] = function(err, result, ctx)
		require("ts-error-translator").translate_diagnostics(err, result, ctx)
		vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
	end,
}
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("phpactor", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "php" },
})

vim.lsp.config("html", {
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

vim.lsp.config("bashls", {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "zsh" },
})

vim.lsp.config("jsonls", {
	capabilities = capabilities,
	handlers = handlers,
	on_attach = on_attach,
	settings = require("configs.lsp.servers.jsonls").settings,
})

vim.lsp.config("lua_ls", {
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

vim.lsp.config("cssls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("vue_ls", {
	filetypes = require("configs.lsp.servers.vuels").filetypes,
	handlers = handlers,
	init_options = require("configs.lsp.servers.vuels").init_options,
	on_attach = require("configs.lsp.servers.vuels").on_attach,
	settings = require("configs.lsp.servers.vuels").settings,
})

-- vim.lsp.config('ts_ls', {
--   filetypes = require("configs.lsp.servers.tsserver").filetypes,
--   init_options = require("configs.lsp.servers.tsserver").init_options,
--   capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
--   handlers = require("configs.lsp.servers.tsserver").handlers,
--   on_attach = require("configs.lsp.servers.tsserver").on_attach,
--   settings = require("configs.lsp.servers.tsserver").settings,
-- })

vim.lsp.config("vtsls", {
	before_init = require("configs.lsp.servers.vtsls").before_init,
	handlers = handlers,
	filetypes = require("configs.lsp.servers.vtsls").filetypes,
	capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
	settings = require("configs.lsp.servers.vtsls").settings,
	on_attach = require("configs.lsp.servers.vtsls").on_attach,
})

vim.lsp.config("ruff", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

vim.lsp.config("svelte", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "svelte" },
})

vim.lsp.config("tailwindcss", {
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

vim.lsp.config("gopls", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

vim.lsp.config("marksman", {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "markdown" },
})

vim.lsp.config("vue_ls", {
	filetypes = require("configs.lsp.servers.vuels").filetypes,
	init_options = require("configs.lsp.servers.vuels").init_options,
	on_attach = require("configs.lsp.servers.vuels").on_attach,
	on_init = require("configs.lsp.servers.vuels").on_init,
})

-- MASON LSPCONFIG

local mason = require("mason")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"dockerls",
		"docker_compose_language_service",
		"lua_ls",
		"dotls",
		"html",
		"biome",
		"marksman",
		"phpactor",
		"ruff",
		"yamlls",
		"jsonls",
		"vue_ls",
		"vtsls",
	},
})
