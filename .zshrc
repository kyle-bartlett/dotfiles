# ============================================================================
# KYLE'S ENHANCED ZSH CONFIG
# ============================================================================

# ---- Existing Config (Preserved) ----
# Quick setup for new Apps Script projects
gasnew() {
  local nickname="$1"
  local id="$2"

  if [ -z "$nickname" ]; then
    nickname="project-$(date +%Y-%m-%d-%H%M)"
    echo "No nickname provided. Using: $nickname"
  fi

  if [ -z "$id" ]; then
    read -r "id?Paste Apps Script ID: "
  fi

  mkdir -p "$HOME/gas-projects/$nickname"
  cd "$HOME/gas-projects/$nickname" || return
  clasp clone "$id"
  open -a "Cursor" .

  echo ""
  echo "✅ Project '$nickname' is ready in ~/gas-projects/$nickname"
  echo "---------------------------------------------"
  echo "Daily commands while inside this folder:"
  echo "   gass   # check status"
  echo "   gasp   # push local → Google"
  echo "   gaspl  # pull Google → local"
  echo "---------------------------------------------"
  echo ""
}

# Quick daily aliases
alias gasp='clasp push'
alias gaspl='clasp pull'
alias gass='clasp status'

# Docker Desktop completions
fpath=(/Users/kylebartlett/.docker/completions $fpath)
autoload -Uz compinit
compinit

# LM Studio CLI
export PATH="$PATH:/Users/kylebartlett/.lmstudio/bin"

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipx
export PATH="$PATH:/Users/kylebartlett/.local/bin"

# ============================================================================
# ENHANCED TERMINAL SETUP
# ============================================================================

# ---- Modern Tool Replacements ----
alias cat='bat --style=auto'
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'
alias lt3='eza --tree --level=3 --icons'
alias grep='rg'
alias find='fd'

# ---- Git Enhancements ----
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias glg='lazygit'

# ---- Project Navigation ----
alias projects='cd ~/Projects && ls'
alias gas='cd ~/Google-Sheets-Scripts'
alias sms='cd ~/auto_sms'
alias notes='cd ~/replit'  # Update when you migrate note app

# ---- File Operations ----
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# ---- System Monitoring ----
alias top='htop'
alias ports='lsof -i -P -n | grep LISTEN'
alias cpu='top -o cpu'
alias mem='top -o mem'

# ---- Development Tools ----
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias json='jq'
alias http='httpie'

# ---- Quick Edits ----
alias zshconfig='cursor ~/.zshrc'
alias reload='source ~/.zshrc && echo "✅ Zsh config reloaded"'

# ---- Docker Quick Commands ----
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dimg='docker images'
alias dstop='docker stop $(docker ps -aq)'
alias dclean='docker system prune -af'

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# ---- Quick Directory Jump with Preview ----
fcd() {
  local dir
  dir=$(fd --type d --hidden --exclude .git | fzf --preview 'eza --tree --level=1 --icons {}') && cd "$dir"
}

# ---- Search and Edit Files ----
fe() {
  local file
  file=$(fzf --preview 'bat --color=always --line-range :500 {}') && cursor "$file"
}

# ---- Search File Contents ----
rga() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

# ---- Git Branch Switcher ----
gcob() {
  local branch
  branch=$(git branch --all | grep -v HEAD | fzf --preview 'git log --oneline --graph --color=always {}') &&
  git checkout $(echo "$branch" | sed 's/.* //' | sed 's#remotes/origin/##')
}

# ---- Kill Process by Port ----
killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port_number>"
    return 1
  fi
  lsof -ti:$1 | xargs kill -9 && echo "✅ Killed process on port $1"
}

# ---- Quick Project Setup ----
mkproject() {
  local name=$1
  if [ -z "$name" ]; then
    echo "Usage: mkproject <project-name>"
    return 1
  fi

  mkdir -p "$HOME/Projects/$name" && cd "$HOME/Projects/$name"
  git init
  echo "# $name" > README.md
  echo ".env" > .gitignore
  echo "venv/" >> .gitignore
  echo "__pycache__/" >> .gitignore
  echo "node_modules/" >> .gitignore

  echo "✅ Created project: $name"
  echo "📂 Location: $HOME/Projects/$name"
}

