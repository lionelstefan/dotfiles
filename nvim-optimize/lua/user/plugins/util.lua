-- Plugin utility functions
-- Shared helpers for plugin configuration

local M = {}

function M.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load module: " .. module, vim.log.levels.ERROR)
    return nil
  end
  return result
end

function M.with_opts(spec, opts)
  return vim.tbl_deep_extend("force", spec, { opts = opts })
end

function M.lazy_keys(keys)
  if type(keys) == "string" then
    return { keys }
  end
  return keys
end

function M.on_attach_lsp(callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      callback(client, args.buf)
    end,
  })
end

return M