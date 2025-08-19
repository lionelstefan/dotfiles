-- Custom user commands
-- High-level commands that abstract plugin boundaries

local M = {}

function M.setup()
  -- Quick session commands
  vim.api.nvim_create_user_command("SessionSave", function()
    require("persistence").save()
    require("user.core.notifications").info("Session saved", "Session")
  end, { desc = "Save current session" })

  vim.api.nvim_create_user_command("SessionLoad", function()
    require("persistence").load()
    require("user.core.notifications").info("Session loaded", "Session")
  end, { desc = "Load session for current directory" })

  -- Quick project search
  vim.api.nvim_create_user_command("ProjectSearch", function(opts)
    if opts.args == "" then
      vim.cmd("Telescope live_grep")
    else
      vim.cmd("Telescope grep_string search=" .. opts.args)
    end
  end, { nargs = "?", desc = "Search in project files" })

  -- Toggle diagnostics
  local diagnostics_enabled = true
  vim.api.nvim_create_user_command("DiagnosticsToggle", function()
    diagnostics_enabled = not diagnostics_enabled
    if diagnostics_enabled then
      vim.diagnostic.enable()
      require("user.core.notifications").info("Diagnostics enabled", "LSP")
    else
      vim.diagnostic.disable()
      require("user.core.notifications").info("Diagnostics disabled", "LSP")
    end
  end, { desc = "Toggle diagnostics display" })

  -- Quick file operations
  vim.api.nvim_create_user_command("CopyPath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    require("user.core.notifications").info("Copied: " .. path, "File")
  end, { desc = "Copy current file path to clipboard" })

  vim.api.nvim_create_user_command("CopyRelativePath", function()
    local path = vim.fn.expand("%:.")
    vim.fn.setreg("+", path)
    require("user.core.notifications").info("Copied: " .. path, "File")
  end, { desc = "Copy relative file path to clipboard" })

  -- Git shortcuts
  vim.api.nvim_create_user_command("GitBlame", function()
    vim.cmd("Gitsigns blame_line")
  end, { desc = "Show git blame for current line" })

  vim.api.nvim_create_user_command("GitDiff", function()
    vim.cmd("Gitsigns diffthis")
  end, { desc = "Show git diff for current file" })

  -- Buffer management
  vim.api.nvim_create_user_command("BufOnly", function()
    vim.cmd("%bdelete|edit#|bdelete#")
    require("user.core.notifications").info("Closed all other buffers", "Buffer")
  end, { desc = "Close all buffers except current" })

  -- LSP shortcuts
  vim.api.nvim_create_user_command("LspRestart", function()
    vim.cmd("LspRestart")
    require("user.core.notifications").info("LSP restarted", "LSP")
  end, { desc = "Restart LSP servers" })

  vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("LspInfo")
  end, { desc = "Show LSP information" })
end

-- Auto-setup on module load
M.setup()

return M