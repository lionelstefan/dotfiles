-- Plugin coordinator
-- Aggregates all plugin specs and configures lazy.nvim

local M = {}

function M.setup()
  -- Collect all plugin specs
  local specs = {}
  
  -- Core infrastructure
  vim.list_extend(specs, require("user.plugins.spec.core"))
  
  -- UI enhancements
  vim.list_extend(specs, require("user.plugins.spec.ui"))
  
  -- Editor functionality
  vim.list_extend(specs, require("user.plugins.spec.editor"))
  
  -- LSP and completion
  vim.list_extend(specs, require("user.plugins.spec.lsp"))
  
  -- Git integration
  vim.list_extend(specs, require("user.plugins.spec.git"))
  
  -- Development tools
  vim.list_extend(specs, require("user.plugins.spec.tools"))
  
  -- AI assistance
  vim.list_extend(specs, require("user.plugins.spec.ai"))
  
  -- Miscellaneous
  vim.list_extend(specs, require("user.plugins.spec.misc"))

  -- Configure lazy.nvim
  require("lazy").setup(specs, {
    defaults = {
      lazy = true,
      version = false,
    },
    install = {
      missing = true,
      colorscheme = { "tokyonight" },
    },
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      enabled = true,
      notify = false,
    },
    ui = {
      border = "rounded",
      icons = {
        cmd = " ",
        config = "",
        event = "",
        ft = " ",
        init = " ",
        import = " ",
        keys = " ",
        lazy = "󰒲 ",
        loaded = "●",
        not_loaded = "○",
        plugin = " ",
        runtime = " ",
        source = " ",
        start = "",
        task = "✔ ",
        list = {
          "●",
          "➜",
          "★",
          "‒",
        },
      },
    },
    performance = {
      cache = {
        enabled = true,
      },
      reset_packpath = true,
      rtp = {
        reset = true,
        paths = {},
        disabled_plugins = {
          "gzip",
          "matchit",
          "matchparen",
          "netrwPlugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
end

return M