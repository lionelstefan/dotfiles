-- Core infrastructure plugins
-- Essential dependencies and baseline setup

return {
  -- Plugin manager (already loaded by bootstrap)
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Essential dependencies
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },

  -- All colorschemes from original config
  {
    "samharju/synthweave.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "0xstepit/flow.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "sainnhe/edge",
    lazy = true,
  },
  {
    "tanvirtin/monokai.nvim",
    lazy = true,
  },
  {
    "akinsho/horizon.nvim",
    version = "*",
    lazy = true,
  },
  {
    "kartikp10/noctis.nvim",
    lazy = true,
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "srcery-colors/srcery-vim",
    lazy = true,
  },
  {
    "rose-pine/neovim",
    lazy = true,
  },
  {
    "bluz71/vim-moonfly-colors",
    lazy = true,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        undercurl = false,
        underline = false,
        italic = {
          comments = true,
          strings = false,
          operators = false,
          folds = false,
        },
        bold = false,
        contrast = "hard",
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Snacks (folke's utility collection)
  {
    "folke/snacks.nvim",
    event = "InsertEnter",
    priority = 1000,
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = {
        debounce = 10,
      },
    },
  },
}