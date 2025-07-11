return {
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
    end,
    lazy = true,
  },
}
