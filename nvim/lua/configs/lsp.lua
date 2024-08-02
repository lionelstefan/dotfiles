vim.lsp.set_log_level('debug')
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
  local opts = {
    noremap = true,
    silent = true,
  }

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()
-- local capabilities = require('cmp_nvim_lsp').default_capabilities({
-- 	dynamicRegistration = true
-- })

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities({
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      require("lspconfig").eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
          "svelte",
          "astro",
        },
      })

      require("lspconfig").intelephense.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        filetypes = { "php" },
        settings = {
          intelephense = {
            files = {
              maxSize = 1000000,
            },
            filetypes = { "php" },
            format = {
              enable = true,
              braces = "allman",
            },
          },
        },
      })

      require("lspconfig").html.setup({
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html" },
        init_options = {
          configurationSection = { "html", "css", "javascript" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      })

      require("lspconfig").bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh" },
      })

      require("lspconfig").jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lazydev").setup()

      require("lspconfig").lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        settings = {
          cmd = {
            '"/home/lionelstefan/homebrew/bin/lua-language-server" "$@"',
          },
          runtime = {
            version = "LuaJIT",
          },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      require("lspconfig").cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").vuels.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "vue" },
        cmd = { "/home/stefanlionel/.nvm/versions/node/v20.7.0/bin/vls" },
      })

      require("lspconfig").biome.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "json",
          "jsonc",
          "typescript",
          "typescript.tsx",
          "typescriptreact",
          "astro",
          "svelte",
          "vue",
        },
      })

      local tsserver_capabilities = require("cmp_nvim_lsp").default_capabilities({
        dynamicRegistration = true,
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      })

      require("lspconfig").tsserver.setup({
        init_options = { hostInfo = "neovim" },
        cmd = { "typescript-language-server", "--stdio" },
        on_attach = on_attach,
        capabilities = tsserver_capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      })

      require("lspconfig").ruff_lsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "python" },
      })

      require("lspconfig").svelte.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "svelte" },
      })

      require("lspconfig").tailwindcss.setup({
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = {
          "aspnetcorerazor",
          "astro",
          "astro-markdown",
          "clojure",
          "django-html",
          "htmldjango",
          "edge",
          "eelixir",
          "elixir",
          "ejs",
          "erb",
          "eruby",
          "gohtml",
          "haml",
          "handlebars",
          "hbs",
          "html",
          "html-eex",
          "heex",
          "jade",
          "leaf",
          "liquid",
          "markdown",
          "mdx",
          "mustache",
          "njk",
          "nunjucks",
          "razor",
          "slim",
          "twig",
          "css",
          "less",
          "postcss",
          "sass",
          "scss",
          "stylus",
          "sugarss",
          "javascript",
          "javascriptreact",
          "reason",
          "rescript",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
      })

      require("lspconfig").gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
      })

      require("lspconfig").marksman.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "markdown" },
      })

      require("ufo").setup({
        open_fold_hl_timeout = 100,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (" 󰁂 %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
    end
  }
})
