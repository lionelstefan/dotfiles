vim.lsp.set_log_level("debug")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	local opts = {
		noremap = true,
		silent = true,
	}

	require("illuminate").on_attach(client)
	buf_set_keymap('n', 'kf', '<cmd>lua vim.lsp.buf.format{async = true}<CR>', opts)
	buf_set_keymap('v', 'kf', '<cmd>lua vim.lsp.buf.format{async = true}<CR>', opts)
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities({
-- 	dynamicRegistration = true
-- })

local capabilities = require('cmp_nvim_lsp').default_capabilities({
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
	}
})

	require("lspconfig").intelephense.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		intelephense = {
			format = {
				enable = true,
				braces = "allman"
			}
		}
	}
}

require("lspconfig").html.setup {
	-- on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true
		},
		provideFormatter = true
	}
}

require("lspconfig").bashls.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
	cmd          = { "bash-language-server", "start" },
	filetypes    = { "sh", "zsh" }
}

require("lspconfig").jsonls.setup {
	on_attach    = on_attach,
	capabilities = capabilities,
}

require("neodev").setup()

require("lspconfig").lua_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		cmd = {
			'"/home/lionelstefan/homebrew/bin/lua-language-server" "$@"'
		},
		runtime = {
			version = 'LuaJIT',
		},
		format = {
			enable = true,
			defaultConfig = {
				indent_style = "space",
				indent_size = "2",
			}
		},
		diagnostics = {
			globals = { 'vim' },
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = {
			enable = false,
		},
		Lua = {
			completion = {
				callSnippet = "Replace"
			}
		}
	}
}

require("lspconfig").cssls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

require("lspconfig").vls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "vue" },
	cmd = {"/home/stefanlionel/.nvm/versions/node/v20.7.0/bin/vls"}
}

local tsserver_capabilities = require('cmp_nvim_lsp').default_capabilities({
	dynamicRegistration = true,
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
	}
})

require("lspconfig").tsserver.setup {
	init_options = { hostInfo = 'neovim' },
	cmd = { 'typescript-language-server', '--stdio' },
	on_attach = on_attach,
	capabilities = tsserver_capabilities,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}

require("lspconfig").pyright.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" }
}

require("lspconfig").svelte.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "svelte" }
}

require("lspconfig").tailwindcss.setup {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge",
		"eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex",
		"jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "razor", "slim", "twig", "css",
		"less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript",
		"typescript", "typescriptreact", "vue", "svelte" }
}

require("lspconfig").gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" }
}

require("lspconfig").marksman.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "markdown" }
}

