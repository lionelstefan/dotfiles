local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
	enabled = function()
		local context = require "cmp.config.context"
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment")
				and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				treesitter = "[Treesitter]"
			})[entry.source.name]
			return vim_item
		end,
		-- format = lspkind.cmp_format({
		-- 	mode = "symbol",
		-- 	menu = ({
		-- 		nvim_lsp = "[LSP]",
		-- 		luasnip = "[Snippet]",
		-- 		buffer = "[Buffer]",
		-- 		path = "[Path]",
		-- 		treesitter = "[Treesitter]"
		-- 	})
		-- })
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ["<Tab>"] = cmp.mapping.complete(),
		["<Esc>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			select = true,
		},
		["<Down>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end,
		["<Up>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "treesitter" },
	})
}

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" }
	}
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" }
	}, {
		{ name = "cmdline" }
	})
})

local npairs = require("nvim-autopairs")
local autopair_rule = require("nvim-autopairs.rule")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cond = require'nvim-autopairs.conds'
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done()
)

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
	autopair_rule(' ', ' ')
		:with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({
				brackets[1][1] .. brackets[1][2],
				brackets[2][1] .. brackets[2][2],
				brackets[3][1] .. brackets[3][2],
			}, pair)
		end)
}

for _, bracket in pairs(brackets) do
	npairs.add_rules {
		autopair_rule(bracket[1] .. ' ', ' ' .. bracket[2])
			:with_pair(function() return false end)
			:with_move(function(opts)
				return opts.prev_char:match('.%' .. bracket[2]) ~= nil
			end)
			:use_key(bracket[2])
	}
end

for _, punct in pairs { ",", ";" } do
	npairs.add_rules {
		autopair_rule("", punct)
			:with_move(function(opts) return opts.char == punct end)
			:with_pair(function() return false end)
			:with_del(function() return false end)
			:with_cr(function() return false end)
			:use_key(punct)
	}
end

npairs.add_rules {
	autopair_rule('=', '')
		:with_pair(cond.not_inside_quote())
		:with_pair(function(opts)
			local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
			if last_char:match('[%w%=%s]') then
				return true
			end
			return false
		end)
		:replace_endpair(function(opts)
			local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
			local next_char = opts.line:sub(opts.col, opts.col)
			next_char = next_char == ' ' and '' or ' '
			if prev_2char:match('%w$') then
				return '<bs> =' .. next_char
			end
			if prev_2char:match('%=$') then
				return next_char
			end
			if prev_2char:match('=') then
				return '<bs><bs>=' .. next_char
			end
			return ''
		end)
		:set_end_pair_length(0)
		:with_move(cond.none())
		:with_del(cond.none())
}
