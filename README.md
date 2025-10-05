# Kyle's Dotfiles

Enhanced terminal configuration with modern tools and shortcuts for productive development.

## ✨ What's Included

### Configuration Files
- **`.zshrc`** - Enhanced Zsh with 40+ custom aliases and functions
- **`.tmux.conf`** - Tmux with vim-style navigation and mouse support
- **`.gitconfig`** - Git with delta integration and helpful aliases

### Tools Installed
- `bat` - Better cat with syntax highlighting
- `eza` - Better ls with icons and colors
- `fd` - Better find (faster, simpler)
- `fzf` - Fuzzy finder (Ctrl-T, Ctrl-R, Alt-C)
- `ripgrep` - Better grep (faster, smarter)
- `jq` - JSON processor
- `httpie` - Better curl for API testing
- `lazygit` - Visual Git interface
- `delta` - Beautiful Git diffs
- `litecli` - SQLite CLI with autocomplete
- `z` - Smart directory jumper
- `tmux` - Terminal multiplexer
- `htop` - Interactive process viewer
- `tree` - Directory tree visualization

## 🚀 Installation

### On New Mac

1. **Clone this repo:**
   ```bash
   git clone https://github.com/kyle-bartlett/dotfiles.git ~/dotfiles
   ```

2. **Run the installer:**
   ```bash
   cd ~/dotfiles
   ./install.sh
   ```

3. **Open new terminal window** (or run `source ~/.zshrc`)

That's it! Your terminal is now configured.

### What the Installer Does

1. Installs Homebrew (if not present)
2. Installs all essential tools
3. Backs up your existing configs to `~/.dotfiles_backup_TIMESTAMP`
4. Creates symlinks from `~/.zshrc` → `~/dotfiles/.zshrc` (etc.)
5. Configures FZF keybindings
6. Sets up Git delta

## 🔄 Updating Dotfiles

### Pull Latest Changes
```bash
cd ~/dotfiles
git pull
source ~/.zshrc  # Reload config
```

### Push Your Changes
```bash
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```

## ⚡ Quick Command Reference

### File Navigation
```bash
ll              # Beautiful file listing
lt              # Tree view (2 levels)
fcd             # Fuzzy directory jump
fe              # Fuzzy find and edit file
z auto_sms      # Jump to frequently used directory
```

### Git Shortcuts
```bash
gs              # git status (short)
gcp "message"   # git add + commit + push
gcob            # Fuzzy git branch switcher
glg             # Launch lazygit
glog            # Pretty git log graph
```

### Development
```bash
sms-test        # cd ~/auto_sms && pytest --cov
gas-health      # cd ~/Google-Sheets-Scripts && npm run health-check
killport 5001   # Kill process on port
testapi 5001    # Test API endpoint
dbopen          # Open SQLite database
```

### System
```bash
ports           # Show listening ports
cleanup         # Clean Homebrew, Docker, caches
sysinfo         # System information
htop            # Process viewer
```

### Fuzzy Finding (FZF)
```bash
Ctrl-T          # Fuzzy find files
Ctrl-R          # Fuzzy search history
Alt-C           # Fuzzy change directory
rga "term"      # Ripgrep with preview
```

### Tmux
```bash
tmux new -s name    # Create session
Ctrl-a |            # Split vertical
Ctrl-a -            # Split horizontal
Ctrl-a h/j/k/l      # Navigate panes
Ctrl-a d            # Detach
```

## 📚 Full Documentation

- **Command Reference**: `bat ~/TERMINAL_CHEATSHEET.md`
- **Terminal Setup Guide**: `bat ~/TERMINAL_SETUP_QUICK_REFERENCE.md`
- **Dev Infrastructure**: `bat ~/DEVELOPMENT_INFRASTRUCTURE_SUMMARY.md`

## 🔧 Customization

Edit configs in `~/dotfiles/`:
- Modify `.zshrc` for aliases/functions
- Modify `.tmux.conf` for tmux settings
- Modify `.gitconfig` for git aliases

Then push changes:
```bash
cd ~/dotfiles
git add .
git commit -m "Custom changes"
git push
```

Pull on other Macs to sync.

## 💾 Backup & Restore

### Your Configs Are Safe
- Original configs backed up before install: `~/.dotfiles_backup_TIMESTAMP/`
- Dotfiles are symlinked (not copied), so easy to revert

### Restore Original Configs
```bash
# Find your backup
ls ~/.dotfiles_backup_*

# Restore (replace TIMESTAMP with your backup date)
cp ~/.dotfiles_backup_TIMESTAMP/.zshrc ~/.zshrc
source ~/.zshrc
```

### Uninstall
```bash
# Remove symlinks
rm ~/.zshrc ~/.tmux.conf ~/.gitconfig

# Restore from backup
cp ~/.dotfiles_backup_TIMESTAMP/* ~/

# Remove dotfiles repo
rm -rf ~/dotfiles
```

## 🎯 Project-Specific Shortcuts

These shortcuts are pre-configured for Kyle's projects:

```bash
# Navigation
gas             # cd ~/Google-Sheets-Scripts
sms             # cd ~/auto_sms
notes           # cd ~/replit

# Auto SMS
sms-test        # Run tests with coverage
sms-run         # Start Flask app

# Google Apps Script
gas-health      # Run health check
gas-test        # Run test suite
gasp            # clasp push
gaspl           # clasp pull
```

## 📦 Optional Tools

Not installed by default but recommended:

```bash
# Python development
brew install pyenv
pyenv install 3.11

# Node development
brew install nvm
nvm install --lts

# Docker
brew install --cask docker

# Prettier terminal prompt
brew install powerlevel10k
```

## 🆘 Troubleshooting

### Icons Not Showing
Install a Nerd Font:
```bash
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
# Set terminal font to "Hack Nerd Font"
```

### Commands Not Found
```bash
source ~/.zshrc  # Reload config
```

### FZF Not Working
```bash
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
source ~/.zshrc
```

## 📝 Notes

- Configs tested on macOS Sonoma (Apple Silicon)
- Compatible with zsh (default shell on macOS)
- Safe to run installer multiple times
- All configs are symlinked (easy updates)

## 🔗 Related

- [Terminal Cheat Sheet](~/TERMINAL_CHEATSHEET.md)
- [Development Infrastructure](~/DEVELOPMENT_INFRASTRUCTURE_SUMMARY.md)
- [auto_sms Deployment](~/auto_sms/DEPLOYMENT.md)
- [Google Sheets Scripts Deployment](~/Google-Sheets-Scripts/DEPLOYMENT.md)

---

**Last Updated:** October 5, 2025
