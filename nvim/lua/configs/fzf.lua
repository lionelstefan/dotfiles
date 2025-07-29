local actions = require("fzf-lua").actions
require("fzf-lua").setup({
	actions = {
    files = {
      ["enter"]       = actions.file_edit_or_qf,
      ["|"]           = actions.file_vsplit,
    }
	},
  fzf_colors = {
    ["fg"]               = { "fg", "NormalFloat" },
    ["bg"]               = { "bg", "Normal" },
    ["fg+"]              = { "fg", "BlinkCmpKindVariable" },
    ["bg+"]              = { "bg", "Normal" },
  }
})
