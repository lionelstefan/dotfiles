-- AI assistance plugins
-- Keep only essential AI tools to reduce startup overhead

return {
  -- Avante AI
  {
    "yetone/avante.nvim",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      {
        "meanderingprogrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({})
        end,
      },
    },
    config = function()
      require("user.configs.avante")
    end,
  },

  -- Copilot standalone
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- Blink.cmp extensions for Copilot and Avante
  {
    "fang2hou/blink-copilot",
    lazy = true,
  },
  {
    "Kaiser-Yang/blink-cmp-avante",
    lazy = true,
  },

  -- LuaSnip for snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}