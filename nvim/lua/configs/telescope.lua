local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["qq"] = actions.close,
				["|<CR>"] = actions.file_vsplit,
				["_<CR>"] = actions.file_split,
			},
		},
		file_ignore_patters = {
			".git/",
		},
		preview = {
			filesize_hook = function(filepath, bufnr, opts)
				local max_bytes = 10000
				local cmd = { "head", "-c", max_bytes, filepath }
				require("telescope.previewers.utils").job_maker(cmd, bufnr, opts)
			end,
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		file_browser = {
			grouped = true,
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("project")
telescope.load_extension("fzf")
