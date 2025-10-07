# Complete Setup Guide: 16GB Mac → 8GB Mac

## Overview

This guide transfers your complete terminal setup, Cursor integrations, and project configurations from your 16GB Mac to your 8GB Mac.

---

## 📍 Current Locations

### 16GB Mac (Source - THIS Computer)
**Dotfiles Location:**
```
~/Library/Mobile Documents/com~apple~CloudDocs/dotfiles/
```
*(iCloud Drive synced)*

**What's Here:**
- ✅ `.zshrc` - 374 lines, 40+ aliases/functions
- ✅ `.tmux.conf` - 102 lines, vim navigation
- ✅ `.gitconfig` - 33 lines, delta integration
- ✅ `cursor-mcp.json` - MCP integrations (Docker, Notion, Rube/Composio, GitKraken, Supabase)
- ✅ `brew_packages.txt` - All installed tools
- ✅ `install.sh` - Automated installer
- ✅ GitHub repo: https://github.com/kyle-bartlett/dotfiles

**Active Configurations:**
```bash
~/.zshrc           → symlinked to dotfiles
~/.tmux.conf       → symlinked to dotfiles
~/.gitconfig       → symlinked to dotfiles
~/.cursor/mcp.json → active MCP servers running
```

**Project-Specific Cursor Rules:**
```
~/Google-Sheets-Scripts/.cursor/rules/
  ├── gasprojectrules.mdc    (Apps Script patterns)
  ├── alloy.mdc              (Alloy project)
  ├── costcolongterm.mdc     (Costco project)
  └── multiagent.mdc         (Multi-agent system)

~/Google-Sheets-Scripts/ZipWise/.cursor/rules/
  ├── multiagent.mdc         (ZipWise teams: RED/BLUE/GREEN/YELLOW)
  └── zipwise-dev-rules.mdc  (React Native + offline-first patterns)

~/Google-Sheets-Scripts/Twilio Connection/.cursor/rules/
  └── twilio.mdc             (Twilio integration)
```

---

### 8GB Mac (Destination - NEW Computer)
**Dotfiles Location:** (see screenshot `8gb-computer-location.png`)
```
~/dotfiles/
```

**Current Status:**
- ⚠️ Repo cloned but NOT installed yet
- ⚠️ No config files active
- ⚠️ No Cursor settings
- ⚠️ No project rules
- ⚠️ Tools not installed

---

## 🚀 Complete Installation Process

### Step 1: Update 8GB Mac Dotfiles

On **8GB Mac**, pull the latest:

```bash
cd ~/dotfiles
git pull origin main
```

You should now have:
```
~/dotfiles/
  ├── .zshrc
  ├── .tmux.conf
  ├── .gitconfig
  ├── cursor-mcp.json         ← NEW!
  ├── brew_packages.txt
  ├── install.sh
  ├── README.md
  ├── CLAUDE.md
  └── 8gb-computer-location.png
```

### Step 2: Run Installer

```bash
cd ~/dotfiles
./install.sh
```

**What This Does:**

1. ✅ Installs Homebrew (if missing)
2. ✅ Installs all tools from `brew_packages.txt`:
   - bat, eza, fd, fzf, ripgrep, jq, httpie
   - lazygit, delta, tmux, htop, tree, z
3. ✅ Backs up existing configs to `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`
4. ✅ Creates symlinks:
   ```
   ~/.zshrc           → ~/dotfiles/.zshrc
   ~/.tmux.conf       → ~/dotfiles/.tmux.conf
   ~/.gitconfig       → ~/dotfiles/.gitconfig
   ~/.cursor/mcp.json → ~/dotfiles/cursor-mcp.json
   ```
5. ✅ Configures FZF keybindings (Ctrl-T, Ctrl-R, Alt-C)
6. ✅ Sets up Git delta for beautiful diffs

**After Installation:**
```bash
# Open NEW terminal window or reload
source ~/.zshrc

# Verify installation
ll              # Should show beautiful file listing
bat README.md   # Should show syntax highlighting
fzf             # Should open fuzzy finder (Ctrl-C to exit)
```

---

## 🎯 Cursor Setup on 8GB Mac

### Global MCP Integrations

After running `./install.sh`, Cursor will automatically have:

**`~/.cursor/mcp.json`** with:
- 🐳 **Docker MCP** - Container management
- 📝 **Notion** - Knowledge base integration
- 🔌 **Rube/Composio** - Salesforce & external APIs
- 🌿 **GitKraken** - Advanced git operations
- 🗄️ **Supabase** - Database management

**Verify in Cursor:**
1. Open Cursor
2. Check Settings → MCP Servers
3. All 5 servers should be listed and active

---

### Project-Specific Rules

These are **NOT in dotfiles** - they're tracked in each project's git repo.

**To Get Project Rules on 8GB Mac:**

#### Option 1: Clone Fresh Projects
```bash
# Clone your main projects
cd ~/
git clone https://github.com/kyle-bartlett/Google-Sheets-Scripts.git

# Rules automatically included:
~/Google-Sheets-Scripts/.cursor/rules/
  ├── gasprojectrules.mdc
  ├── alloy.mdc
  ├── costcolongterm.mdc
  └── multiagent.mdc
```

#### Option 2: Copy iCloud Projects
If projects are in iCloud on 16GB Mac:

**On 16GB Mac:**
```bash
# Create archive of projects with rules
cd ~/Google-Sheets-Scripts
zip -r ~/Desktop/projects-with-rules.zip \
  .cursor/rules/*.mdc \
  ZipWise/.cursor/rules/*.mdc \
  "Twilio Connection/.cursor/rules/*.mdc"
```

