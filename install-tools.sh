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

# Check and install NVM
if [ -d "$HOME/.nvm" ]; then
    echo "✅ NVM is already installed"
else
    echo "📦 Installing NVM (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM for current shell session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
echo "✅ NVM loaded"

# Install latest LTS version of Node using NVM
echo "📦 Installing latest LTS Node version with NVM..."
nvm install --lts
nvm use --lts
echo "✅ Latest LTS Node version installed"

# Install npm packages globally
echo "📦 Installing git-jump globally using npm..."
npm install -g git-jump
echo "✅ git-jump installed globally"

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
