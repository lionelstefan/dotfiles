-- local ts = {}
-- function ts.setup()
-- 	require'nvim-treesitter.configs'.setup {
-- 		auto_install = true,
-- 		ensure_installed = {
-- 			"php",
-- 			"json",
-- 			"html",
-- 			"css",
-- 			"javascript",
-- 			"tsx",
-- 			"scss",
-- 			"typescript",
-- 			"yaml",
-- 			"python",
-- 			"svelte",
-- 			"lua"
-- 		},
-- 		context_commentstring = {
-- 			enable = true
-- 		},
-- 		autotag = {
-- 			enable = true,
-- 		},
-- 		highlight = {
-- 			enable = true,
-- 		},
-- 		indent = {
-- 			enable = true,
-- 		},
-- 		rainbow = {
-- 			enable = true,
-- 			extended_mode = true,
-- 			max_file_lines = nil
-- 		}
-- 	}
-- end
--
-- return ts

require'nvim-treesitter.configs'.setup {
	auto_install = true,
	ensure_installed = {
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
	context_commentstring = {
		enable = true
	},
	autotag = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil
	}
}

-- require("treesitter-context").setup {
--	enable = true,
-- }

-- require("nvim-ts-autotag").setup {
--	enable = true
--}

--equire("nvim-autopairs").setup{
--	check_ts = true
--}
