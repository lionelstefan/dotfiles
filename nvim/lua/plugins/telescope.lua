require("telescope").load_extension "file_browser"
require("telescope").load_extension "project"

local actions = require("telescope.actions")
require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["qq"] = actions.close,
                ["|<CR>"] = actions.file_vsplit,
                ["_<CR>"] = actions.file_split
            },
        }
    }
}