# ---- Quick Git Commit & Push ----
gcp() {
  if [ -z "$1" ]; then
    echo "Usage: gcp <commit-message>"
    return 1
  fi
  git add . && git commit -m "$1" && git push
}

# ---- Test Flask/FastAPI Apps ----
testapi() {
  local port=${1:-5000}
  local endpoint=${2:-/health}
  echo "Testing http://localhost:$port$endpoint"
  http GET "localhost:$port$endpoint"
}

# ---- Quick SQLite Inspection ----
dbopen() {
  local db=$1
  if [ -z "$db" ]; then
    # Find .db files in current directory
    db=$(fd -e db | fzf)
  fi
  if [ -n "$db" ]; then
    litecli "$db"
  fi
}

# ---- Extract Any Archive ----
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ---- Quick GitHub Operations ----
ghclone() {
  local repo=$1
  if [[ $repo == http* ]]; then
    # Full URL provided
    git clone "$repo"
  else
    # Just repo name, use gh
    gh repo clone "$repo"
  fi
}

ghnew() {
  local name=$1
  local visibility=${2:-public}
  if [ -z "$name" ]; then
    echo "Usage: ghnew <repo-name> [public|private]"
    return 1
  fi
  gh repo create "$name" --$visibility --source=. --remote=origin --push
}

# ---- System Cleanup ----
cleanup() {
  echo "🧹 Cleaning up system..."

  # Homebrew cleanup
  brew cleanup
  brew autoremove

  # Docker cleanup
  docker system prune -f

  # Python cache
  find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null
  find . -type f -name "*.pyc" -delete 2>/dev/null

  # Node modules (use with caution)
  # find . -type d -name "node_modules" -prune -exec rm -rf {} +

  echo "✅ Cleanup complete!"
}

# ---- Environment Info ----
sysinfo() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "💻 System Information"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
  echo "Chip: $(sysctl -n machdep.cpu.brand_string)"
  echo "Memory: $(sysctl -n hw.memsize | awk '{print $0/1024/1024/1024" GB"}')"
  echo "Shell: $SHELL ($ZSH_VERSION)"
  echo "Terminal: $TERM_PROGRAM"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🐍 Python: $(python3 --version 2>&1)"
  echo "📦 Node: $(node --version 2>&1)"
  echo "🐳 Docker: $(docker --version 2>&1)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ---- Project-Specific Shortcuts ----

# Auto SMS helpers
sms-test() {
  cd ~/auto_sms && pytest --cov
}

sms-run() {
  cd ~/auto_sms && python auto_responder.py
}

# Google Sheets Scripts helpers
gas-health() {
  cd ~/Google-Sheets-Scripts && npm run health-check
}

gas-test() {
  cd ~/Google-Sheets-Scripts && npm test
}

# ============================================================================
# INTEGRATIONS
# ============================================================================

# ---- FZF Configuration ----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF default options
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --inline-info
  --preview 'bat --color=always --line-range :500 {}'
  --preview-window=right:50%:wrap
  --bind 'ctrl-/:toggle-preview'
  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
"

# ---- Z (Directory Jumper) ----
. /opt/homebrew/etc/profile.d/z.sh

# ---- Git Delta Configuration ----
export GIT_PAGER='delta'

# ============================================================================
# PROMPT ENHANCEMENT
# ============================================================================

# Enable Powerlevel10k instant prompt if available
# (Install with: brew install powerlevel10k)
# [[ -r "/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme" ]] &&
#   source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Simple custom prompt (if not using Powerlevel10k)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f %F{magenta}${vcs_info_msg_0_}%f$ '

# ============================================================================
# WELCOME MESSAGE
# ============================================================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Enhanced Terminal Loaded!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Quick commands:"
echo "  fcd      - fuzzy find directory"
echo "  fe       - fuzzy find & edit file"
echo "  rga      - ripgrep with preview"
echo "  gcob     - git branch switcher"
echo "  killport - kill process on port"
echo "  sysinfo  - system information"
echo "  cleanup  - clean system caches"
echo ""
echo "Type 'alias' to see all shortcuts"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
