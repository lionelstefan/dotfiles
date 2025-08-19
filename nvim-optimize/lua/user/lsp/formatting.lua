-- Formatting configuration and toggle
-- Handles format-on-save with toggle and allowlist

local M = {}

-- State
local format_on_save_enabled = true

-- Filetypes to format on save (allowlist)
local format_filetypes = {
  "lua",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "json",
  "yaml",
  "markdown",
  "python",
  "rust",
  "go",
  "html",
  "css",
  "scss",
  "vue",
  "svelte",
}

-- Convert to set for O(1) lookup
local format_ft_set = {}
for _, ft in ipairs(format_filetypes) do
  format_ft_set[ft] = true
end

function M.is_format_enabled()
  return format_on_save_enabled
end

function M.toggle_format()
  format_on_save_enabled = not format_on_save_enabled
  local status = format_on_save_enabled and "enabled" or "disabled"
  require("user.core.notifications").info("Format on save " .. status, "Formatting")
end

function M.should_format_on_save()
  if not format_on_save_enabled then
    return false
  end
  
  local ft = vim.bo.filetype
  return format_ft_set[ft] == true
end

function M.format()
  vim.lsp.buf.format({
    filter = function(client)
      -- Prefer null-ls/conform if available, otherwise use LSP
      return client.name ~= "tsserver" and client.name ~= "lua_ls"
    end,
    timeout_ms = 2000,
  })
end

-- Setup format on save autocmd
local function setup_format_on_save()
  local augroup = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
  
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function()
      if M.should_format_on_save() then
        M.format()
      end
    end,
    desc = "Format on save",
  })
end

-- Create user commands
vim.api.nvim_create_user_command("Format", M.format, { desc = "Format current buffer" })
vim.api.nvim_create_user_command("FormatToggle", M.toggle_format, { desc = "Toggle format on save" })

-- Setup on module load
setup_format_on_save()

return M