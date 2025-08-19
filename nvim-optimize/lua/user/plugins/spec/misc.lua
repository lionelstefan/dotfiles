-- Miscellaneous and experimental plugins
-- Temporary holding area for plugins to be classified or removed

return {
  -- Which-key (keybinding hints)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>t"] = { name = "+terminal" },
        ["<leader>n"] = { name = "+neogen" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- URL highlighting
  {
    "itchyny/vim-highlighturl",
    event = "VeryLazy",
  },

  -- Wezterm types
  {
    "justinsgithub/wezterm-types",
    event = "VeryLazy",
    ft = "wezterm",
  },

  -- Big file handling
  {
    "LunarVim/bigfile.nvim",
    event = "VeryLazy",
    config = function()
      require("bigfile").setup({
        filesize = 2,
        pattern = { "*" },
        features = {
          "avante",
          "indent_blankline",
          "illuminate",
          "lsp",
          "treesitter",
          "syntax",
          "matchparen",
          "vimopts",
          "filetype",
        },
      })
    end,
  },

  -- Background utilities
  {
    "typicode/bg.nvim",
    lazy = false,
  },

  -- Blade treesitter
  {
    "EmranMR/tree-sitter-blade",
    event = "VeryLazy",
    ft = { "blade" },
  },

  -- Render markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    filetypes = { "markdown", "Avante" },
    config = function()
      require("render-markdown").setup({
        completions = {
          lsp = { enabled = true },
          blink = { enabled = true },
          file_types = { "markdown", "Avante" },
        },
      })
    end,
  },
}