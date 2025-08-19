-- Git integration
-- Git signs, diff view, and git tools

return {
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitSignsAdd", text = "│" },
          change = { hl = "GitSignsChange", text = "│" },
          delete = { hl = "GitSignsDelete", text = "󰍵" },
          topdelete = { hl = "GitSignsDelete", text = "‾" },
          changedelete = { hl = "GitSignsChange", text = "~" },
          untracked = { text = "│" },
        },
        numhl = false,
        linehl = false,
        watch_gitdir = { interval = 1000 },
        sign_priority = 6,
        update_debounce = 200,
        status_formatter = nil,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "right_align",
          delay = 300,
          virt_text_priority = 100,
        },
      })
    end,
  },

  -- Advanced git operations
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    keys = {
      {
        "lg",
        "<cmd>LazyGit<cr>",
        desc = "Lazygit",
      },
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.g["lazygit_floating_window_scaling_factor"] = 1
    end,
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
        default_mappings = {
          ours = "o",
          theirs = "t",
          none = "0",
          both = "b",
          next = "n",
          prev = "N",
        },
      })
    end,
  },
}