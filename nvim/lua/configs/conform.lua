local file_path = vim.api.nvim_buf_get_name(0)
local args = {
	-- "fix",
	-- file_path,
	[[--rules={"@PhpCsFixer":true,"braces_position": {"control_structures_opening_brace": "next_line_unless_newline_at_signature_end" }, "multiline_whitespace_before_semicolons":{"strategy":"no_multi_line"}}]],
}
local util = require("conform.util")

require("conform").setup({
	formatters_by_ft = {
		blade = { "blade-formatter" },
		lua = { "stylua" },
		python = { "ruff_format" },
		javascript = { { "prettierd" } },
		javascriptreact = { { "prettierd" } },
		typescript = { { "prettierd" } },
		typescriptreact = { { "prettierd" } },
		php = { "php_cs_fixer" },
	},
	formatters = {
		injected = {
			options = {
				ignore_errors = true,
			},
		},
		blade_formatter = {
		  args = { "--stdin", "--wrap-attributes aligned-multiple" }
    },
		php_cs_fixer = {
			inherit = false,
			command = util.find_executable({
				"/usr/local/bin/php-cs-fixer",
				"vendor/bin/php-cs-fixer",
			}, "php-cs-fixer"),
			args = args,
		},
	},
})

local php_cs_fixer = require("conform.formatters.php_cs_fixer")
require("conform").formatters.php_cs_fixer = vim.tbl_deep_extend("force", php_cs_fixer, {
	args = util.extend_args(php_cs_fixer.args, args),
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
