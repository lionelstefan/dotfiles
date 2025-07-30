-- NEOVIM LSPCONFIG
require("lspconfig")

local on_attach = function(client, bufnr)
  local opts = {
    buffer = bufnr,
    noremap = true,
    silent = true,
  }
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  vim.lsp.inlay_hint.enable(true, { bufnr })

  -- Hover
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local buftype = vim.bo[bufnr].buftype
  if bufname ~= "" and buftype == "" then
    -- Only apply these capabilities for real files

    -- snippetSupport
    if
        client.server_capabilities.completionProvider
        and client.server_capabilities.completionProvider.triggerCharacters
    then
      client.server_capabilities.completionProvider.resolveProvider = true
    end

    -- colorProvider
    client.server_capabilities.colorProvider = {
      dynamicRegistration = false,
    }

    -- dynamicRegistration (for top-level capabilities)
    client.server_capabilities.dynamicRegistration = true

    -- codeActionProvider
    client.server_capabilities.codeActionProvider = true

    -- foldingRange
    client.server_capabilities.foldingRangeProvider = {
      dynamicRegistration = false,
      lineFoldingOnly = false,
    }

    -- Optional debug print
    print("🧠 Enhanced capabilities applied for:", client.name, bufname)
  end

  print("LSP attached!")
end

local handlers = {
  ["textDocument/signatureHelp"] = vim.lsp.buf.signature_help,
  {
    border = "rounded",
  },
  ["textDocument/publishDiagnostics"] = function(err, result, ctx)
    require("ts-error-translator").translate_diagnostics(err, result, ctx)
    vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
  end,
}
local capabilities = require("blink.cmp").get_lsp_capabilities()
local lsp_started = {}

local function safe_setup(name, config)
  if lsp_started[name] then
    return
  end

  lsp_started[name] = true
  vim.lsp.config(name, config)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    safe_setup(name, config)("phpactor", {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "php" },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    safe_setup(name, config)("html", {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "html" },
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
        provideFormatter = false,
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "zsh" },
  callback = function()
    safe_setup("bashls", {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "bash-language-server", "start" },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    safe_setup("jsonls", {
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers,
      settings = require("configs.lsp.servers.jsonls").settings,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    safe_setup("lua_ls", {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "lua-language-server" },
      settings = {
        cmd = {
          '"' .. os.getenv("HOME") .. '/homebrew/bin/lua-language-server" "$@"',
        },
        runtime = { version = "LuaJIT" },
        format = {
          enable = false,
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
        telemetry = { enable = false },
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    safe_setup("cssls", {
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    safe_setup("ruff", {
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    safe_setup("svelte", {
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
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
  callback = function()
    safe_setup("tailwindcss", {
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
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    safe_setup("gopls", {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    safe_setup("marksman", {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "markdown" },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = require("configs.lsp.servers.vtsls").settings.vtsls.filetypes,
  callback = function()
    safe_setup("vtsls", {
      before_init = require("configs.lsp.servers.vtsls").before_init,
      handlers = handlers,
      capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
      settings = require("configs.lsp.servers.vtsls").settings,
      on_attach = require("configs.lsp.servers.vtsls").on_attach,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = require("configs.lsp.servers.vuels").filetypes,
  callback = function()
    local vtsls_opts = {
      before_init = require("configs.lsp.servers.vtsls").before_init,
      handlers = handlers,
      capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
      settings = require("configs.lsp.servers.vtsls").settings,
      on_attach = require("configs.lsp.servers.vtsls").on_attach,
    }

    safe_setup("vtsls", vtsls_opts)

    safe_setup("vue_ls", {
      filetypes = require("configs.lsp.servers.vuels").filetypes,
      init_options = require("configs.lsp.servers.vuels").init_options,
      on_attach = require("configs.lsp.servers.vuels").on_attach,
      on_init = require("configs.lsp.servers.vuels").on_init,
    })

    vim.lsp.enable("vtsls")
    vim.lsp.start({
      cmd = { 'vtsls', '--stdio' },
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
      },
      root_dir = vim.fs.dirname(vim.fs.find({ 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' }, { upward = true })[1]),
      before_init = require("configs.lsp.servers.vtsls").before_init,
      handlers = handlers,
      capabilities = capabilities or vim.lsp.protocol.make_client_capabilities(),
      settings = require("configs.lsp.servers.vtsls").settings,
      on_attach = require("configs.lsp.servers.vtsls").on_attach,
    })

    vim.lsp.enable("vue_ls")

  end,
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
    "marksman",
    "phpactor",
    "ruff",
    "yamlls",
    "jsonls",
    "vue_ls",
    "vtsls",
  },
})
