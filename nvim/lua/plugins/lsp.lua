
local on_attach = function( client, bufnr )
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = {
        noremap=true,
        silent=true,
	}

	buf_set_keymap('n', 'kf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = {
    'intelephense',
    'html',
    'cssls',
    'jsonls',
    'tsserver'
}

local cmp = require("cmp")
local luasnip = require("luasnip")
require("cmp").setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
	mapping = {
	    ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
          else
            fallback()
          end
        end,
        ['<S-Tab>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
          else
            fallback()
          end
        end,
	},
	sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
	}
})

cmp.setup.cmdline('/', {
	sources = {
        { name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

require("luasnip.loaders.from_vscode").load()
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").intelephense.setup{
    on_attach = on_attach,
    capabilities = capabilities,
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
}
