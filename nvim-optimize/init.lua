-- Main entry point for optimized Neovim configuration
-- Sets leader early and bootstraps the modular setup

-- Set leader keys before lazy loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("lazy_bootstrap")

-- Load core configuration
require("user.core")

-- Setup plugins
require("user.plugins").setup()
