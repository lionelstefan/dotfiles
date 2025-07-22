local file_path = vim.api.nvim_buf_get_name(0)
local args = {
	-- "fix",
	-- file_path,
	"--allow-risky=yes",
	[[--rules={"@PhpCsFixer":true,"braces_position":{"control_structures_opening_brace":"next_line_unless_newline_at_signature_end"},"multiline_whitespace_before_semicolons":{"strategy":"no_multi_line"},"no_superfluous_phpdoc_tags":{"allow_hidden_params":true,"remove_inheritdoc":true,"allow_mixed":true},"phpdoc_to_return_type":{"scalar_types":false,"union_types":false},"phpdoc_scalar":false}]],
}
local util = require("conform.util")

require("conform").setup({
	formatters_by_ft = {
		blade = { "blade-formatter" },
		lua = { "stylua" },
		python = { "ruff_format" },
		javascript = { "biome", "trim_whitespace", "trim_newlines" },
		javascriptreact = { "biome", "trim_whitespace", "trim_newlines" },
		typescript = { "biome", "trim_whitespace", "trim_newlines" },
		typescriptreact = { "biome", "trim_whitespace", "trim_newlines" },
		json = { "biome", "trim_whitespace", "trim_newlines" },
		html = { "biome", "trim_whitespace", "trim_newlines" },
		css = { "biome", "trim_whitespace", "trim_newlines" },
		vue = { "prettier", "trim_whitespace", "trim_newlines" },
		php = { "php_cs_fixer" },
		rust = { "ast-grep" },
		scss = { "biome", "trim_whitespace", "trim_newlines" },
		yaml = { "yamlft" },
	},
	formatters = {
		formatWithErrors = true,
		injected = {
			options = {
				ignore_errors = true,
			},
		},
		biome = {
			command = util.find_executable({
				"/home/lionelstefan/.local/share/pnpm/biome",
			}, "biome"),
			stdin = true,
			args = {
				"format",
				"--stdin-file-path",
				"$FILENAME",
			},
      cwd = util.root_file({
        "biome.json",
        "biome.jsonc",
      }),
		},
		blade_formatter = {
			args = { "--stdin", "--wrap-attributes aligned-multiple" },
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
