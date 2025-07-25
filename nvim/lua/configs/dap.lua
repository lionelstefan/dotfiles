local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup()
local js_debug_path = vim.fn.expand("$MASON/packages/js-debug-adapter")

-- dap.adapters.php = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { os.getenv("HOME") .. "/.local/vscode-php-debug/out/phpDebug.js" },
-- }

-- dap.configurations.php = {
-- 	{
-- 		name = "listen for Xdebug docker",
-- 		type = "php",
-- 		request = "launch",
-- 		hostname = "localhost",
-- 		port = 9003,
-- 		pathMappings = {
-- 			["/var/www/html"] = "${workspaceFolder}",
-- 		},
-- 	},
-- }

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

-- dap.configurations.javascript = {
--   {
--     type = "pwa-node",
--     request = "launch",
--     name = "Launch file",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
--   {
--     type = "pwa-node",
--     request = "attach",
--     name = "Attach to process",
--     processId = require("dap.utils").pick_process,
--     cwd = "${workspaceFolder}",
--   },
-- }

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "BACKEND PMS",
    program = "${workspaceFolder}/index.ts",
    runtimeExecutable = "pnpm",
    port = 4000,
    runtimeArgs = {
      "dev",
    },
    skipFiles = {
      "<node_internals>/**",
    },
    env = {
      NODE_ENV = "development",
    },
    cwd = vim.fn.getcwd(),
    console = "integratedTerminal",
    sourceMaps = true,
  },
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

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", {
  text = " ", -- Question mark (for conditional)
  texthl = "DapBreakpointConditionColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = " ", -- Warning/error icon
  texthl = "DapBreakpointRejectedColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = " ", -- Code icon for log points
  texthl = "DapLogPointColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = " ", -- Arrow pointing right for execution point
  texthl = "DapStoppedColor",
  linehl = "DapStoppedLine", -- optional to highlight line
  numhl = "",
})

vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "bp", require("dap").toggle_breakpoint)

-- DAP UI
dapui.setup()

vim.keymap.set("n", "<leader>d", dapui.toggle)
