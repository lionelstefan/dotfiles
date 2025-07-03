local M = {}

local opts = {
  keymap = {
    preset = "super-tab",
    ["<S-k>"] = { "scroll_documentation_up", "fallback" },
    ["<S-j>"] = { "scroll_documentation_down", "fallback" },
  },

  snippets = {
    preset = "luasnip",
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
    active = function(filter)
      if filter and filter.direction then
        return require("luasnip").jumpable(filter.direction)
      end
      return require("luasnip").in_snippet()
    end,
    jump = function(direction)
      require("luasnip").jump(direction)
    end,
  },

  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },

  completion = {
    menu = {
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind", gap = 1 }
        },
        treesitter = {},
      },
    },

    accept = {
      auto_brackets = { enabled = false },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      treesitter_highlighting = true,
    },

    ghost_text = {
      enabled = false,
    },
  },

  signature = {
    enabled = true,
  },
}

M.opts = opts

return M
