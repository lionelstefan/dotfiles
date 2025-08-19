require("avante").setup({
  provider = "copilot",
  selector = {
    provider = "fzf_lua",
    provider_opts = {},
  },
  input = {
    provider = "snacks",
    provider_opts = {},
  },
  windows = {
    position = "right",
    wrap = true,
    width = 40,
    sidebar_header = {
      enabled = true,
      align = "center",
      rounded = true,
    },
  },
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = true,
    minimize_diff = true,
  },
})