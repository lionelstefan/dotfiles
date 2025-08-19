-- Format toggle feature
-- Provides user commands and functions to control format-on-save behavior
-- This is a simplified wrapper around the LSP formatting module

local M = {}

function M.setup()
  local formatting = require("user.lsp.formatting")
  
  -- Create user command for toggling
  vim.api.nvim_create_user_command("FormatToggle", function()
    formatting.toggle_format()
  end, { desc = "Toggle format on save" })

  -- Create user command for one-time formatting
  vim.api.nvim_create_user_command("Format", function()
    formatting.format()
  end, { desc = "Format current buffer" })

  -- Optional: Add keymap for quick toggle
  vim.keymap.set("n", "<leader>tf", formatting.toggle_format, { desc = "Toggle format on save" })
  
  -- Show current status
  vim.api.nvim_create_user_command("FormatStatus", function()
    local status = formatting.is_format_enabled() and "enabled" or "disabled"
    require("user.core.notifications").info("Format on save is " .. status, "Formatting")
  end, { desc = "Show format on save status" })
end

-- Auto-setup on module load
M.setup()

return M