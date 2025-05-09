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
  playground = {
    enable = true
  },
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
	endwise = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

require("ts_context_commentstring").setup {
	enable_autocmd = true
}

require("treesitter-context").setup({
	enable = true,
})
