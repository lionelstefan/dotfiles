local actions = require("fzf-lua").actions
local function get_git_root()
  local path = vim.fn.expand("%:p:h")
  while path ~= "/" do
    if vim.fn.isdirectory(path .. "/.git") == 1 then
      return path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return vim.fn.getcwd()
end

require("fzf-lua").setup({
  files = {
    cwd = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
  },
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
  },
  keymap = {
    builtin = {
      ["<PageDown>"] = "preview-page-down",
      ["<PageUp>"]   = "preview-page-up",
    }
  },
  winopts = {
    preview = {
      winopts = {
        number = false
      }
    }
  }
})
