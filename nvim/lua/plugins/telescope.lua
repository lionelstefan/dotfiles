local M = {}

function M.setup()
	local telescope = require "telescope"
	local actions = require("telescope.actions")

	telescope.setup{
		defaults = {
			mappings = {
				i = {
					["qq"] = actions.close,
					["|<CR>"] = actions.file_vsplit,
					["_<CR>"] = actions.file_split
				},
			},
			file_ignore_patters = {
				"node_modules"
			}
		}
	}

	telescope.load_extension "file_browser"
	telescope.load_extension "project"
end

return M