**Transfer to 8GB Mac** (AirDrop, USB, email)

**On 8GB Mac:**
```bash
# Extract to project directories
unzip projects-with-rules.zip -d ~/Google-Sheets-Scripts/
```

#### Option 3: Git Sync Each Project

For each project with rules:

**On 16GB Mac:**
```bash
cd ~/Google-Sheets-Scripts/ZipWise
git add .cursor/rules/*.mdc
git commit -m "Add Cursor rules for ZipWise"
git push
```

**On 8GB Mac:**
```bash
cd ~/Google-Sheets-Scripts/ZipWise
git pull
# Rules now synced via git
```

---

## 📂 Project Rules Reference

### What Rules Exist

**Google Sheets Scripts (Apps Script Projects):**
- `.cursor/rules/gasprojectrules.mdc` - Multi-agent color system (RED/BLUE/GREEN/YELLOW teams)
- `.cursor/rules/alloy.mdc` - Alloy project specifics
- `.cursor/rules/costcolongterm.mdc` - Costco project patterns

**ZipWise (React Native Mobile App):**
- `.cursor/rules/multiagent.mdc` - Team coordination system
- `.cursor/rules/zipwise-dev-rules.mdc` - Offline-first patterns, battery optimization

**Twilio Connection:**
- `.cursor/rules/twilio.mdc` - SMS automation patterns

---

## ✅ Verification Checklist (8GB Mac)

### Terminal Setup
```bash
# Run these commands to verify everything works:

# 1. Check zsh config loaded
echo $PATH | grep homebrew    # Should show Homebrew paths

# 2. Test aliases
ll                            # Beautiful file listing (eza)
bat README.md                 # Syntax highlighted output
fd "*.md"                     # Fast file finding
rg "installation"             # Fast text search

# 3. Test FZF
# Ctrl-T     → Fuzzy file finder
# Ctrl-R     → Fuzzy history search
# Alt-C      → Fuzzy directory changer

# 4. Test git
gs                            # git status (alias)
glog                          # Pretty git log (alias)

# 5. Test tmux
tmux                          # Should open with custom config
# Ctrl-b %   → Split vertically
# Ctrl-b "   → Split horizontally
# exit       → Close tmux
```

### Cursor Setup
```bash
# 1. Check MCP config exists
cat ~/.cursor/mcp.json        # Should show 5 MCP servers

# 2. Open Cursor and verify:
#    - Settings → MCP Servers shows 5 active servers
#    - Can access Salesforce via Composio/Rube
#    - Can query Supabase database
```

### Project Rules
```bash
# Check rules exist in projects:
ls ~/Google-Sheets-Scripts/.cursor/rules/
ls ~/Google-Sheets-Scripts/ZipWise/.cursor/rules/

# Should show *.mdc files
```

---

## 🔄 Keeping Things Synced

### Update Dotfiles

When you make changes on either computer:

**After editing configs on EITHER Mac:**
```bash
cd ~/dotfiles  # or ~/Library/Mobile Documents/com~apple~CloudDocs/dotfiles
git add -A
git commit -m "Update terminal configs"
git push origin main
```

**To pull changes on OTHER Mac:**
```bash
cd ~/dotfiles
git pull origin main
source ~/.zshrc  # Reload immediately
```

### Update Project Rules

Project rules are in each project's git repo:

```bash
# In any project directory
cd ~/Google-Sheets-Scripts/ZipWise
git add .cursor/rules/*.mdc
git commit -m "Update Cursor rules"
git push

# On other computer
git pull  # Rules synced!
```

---

## 🆘 Troubleshooting

### "command not found" errors
```bash
# Reload zsh config
source ~/.zshrc

# If still broken, reinstall
cd ~/dotfiles
./install.sh
```

### MCP servers not showing in Cursor
```bash
# Check file exists
ls -la ~/.cursor/mcp.json

# If missing, rerun installer
cd ~/dotfiles
./install.sh

# Restart Cursor completely
```

### Project rules not working
```bash
# Rules must be in .cursor/rules/ within project
# Check location:
find ~/Google-Sheets-Scripts -name "*.mdc"

# If missing, pull from git or copy from 16GB Mac
```

### Symlinks broken
```bash
# Check what ~/.zshrc points to
ls -la ~/.zshrc

# Should show: /Users/[you]/dotfiles/.zshrc

# If broken, recreate:
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/cursor-mcp.json ~/.cursor/mcp.json
```

---

## 📸 Screenshot Reference

See `8gb-computer-location.png` showing the 8GB Mac's file structure with dotfiles folder at `~/dotfiles/`.

---

## 🎯 Quick Start TL;DR

**On 8GB Mac:**
```bash
# 1. Update dotfiles
cd ~/dotfiles
git pull origin main

# 2. Run installer (installs everything)
./install.sh

# 3. Open NEW terminal window
# Terminal now has 40+ aliases, beautiful tools, etc.

# 4. Verify Cursor MCP settings
cat ~/.cursor/mcp.json  # Should show 5 MCP servers

# 5. Open Cursor - MCP integrations active immediately

# 6. Clone or sync projects to get project-specific rules
git clone https://github.com/kyle-bartlett/Google-Sheets-Scripts.git ~/Google-Sheets-Scripts
```

**Done!** 🎉

---

**Last Updated:** October 7, 2025
