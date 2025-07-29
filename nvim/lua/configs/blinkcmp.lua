local M = {}

local opts = {
  appearance = {
    kind_icons = {
      Copilot = "",
      Text = "󰉿",
      Method = "󰊕",
      Function = "󰊕",
      Constructor = "󰒓",

      Field = "󰜢",
      Variable = "󰆦",
      Property = "󰖷",

      Class = "󱡠",
      Interface = "󱡠",
      Struct = "󱡠",
      Module = "󰅩",

      Unit = "󰪚",
      Value = "󰦨",
      Enum = "󰦨",
      EnumMember = "󰦨",

      Keyword = "󰻾",
      Constant = "󰏿",

      Snippet = "󱄽",
      Color = "󰏘",
      File = "󰈔",
      Reference = "󰬲",
      Folder = "󰉋",
      Event = "󱐋",
      Operator = "󰪚",
      TypeParameter = "󰬛",
    },
  },

  cmdline = {
    keymap = { preset = "inherit" },
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },

  fuzzy = {
    implementation = "prefer_rust",
    sorts = {
      "score",
    },
  },

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
    keyword = {
      range = "prefix",
    },

    menu = {
      draw = {
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind",              gap = 1 },
        },
        treesitter = {},

        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },

          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end

              return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from nvim-web-devicons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
        },
      },
    },

    accept = {
      auto_brackets = { enabled = false },
    },

    documentation = {
      draw = function(opts)
        if opts.item and opts.item.documentation then
          local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
          opts.item.documentation.value = out:string()
        end

        opts.default_implementation(opts)
      end,
      auto_show = true,
      auto_show_delay_ms = 500,
      treesitter_highlighting = true,
    },

    ghost_text = {
      enabled = false,
    },
  },

  signature = {
    enabled = false,
  },
}

M.opts = opts

return M
