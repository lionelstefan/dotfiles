local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv("HOME") .. "/.local/vscode-php-debug/out/phpDebug.js" },
}

dap.configurations.php = {
  {
    name = "listen for Xdebug docker",
    type = "php",
    request = "launch",
    hostname = "localhost",
    port = 9003,
    pathMappings = {
      ["/var/www/html"] = "${workspaceFolder}"
    }
  }
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

-- vim.keymap.set('n', '<F5>', require 'dap'.continue)
-- vim.keymap.set('n', '<F10>', require 'dap'.step_over)
-- vim.keymap.set('n', '<F11>', require 'dap'.step_into)
-- vim.keymap.set('n', '<F12>', require 'dap'.step_out)
-- vim.keymap.set('n', 'bb', require 'dap'.toggle_breakpoint)
