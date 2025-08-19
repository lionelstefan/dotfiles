-- LSP, completion, and language tools
-- Mason, LSP servers, completion engine, and formatting

return {
  -- Mason (package manager for LSP/DAP/linters/formatters)
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    cmd = "Mason",
    dependencies = {
      "mason-org/mason-registry",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason LSP config
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vtsls",
          "jsonls",
          "bashls",
        },
        automatic_installation = true,
      })
      
      -- Setup our custom LSP configuration
      require("user.lsp").setup()
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Setup diagnostics signs and configuration
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end,
  },

  -- JSON schemas
  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
  },

  -- Completion engine (blink.cmp)
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "fang2hou/blink-copilot",
    },
    build = "cargo build --release",
    opts = function()
      return require("user.configs.blinkcmp").opts
    end,
  },

  -- LSP kind icons
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  -- Trouble (diagnostics list)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      {
        "<leader>td",
        "<Cmd>Trouble diagnostics toggle<CR>",
        desc = "Trouble diagnostics",
      },
    },
    opts = {
      win = {
        size = {
          height = 5,
        },
      },
    },
  },
}