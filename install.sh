#!/bin/bash
# Dotfiles Installation Script
# Sets up terminal environment to match main development Mac

set -e  # Exit on error

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Kyle's Terminal Setup Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📦 Installing Essential Terminal Tools"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Core terminal enhancement tools
ESSENTIAL_TOOLS=(
    "bat"           # Better cat
    "eza"           # Better ls
    "fd"            # Better find
    "fzf"           # Fuzzy finder
    "ripgrep"       # Better grep
    "jq"            # JSON processor
    "htop"          # Process viewer
    "lazygit"       # Git TUI
    "git-delta"     # Better git diff
    "httpie"        # Better curl
    "litecli"       # SQLite CLI
    "z"             # Directory jumper
    "tmux"          # Terminal multiplexer
    "tree"          # Directory tree
)

for tool in "${ESSENTIAL_TOOLS[@]}"; do
    if brew list --formula | grep -q "^${tool}\$"; then
        echo "  ✓ $tool (already installed)"
    else
        echo "  → Installing $tool..."
        brew install "$tool"
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Configuring Dotfiles"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Backup existing configs
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.dotfiles_backup_$TIMESTAMP"

if [ -f ~/.zshrc ] || [ -f ~/.tmux.conf ] || [ -f ~/.gitconfig ] || [ -f ~/.cursor/mcp.json ]; then
    echo "📋 Backing up existing configs to $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    [ -f ~/.zshrc ] && cp ~/.zshrc "$BACKUP_DIR/.zshrc"
    [ -f ~/.tmux.conf ] && cp ~/.tmux.conf "$BACKUP_DIR/.tmux.conf"
    [ -f ~/.gitconfig ] && cp ~/.gitconfig "$BACKUP_DIR/.gitconfig"
    [ -f ~/.cursor/mcp.json ] && cp ~/.cursor/mcp.json "$BACKUP_DIR/cursor-mcp.json"

    echo "✅ Backup complete"
fi

echo ""
echo "🔗 Creating symlinks..."

# Get the dotfiles directory (where this script is)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create symlinks
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

# Create ~/.cursor directory if it doesn't exist
mkdir -p "$HOME/.cursor"
ln -sf "$DOTFILES_DIR/cursor-mcp.json" "$HOME/.cursor/mcp.json"

echo "  ✓ ~/.zshrc → $DOTFILES_DIR/.zshrc"
echo "  ✓ ~/.tmux.conf → $DOTFILES_DIR/.tmux.conf"
echo "  ✓ ~/.gitconfig → $DOTFILES_DIR/.gitconfig"
echo "  ✓ ~/.cursor/mcp.json → $DOTFILES_DIR/cursor-mcp.json"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚡ Setting up FZF"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Setup FZF keybindings
if [ -d "$(brew --prefix)/opt/fzf" ]; then
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
    echo "✅ FZF keybindings configured"
else
    echo "⚠️  FZF not found, skipping keybindings"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎨 Configuring Git"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Git delta configuration
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.side-by-side true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

echo "✅ Git delta configured"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎯 Next Steps:"
echo ""
echo "1. Open a NEW terminal window (or run: source ~/.zshrc)"
echo "2. Your terminal now has all the enhancements!"
echo ""
echo "📚 Quick Commands:"
echo "  ll          - Beautiful file listing"
echo "  fcd         - Fuzzy directory jump"
echo "  Ctrl-R      - Fuzzy history search"
echo "  gcob        - Git branch switcher"
echo "  glg         - Launch lazygit"
echo ""
echo "📖 Full reference: bat ~/TERMINAL_CHEATSHEET.md"
echo ""
echo "💾 Your old configs backed up to: $BACKUP_DIR"
echo ""
