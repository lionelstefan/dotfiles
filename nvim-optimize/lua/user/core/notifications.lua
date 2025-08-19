-- Notifications wrapper
-- Optionally integrates with nvim-notify if available

local M = {}

-- Store original notify function
local original_notify = vim.notify

function M.setup()
  -- Try to use nvim-notify if available
  local ok, notify = pcall(require, "notify")
  if ok then
    vim.notify = notify
  end
end

-- Convenience functions
function M.info(msg, title)
  vim.notify(msg, vim.log.levels.INFO, { title = title })
end

function M.warn(msg, title)
  vim.notify(msg, vim.log.levels.WARN, { title = title })
end

function M.error(msg, title)
  vim.notify(msg, vim.log.levels.ERROR, { title = title })
end

-- Auto-setup on module load
M.setup()

return M