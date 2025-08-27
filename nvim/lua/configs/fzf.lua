local actions = require("fzf-lua").actions

require("fzf-lua").setup({
	files = {
		cwd_prompt = true,
    path_shorten = 3,
	},
	actions = {
		files = {
			["enter"] = actions.file_edit_or_qf,
			["|"] = actions.file_vsplit,
		},
	},
	fzf_colors = {
		["fg"] = { "fg", "NormalFloat" },
		["bg"] = { "bg", "Normal" },
		["fg+"] = { "fg", "BlinkCmpKindVariable" },
		["bg+"] = { "bg", "Normal" },
	},
	keymap = {
		builtin = {
			["<PageDown>"] = "preview-page-down",
			["<PageUp>"] = "preview-page-up",
		},
	},
	winopts = {
		preview = {
      default     = 'bat',
			winopts = {
				number = false,
			},
		},
	},
  previewers = {
    bat = {
      cmd  = "bat",
      args = "--color=always --style=numbers --theme=gruvbox-dark",
    }
  }
})
