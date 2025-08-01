local M = {}

local settings = {

  cmd = {
    '"' .. os.getenv("HOME") .. '/homebrew/bin/lua-language-server" "$@"',
  },
  runtime = { version = "LuaJIT" },
  format = {
    enable = false,
    defaultConfig = {
      indent_style = "space",
      indent_size = "2",
    },
  },
  diagnostics = {
    globals = { "vim" },
  },
  workspace = {
    library = vim.api.nvim_get_runtime_file("", true),
  },
  telemetry = { enable = false },
  Lua = {
    completion = {
      callSnippet = "Replace",
    },
  },
}

M.settings = settings

return M
