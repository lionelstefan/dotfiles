-- NEOVIM LSPCONFIG
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
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = "rounded",
    }
  ),
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


vim.lsp.config('phpactor', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "php" },
})

vim.lsp.config('html', {
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

vim.lsp.config('bashls', {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "zsh" },
})

vim.lsp.config('jsonls', {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require("configs.lsp.servers.jsonls").settings,
})

require("lazydev").setup()

vim.lsp.config('lua_ls', {
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

vim.lsp.config('cssls', {
  on_attach = on_attach,
  capabilities = capabilities,
})

vim.lsp.config('vue_ls', {
  filetypes = require("configs.lsp.servers.vuels").filetypes,
  handlers = handlers,
  init_options = require("configs.lsp.servers.vuels").init_options,
  on_attach = require("configs.lsp.servers.vuels").on_attach,
  settings = require("configs.lsp.servers.vuels").settings,
})

vim.lsp.config('ts_ls', {
  filetypes = require("configs.lsp.servers.tsserver").filetypes,
  init_options = require("configs.lsp.servers.tsserver").init_options,
  capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
  handlers = require("configs.lsp.servers.tsserver").handlers,
  on_attach = require("configs.lsp.servers.tsserver").on_attach,
  settings = require("configs.lsp.servers.tsserver").settings,
})

vim.lsp.config('ruff', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

vim.lsp.config('svelte', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "svelte" },
})

vim.lsp.config('tailwindcss', {
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

vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

vim.lsp.config('marksman', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "markdown" },
})

vim.lsp.config('vue_ls', {
  filetypes = require("configs.lsp.servers.vuels").filetypes,
  handlers = handlers,
  init_options = require("configs.lsp.servers.vuels").init_options,
  on_attach = require("configs.lsp.servers.vuels").on_attach,
  settings = require("configs.lsp.servers.vuels").settings,
})


-- MASON LSPCONFIG

local mason = require("mason")

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "dockerls",
    "docker_compose_language_service",
    "lua_ls",
    "dotls",
    "html",
    "biome",
    "ts_ls",
    "marksman",
    "phpactor",
    "ruff",
    "yamlls",
    "jsonls",
    "vue_ls",
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
