local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade",
}

require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"blade",
		"bash",
		"go",
		"php",
		"json",
		"html",
		"css",
		"javascript",
		"tsx",
		"scss",
		"typescript",
		"yaml",
		"python",
		"svelte",
		"lua",
		"vue",
		"query",
		"regex",
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
	endwise = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})

require("ts_context_commentstring").setup {
	enable_autocmd = false
}

require("treesitter-context").setup({
	enable = false,
})
