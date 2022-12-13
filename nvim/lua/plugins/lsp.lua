local on_attach = function( client, bufnr )
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = {
        noremap=true,
        silent=true,
	}

    require("illuminate").on_attach(client)
	buf_set_keymap('n', 'kf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require("cmp")
-- require("luasnip.loaders.from_vscode").load()
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

require("lspconfig").jsonls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
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
	filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "htmldjango", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" }
}
