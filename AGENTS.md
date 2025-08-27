# Agent Guidelines for Dotfiles Repository

## Overview
This is a dotfiles repository containing Neovim, Zsh, and development tool configurations. No traditional build/test commands as this manages configuration files.

## Installation & Setup
- Main setup: `./install-tools.sh` (installs Rust, Node.js, CLI tools, Neovim)
- Uses dotbot for symlink management

## Languages & Tools
- **Lua**: Neovim configuration (nvim/lua/)
- **Shell**: Zsh configuration and plugins (zsh/)
- **JSON**: Linter/formatter configs

## Code Style Guidelines

### Lua (Neovim config)
- 2-space indentation
- Snake_case for variables
- Follow existing vim.o/vim.opt patterns
- No trailing commas in tables

### Shell Scripts
- Use `#!/bin/bash`
- Include `set -e` for error handling
- Echo status messages with emojis (✅, 📦, 🔧)

### JavaScript/TypeScript (when present)
- Follow Biome configuration (nvim/linter_formatter_config/biome/biome.json)
- Single quotes, trailing commas, 2-space indentation
- Line width: 120 characters
- Arrow functions with parentheses

## File Structure
- `nvim/`: Neovim configuration and plugin setup
- `zsh/`: Zsh plugins and shell configuration  
- Root level: dotfiles (.zshrc, starship.toml, etc.)
