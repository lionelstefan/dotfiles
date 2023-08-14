require 'nvim-treesitter.configs'.setup {
	auto_install = true,
	ensure_installed = {
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
		"lua"
	},
	highlight = {
		enable = true,
		-- disable = { "html" }
	},
	autotag = {
		enable = true
	},
	endwise = {
		enable = true
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = true,
		max_file_lines = nil
	}
}

require('Comment').setup {
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require("treesitter-context").setup {
	enable = true
}
