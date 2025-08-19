local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup()

-- JS/TS debug adapter
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/dapDebugServer.js", "${port}" },
  },
}

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

vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpointColor", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", {
  text = " ",
  texthl = "DapBreakpointConditionColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = " ",
  texthl = "DapBreakpointRejectedColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = " ",
  texthl = "DapLogPointColor",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = " ",
  texthl = "DapStoppedColor",
  linehl = "DapStoppedLine",
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