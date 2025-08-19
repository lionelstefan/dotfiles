-- LSP setup coordinator
-- Configures all language servers with unified capabilities and on_attach

local M = {}

-- List of servers to configure
local servers = {
  "lua_ls",
  "vtsls",
  "jsonls",
  "bashls",
}

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("user.lsp.capabilities").get_capabilities()
  local on_attach = require("user.lsp.on_attach").on_attach

  for _, server_name in ipairs(servers) do
    local server_config = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    
    -- Try to load server-specific configuration
    local ok, config = pcall(require, "user.lsp.servers." .. server_name)
    if ok then
      -- Merge server-specific settings
      if config.settings then
        server_config.settings = config.settings
      end
      if config.filetypes then
        server_config.filetypes = config.filetypes
      end
      if config.before_init then
        server_config.before_init = config.before_init
      end
      if config.on_attach then
        -- Chain server-specific on_attach with global on_attach
        local global_on_attach = server_config.on_attach
        server_config.on_attach = function(client, bufnr)
          global_on_attach(client, bufnr)
          config.on_attach(client, bufnr)
        end
      end
    end

    -- Setup the server
    lspconfig[server_name].setup(server_config)
  end
end

return M