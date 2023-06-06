local on_attach = function( client, bufnr )
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	local opts = {
        noremap=true,
        silent=true,
	}

    require("illuminate").on_attach(client)
	buf_set_keymap('n', 'kf', '<cmd>lua vim.lsp.buf.format{async = true}<CR>', opts)
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").intelephense.setup{
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

require("lspconfig").html.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "html", "php" }
}

require("lspconfig").bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "zsh" }
}

require("lspconfig").jsonls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require("lspconfig").lua_ls.setup{
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
			globals = {'vim'},
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file("", true),
		},
		telemetry = {
			enable = false,
		},
	}
}

require("lspconfig").cssls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require("lspconfig").tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}

require("lspconfig").pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" }
}

require("lspconfig").svelte.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "svelte" }
}

require("lspconfig").tailwindcss.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

require("lspconfig").gopls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod", "gowork", "gotmpl" }
}
