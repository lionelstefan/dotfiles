local M = {}

local opts = {
  appearance = {
    kind_icons = {
      Copilot = "",
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
      "copilot",
      "avante",
      "lazydev",
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
      avante = {
        module = 'blink-cmp-avante',
        name = 'Avante',
        opts = {
          kind_icons = {
            AvanteCmd = "",
            AvanteMention = "",
            AvanteShortcut = '',
          }
        }
      },
      copilot = {
        name = "Copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      },
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
              if pcall(require, "colorful-menu") then
                return require("colorful-menu").blink_components_text(ctx)
              end
              return ctx.label
            end,
            highlight = function(ctx)
              if pcall(require, "colorful-menu") then
                return require("colorful-menu").blink_components_highlight(ctx)
              end
              return ctx.highlight
            end,
          },

          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local ok, devicons = pcall(require, "nvim-web-devicons")
                if ok then
                  local dev_icon, _ = devicons.get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                end
              else
                local ok, lspkind = pcall(require, "lspkind")
                if ok then
                  icon = lspkind.symbolic(ctx.kind, {
                    mode = "symbol",
                  })
                end
              end

              return icon .. ctx.icon_gap
            end,

            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local ok, devicons = pcall(require, "nvim-web-devicons")
                if ok then
                  local dev_icon, dev_hl = devicons.get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
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
        local ft = vim.bo.filetype
        if opts.item and opts.item.documentation and (ft ~= "AvanteInput" and ft ~= "AvanteChat") then
          local ok, pretty_hover = pcall(require, "pretty_hover.parser")
          if ok then
            local out = pretty_hover.parse(opts.item.documentation.value)
            opts.item.documentation.value = out:string()
          end
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