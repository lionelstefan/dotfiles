require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "php",
        "json",
        "html",
        "css",
        "javascript",
        "tsx",
        "scss",
        "typescript",
        "yaml",
        "python"
    },
    autotag = {
      enable = true,
      filetypes = { "html", "php", "xml" }
    },
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = true,
        disable = {},
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
    }
}
