-- NEOVIM LSPCONFIG
require("lspconfig")

vim.filetype.add({
	filename = {
		[".zshrc"] = "zsh",
	},
})

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

		-- Disable LSP semantic tokens (semantic highlighting)
		client.server_capabilities.semanticTokensProvider = nil

		-- Disable formatting
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		-- Optional debug print
		print("🧠 Enhanced capabilities applied for:", client.name, bufname)
	end

	print("LSP attached!")
end

local handlers = {
	["textDocument/signatureHelp"] = vim.lsp.buf.signature_help,
	{
		border = "rounded",
	},
	["textDocument/publishDiagnostics"] = function(err, result, ctx)
		require("ts-error-translator").translate_diagnostics(err, result, ctx)
		vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx)
	end,
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

capabilities.textDocument = capabilities.textDocument or {}

capabilities.textDocument.completion = capabilities.textDocument.completion or {}
capabilities.textDocument.completion.completionItem = {
	snippetSupport = true,
}

capabilities.textDocument.colorProvider = {
	dynamicRegistration = false,
}
capabilities.textDocument.formatting = {
	dynamicRegistration = false,
}

capabilities.textDocument.inlayHint = {
	dynamicRegistration = false,
}

capabilities.textDocument.rangeFormatting = {
	dynamicRegistration = false,
	rangesSupport = false,
}

local lsp_started = {}

local function safe_setup(name, config)
	if lsp_started[name] then
		return
	end

	lsp_started[name] = true
	vim.lsp.config(name, config)
end

safe_setup("biome", {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function()
		safe_setup("phpactor", {
      cmd = { 'phpactor', 'language-server' },
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "php" },
		})

		vim.lsp.enable("phpactor")

    safe_setup("intelephense", {
      cmd = { 'intelephense', '--stdio' },
      init_options = {
        licenceKey = "LICENSECODEXXXX"
      },
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "php" },
      settings = {
        intelephense = {
          environment = {
            includePaths = {
              "./vendor",
              "./classes",
              "./controllers",
              "./config",
              "./modules",
              "./override",
            }
          }
        },
      }
    })

    vim.lsp.enable("intelephense")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		safe_setup("html", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "html" },
			init_options = {
				configurationSection = { "html", "css", "javascript" },
				embeddedLanguages = {
					css = true,
					javascript = true,
				},
				provideFormatter = false,
			},
		})

		vim.lsp.enable("html")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "bash",
    "sh",
    "zsh",
  },
	callback = function()
		safe_setup("bashls", {
			filetypes = {
				"bash",
				"sh",
				"zsh",
			},
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "bash-language-server", "start" },
		})

		vim.lsp.enable("bashls")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	callback = function()
		safe_setup("jsonls", {
			on_attach = on_attach,
			capabilities = capabilities,
			handlers = handlers,
			settings = require("configs.lsp.servers.jsonls").settings,
		})

		vim.lsp.enable("jsonls")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldlevelstart = 99
		vim.opt_local.foldenable = true

		safe_setup("lua_ls", {
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "lua-language-server" },
			settings = require("configs.lsp.servers.luals").settings,
		})

		vim.lsp.enable("lua_ls")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "css",
	callback = function()
		safe_setup("cssls", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.lsp.enable("cssls")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		safe_setup("ruff", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.lsp.enable("ruff")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "svelte",
	callback = function()
		safe_setup("svelte", {
			on_attach = on_attach,
			capabilities = capabilities,
		})

		vim.lsp.enable("svelte")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
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
	callback = function()
		safe_setup("tailwindcss", {
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

		vim.lsp.enable("tailwindcss-language-server")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "gomod", "gowork", "gotmpl" },
	callback = function()
		safe_setup("gopls", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
		})

		vim.lsp.enable("gopls")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		safe_setup("marksman", {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "markdown" },
		})

		vim.lsp.enable("markdown")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = require("configs.lsp.servers.vtsls").filetypes,
	callback = function()
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.foldlevel = 99
		vim.opt_local.foldlevelstart = 99
		vim.opt_local.foldenable = true

		safe_setup("vtsls", {
      filetypes = require("configs.lsp.servers.vtsls").filetypes,
			handlers = handlers,
			capabilities = capabilities,
			settings = require("configs.lsp.servers.vtsls").settings,
			on_attach = require("configs.lsp.servers.vtsls").on_attach,
      before_init = require("configs.lsp.servers.vtsls").before_init
		})

		vim.lsp.enable("vtsls")
	end,
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
		"dockerls",
		"docker_compose_language_service",
		"dotls",
		"yamlls",
	},
	automatic_enable = {
		exclude = {
			"biome",
			"phpactor",
			"html",
			"bashls",
			"lua_ls",
			"cssls",
			"ruff",
			"svelte",
			"tailwindcss-language-server",
			"gopls",
			"vtsls",
			"vue_ls",
		},
	},
})
