# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repository for synchronizing terminal configuration across multiple Macs. Contains enhanced Zsh configuration, Tmux settings, Git configuration, and an automated installation script.

## Key Commands

### Installation on New Mac
```bash
# Clone and install
git clone https://github.com/kyle-bartlett/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### Updating Dotfiles
```bash
# Pull latest changes from any Mac
cd ~/dotfiles
git pull
source ~/.zshrc

# Push changes after editing configs
cd ~/dotfiles
git add .
git commit -m "Update configs"
git push
```

### Testing Configuration Changes
```bash
# Test .zshrc without installing
source ~/dotfiles/.zshrc

# Test tmux config
tmux -f ~/dotfiles/.tmux.conf

# Verify Git config
git config --global --list
```

## Repository Architecture

### Configuration Files (Symlinked)
- **`.zshrc`** - Main shell configuration with 40+ aliases/functions
- **`.tmux.conf`** - Terminal multiplexer settings (Ctrl-a prefix, vim navigation)
- **`.gitconfig`** - Git aliases and delta integration

### Support Files
- **`install.sh`** - Automated setup script (installs Homebrew, tools, creates symlinks)
- **`brew_packages.txt`** - Reference list of 128 Homebrew packages
- **`README.md`** - User-facing documentation

### Installation Workflow
The `install.sh` script:
1. Checks/installs Homebrew (handles Apple Silicon PATH setup)
2. Installs 14 essential tools (bat, eza, fd, fzf, ripgrep, jq, htop, lazygit, delta, httpie, litecli, z, tmux, tree)
3. Backs up existing configs to `~/.dotfiles_backup_TIMESTAMP/`
4. Creates symlinks: `~/.zshrc` → `~/dotfiles/.zshrc` (etc.)
5. Configures FZF keybindings
6. Sets up Git delta integration

**Critical**: Files are symlinked, not copied. Edits to `~/.zshrc` modify `~/dotfiles/.zshrc` directly.

## Configuration Highlights

### Zsh Configuration Structure
```
# ---- Existing Config (Preserved) ----
- Google Apps Script helpers (gasnew, gasp, gaspl, gass)
- Docker completions
- LM Studio CLI PATH
- Pyenv initialization
- pipx PATH

# ---- Enhanced Terminal Setup ----
- Modern tool replacements (ls→eza, cat→bat, grep→rg, find→fd)
- Git shortcuts (gs, gcp, gcob, glg)
- Project navigation (gas, sms, notes shortcuts)
- Docker quick commands (dps, dimg, dstop, dclean)

# ---- Custom Functions ----
- fcd: Fuzzy directory jump with preview
- fe: Fuzzy find and edit in Cursor
- rga: Ripgrep with live preview
- gcob: Git branch switcher with preview
- killport: Kill process on specific port
- mkproject: Scaffold new project
- gcp: Git add + commit + push in one command
- dbopen: Fuzzy find and open SQLite databases
- cleanup: Clean Homebrew, Docker, Python caches

# ---- Integrations ----
- FZF (Ctrl-T, Ctrl-R, Alt-C keybindings)
- Z directory jumper
- Git delta for diffs
```

### Project-Specific Shortcuts
Pre-configured for Kyle's projects:
```bash
# Navigation
gas         # cd ~/Google-Sheets-Scripts
sms         # cd ~/auto_sms
notes       # cd ~/replit

# Auto SMS
sms-test    # cd ~/auto_sms && pytest --cov
sms-run     # cd ~/auto_sms && python auto_responder.py

# Google Apps Script
gas-health  # cd ~/Google-Sheets-Scripts && npm run health-check
gas-test    # cd ~/Google-Sheets-Scripts && npm test
```

### Tmux Configuration
- **Prefix changed**: Ctrl-b → Ctrl-a (easier to reach)
- **Split panes**: Ctrl-a | (vertical), Ctrl-a - (horizontal)
- **Navigate panes**: Ctrl-a h/j/k/l (vim-style)
- **Resize panes**: Ctrl-a H/J/K/L
- **Mouse support**: Enabled
- **Base index**: 1 (not 0)

## Important Behaviors

### Symlink System
Files are **not copied** during installation - they're symlinked:
- Editing `~/.zshrc` edits `~/dotfiles/.zshrc`
- Changes can be committed from `~/dotfiles/`
- All Macs pull from same source of truth

### Backup Safety
- Installation always backs up existing configs to `~/.dotfiles_backup_TIMESTAMP/`
- Safe to run `install.sh` multiple times
- Original configs preserved

### Cross-Mac Sync
**One-way sync model**:
- Edit configs on any Mac
- Commit and push from `~/dotfiles/`
- Pull on other Macs when ready to update
- No automatic syncing - manual `git pull` required

**Tool installation is separate**:
- `brew_packages.txt` is reference only
- Each Mac can have different tools installed
- Aliases for missing tools simply don't work (no errors)

### Path Assumptions
The `.zshrc` contains machine-specific paths:
- `$HOME/gas-projects/` for Apps Script projects
- `$HOME/Google-Sheets-Scripts` for main GAS repo
- `$HOME/auto_sms` for SMS responder
- `$HOME/replit` for notes app

These directories may not exist on fresh Macs - shortcuts will fail gracefully.

## Modifying Configurations

### Adding New Aliases
Edit `~/dotfiles/.zshrc`:
```bash
# Add under appropriate section
alias myalias='command here'
```
Then reload: `source ~/.zshrc`

### Adding New Tools
1. Install locally: `brew install tool-name`
2. Add to `~/dotfiles/brew_packages.txt` (optional reference)
3. Add aliases/config to `~/dotfiles/.zshrc`
4. Commit and push

Other Macs can selectively install the tool.

### Tmux Configuration
Edit `~/dotfiles/.tmux.conf`, then:
```bash
# Inside tmux: Ctrl-a r (reload config)
# Or restart tmux
tmux kill-server && tmux
```

## Git Configuration

The `.gitconfig` includes:
- **Delta integration**: Side-by-side diffs with syntax highlighting
- **Aliases**: `st` (status), `co` (checkout), `br` (branch), `ci` (commit), `unstage`, `last`, `visual`
- **Diff settings**: Color-moved detection, diff3 conflict style

**Does not include**:
- User name/email (configure separately per Mac)
- Credentials or tokens
- GPG signing keys

## FZF Integration

Keybindings configured:
- **Ctrl-T**: Fuzzy find files in current directory
- **Ctrl-R**: Fuzzy search command history
- **Alt-C**: Fuzzy change directory

Custom FZF functions:
- `fcd`: Directory jump with tree preview
- `fe`: File search with bat preview → opens in Cursor
- `rga`: Ripgrep with file preview
- `gcob`: Git branch switcher with log preview

## Troubleshooting

### Commands Not Found After Install
```bash
source ~/.zshrc
```

### Icons Not Showing in eza
Install Nerd Font:
```bash
brew install font-hack-nerd-font
# Set terminal font to "Hack Nerd Font"
```

### FZF Not Working
Re-run FZF setup:
```bash
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
source ~/.zshrc
```

### Symlinks Broken
Verify dotfiles location:
```bash
ls -la ~/.zshrc
# Should show: .zshrc -> /Users/username/dotfiles/.zshrc
```

Re-run installer if needed:
```bash
cd ~/dotfiles
./install.sh
```

### Reverting to Original Configs
```bash
# Find backup
ls ~/.dotfiles_backup_*

# Restore (replace TIMESTAMP)
cp ~/.dotfiles_backup_TIMESTAMP/.zshrc ~/.zshrc
source ~/.zshrc
```
