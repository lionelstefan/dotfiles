local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup()

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/.local/vscode-php-debug/out/phpDebug.js" },
}

dap.adapters["pwa-node"] = function(callback)
  local port = 8123
  local handle
  local pid_or_err
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local js_debug_path = os.getenv("HOME") .. "/.local/vscode-php-debug/out/phpDebug.js"

  handle, pid_or_err = vim.loop.spawn("node", {
    args = { js_debug_path, "--server=" .. port },
    stdio = { nil, stdout, stderr },
    detached = true
  }, function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print("js-debug exited with code", code)
      end
    end)

  assert(handle, "Error running js-debug adapter: " .. tostring(pid_or_err))

  stdout:read_start(function(err, chunk)
    if err then
      print("stdout error", err)
      return
    end
    if chunk then
      -- Uncomment for debugging: print(chunk)
    end
  end)

  stderr:read_start(function(err, chunk)
    if err then
      print("stderr error", err)
      return
    end
    if chunk then
      print("js-debug stderr: ", chunk)
    end
  end)

  -- Call the callback with the server config after a short delay
  vim.defer_fn(function()
    callback({
      type = "server",
      host = "127.0.0.1",
      port = port
    })
  end, 300)
end

dap.configurations.php = {
	{
		name = "listen for Xdebug docker",
		type = "php",
		request = "launch",
		hostname = "localhost",
		port = 9003,
		pathMappings = {
			["/var/www/html"] = "${workspaceFolder}",
		},
	},
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to process",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch TS",
    runtimeExecutable = "ts-node",
    runtimeArgs = {
      "--loader",
      "ts-node/esm",
    },
    program = "${file}",
    cwd = "${workspaceFolder}",
    protocol = "inspector",
    console = "integratedTerminal",
    sourceMaps = true,
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**"
    },
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

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

vim.keymap.set("n", "<F5>", require("dap").continue)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)
vim.keymap.set("n", "bp", require("dap").toggle_breakpoint)

require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = os.getenv("HOME") .. "/.local/share/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "chrome", "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug/" .. "src/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- DAP UI
dapui.setup()

vim.keymap.set("n", "<leader>d", dapui.toggle)
