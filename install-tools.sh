#!/bin/bash

set -e

echo "🔧 Updating package index and installing base dependencies..."
sudo apt update
sudo apt install -y wget gpg software-properties-common build-essential curl unzip

# Check and install Rust & Cargo
if command -v cargo &> /dev/null; then
    echo "✅ Cargo is already installed"
else
    echo "📦 Installing Rust and Cargo via rustup..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "✅ Cargo installed"
fi

# Check and install FNM
if command -v fnm >/dev/null 2>&1; then
  echo "✅ FNM is already installed"
else
  echo "📦 Installing FNM (Fast Node Manager)..."
  curl -fsSL https://fnm.vercel.app/install | bash
fi

# Load FNM for current shell session
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env)"
echo "✅ FNM loaded"

# Install latest LTS Node.js using FNM
echo "📦 Installing latest LTS Node version with FNM..."
fnm install --lts
fnm use --lts
fnm default $(fnm current)
echo "✅ Latest LTS Node version installed and set as default"

# Install pnpm globally using corepack (comes with Node.js >=16.13)
echo "📦 Enabling and setting up pnpm..."
corepack enable
corepack prepare pnpm@latest --activate
echo "✅ pnpm is ready"

# Install global packages using pnpm
echo "📦 Installing git-jump globally using pnpm..."
pnpm add -g git-jump
echo "✅ git-jump installed globally via pnpm"

# Add Neovim repositories
echo "📝 Adding Neovim stable and unstable PPAs..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:neovim-ppa/stable

echo "📦 Installing Neovim..."
sudo apt update
sudo apt install -y neovim
echo "✅ Neovim installed"

# Install CLI tools via Cargo
echo "🔧 Installing CLI tools using Cargo..."
cargo install bat
cargo install exa
cargo install fd-find
cargo install ripgrep
cargo install starship
cargo install zoxide
echo "✅ All CLI tools installed"

# Install lazygit
echo "📦 Installing lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
echo "✅ lazygit installed"

echo "🔄 Reloading shell..."
exec $SHELL
