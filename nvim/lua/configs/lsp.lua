vim.lsp.set_log_level("off")
-- vim.lsp.set_log_level('debug')

local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
  local opts = {
    buffer = bufnr,
    noremap = true,
    silent = true,
  }

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.lsp.inlay_hint.enable(true, { bufnr })

  -- CODE ACTION
  -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
  -- vim.keymap.set('n', '<leader>ca', require('telescope.builtin').lsp_code_actions, { desc = 'Telescope Code Actions' })
  -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action (Range)' })

  -- -- Go to definition
  -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
  -- Hover
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  -- -- Rename symbol
  -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  -- -- Show diagnostics in quickfix list
  -- vim.keymap.set("n", "<leader>qf", function() vim.diagnostic.setqflist() end, opts)
  -- -- Go to next/prev diagnostic
  -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  require("lsp_signature").on_attach({}, bufnr)
  print("LSP attached!")
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    silent = true,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {}),
}

local capabilities = require("blink.cmp").get_lsp_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.colorProvider = { dynamicRegistration = false }
capabilities.dynamicRegistration = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.codeActionProvider = true

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function()

      lspconfig.phpactor.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "php" },
      })

      lspconfig.html.setup({
        on_attach = on_attach,
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

      lspconfig.bashls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "zsh" },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
        settings = require("lsp.servers.jsonls").settings,
      })

      require("lazydev").setup()

      lspconfig.lua_ls.setup({
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

      lspconfig.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.vls.setup({
        filetypes = require("lsp.servers.vuels").filetypes,
        handlers = handlers,
        init_options = require("lsp.servers.vuels").init_options,
        on_attach = require("lsp.servers.vuels").on_attach,
        settings = require("lsp.servers.vuels").settings,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
        handlers = require("lsp.servers.tsserver").handlers,
        on_attach = require("lsp.servers.tsserver").on_attach,
        settings = require("lsp.servers.tsserver").settings,
      })

      lspconfig.ruff.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "python" },
      })

      lspconfig.svelte.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "svelte" },
      })

      lspconfig.tailwindcss.setup({
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

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
      })

      lspconfig.marksman.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "markdown" },
      })

      lspconfig.vuels.setup({
        filetypes = require("lsp.servers.vuels").filetypes,
        handlers = handlers,
        init_options = require("lsp.servers.vuels").init_options,
        on_attach = require("lsp.servers.vuels").on_attach,
        settings = require("lsp.servers.vuels").settings,
      })
    end,
  },
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
