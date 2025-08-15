vim.cmd([[
  filetype plugin indent on
]])

require("core.options")
require("plugins")
require("core.diagnostics")
require("core.keymaps")
require("core.autocmds")

vim.cmd([[
  autocmd User TelescopePreviewerLoaded setlocal number
]])
