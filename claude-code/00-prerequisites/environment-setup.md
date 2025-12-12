# Environment Setup - Optimize Your Claude Code Experience

**Configure your development environment for maximum productivity**

---

## Table of Contents

- [Terminal Configuration](#terminal-configuration)
- [Shell Integration](#shell-integration)
- [Editor Integration](#editor-integration)
- [Git Configuration](#git-configuration)
- [Project Structure](#project-structure)
- [Performance Optimization](#performance-optimization)
- [Arch Linux Specific](#arch-linux-specific-your-setup)
- [Advanced Configuration](#advanced-configuration)

---

## Terminal Configuration

### Choose Your Terminal

**Recommended Terminals:**

| Terminal | Platform | Features | Best For |
|----------|----------|----------|----------|
| **Alacritty** | Linux, macOS, Windows | GPU-accelerated, fast | Performance |
| **Kitty** | Linux, macOS | GPU-accelerated, images | Features |
| **iTerm2** | macOS | Rich features | macOS users |
| **Windows Terminal** | Windows | Modern, tabs | Windows |
| **WezTerm** | All platforms | GPU, Lua config | Customization |

### Alacritty Setup (Recommended for Arch)

```bash
# Install
sudo pacman -S alacritty

# Create config directory
mkdir -p ~/.config/alacritty

# Create configuration
cat > ~/.config/alacritty/alacritty.yml << 'EOF'
# Font configuration
font:
  normal:
    family: "JetBrainsMono Nerd Font"
    style: Regular
  bold:
    family: "JetBrainsMono Nerd Font"
    style: Bold
  italic:
    family: "JetBrainsMono Nerd Font"
    style: Italic
  size: 12.0

# Colors (Tokyo Night theme)
colors:
  primary:
    background: '0x1a1b26'
    foreground: '0xa9b1d6'
  normal:
    black:   '0x32344a'
    red:     '0xf7768e'
    green:   '0x9ece6a'
    yellow:  '0xe0af68'
    blue:    '0x7aa2f7'
    magenta: '0xad8ee6'
    cyan:    '0x449dab'
    white:   '0x787c99'

# Window settings
window:
  padding:
    x: 10
    y: 10
  opacity: 0.95

# Scrollback buffer
scrolling:
  history: 10000

# Cursor
cursor:
  style: Block
  unfocused_hollow: true
EOF

# Install Nerd Font
yay -S ttf-jetbrains-mono-nerd
```

### Kitty Setup (Alternative)

```bash
# Install
sudo pacman -S kitty

# Config at ~/.config/kitty/kitty.conf
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Font
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 12.0

# Theme
include ./tokyo-night.conf

# Cursor
cursor_shape block
cursor_blink_interval 0

# Mouse
mouse_hide_wait 3.0
url_style curly

# Window
remember_window_size  yes
initial_window_width  1200
initial_window_height 800

# Performance
repaint_delay 10
input_delay 3
sync_to_monitor yes

# Tab bar
tab_bar_style powerline
tab_powerline_style slanted

# Clipboard
clipboard_control write-clipboard write-primary
EOF
```

---

## Shell Integration

### Zsh Configuration (Recommended)

**Install Oh My Zsh:**
```bash
# Install zsh
sudo pacman -S zsh

# Make default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Configure ~/.zshrc:**
```bash
cat >> ~/.zshrc << 'EOF'

# ============================================
# Claude Code Configuration
# ============================================

# API Key (CRITICAL - never commit this!)
export ANTHROPIC_API_KEY="sk-ant-your-key-here"

# Default Model
export CLAUDE_DEFAULT_MODEL="claude-sonnet-4-5-20250929"

# Extended Thinking (optional)
export MAX_THINKING_TOKENS=10000

# Claude Code Aliases
alias cc="claude"                    # Quick launch
alias ccp="claude -p"               # Print mode
alias ccc="claude -c"               # Continue last conversation
alias ccr="claude --resume"         # Resume picker
alias cch="claude --help"           # Help

# Project-specific Claude functions
function claude-init() {
    if [ ! -d ".claude" ]; then
        mkdir -p .claude
        claude -p "Create a CLAUDE.md for this project"
    else
        echo ".claude directory already exists"
    fi
}

function claude-status() {
    echo "=== Claude Code Status ==="
    echo "Version: $(claude --version)"
    echo "API Key: ${ANTHROPIC_API_KEY:0:20}..."
    echo "Model: $CLAUDE_DEFAULT_MODEL"
    echo "Project Config: $([ -f .claude/CLAUDE.md ] && echo '✓ Found' || echo '✗ Not found')"
}

# Auto-compact on resume
export CLAUDE_AUTO_COMPACT=true

# ============================================
# Development Environment
# ============================================

# Node.js version management (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# ============================================
# Plugins
# ============================================

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    npm
    node
)

# Install plugins if needed:
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Theme
ZSH_THEME="agnoster"  # or "powerlevel10k/powerlevel10k"

EOF

# Reload
source ~/.zshrc
```

### Bash Configuration (Alternative)

**Configure ~/.bashrc:**
```bash
cat >> ~/.bashrc << 'EOF'

# Claude Code Configuration
export ANTHROPIC_API_KEY="sk-ant-your-key-here"
export CLAUDE_DEFAULT_MODEL="claude-sonnet-4-5-20250929"
export MAX_THINKING_TOKENS=10000

# Aliases
alias cc="claude"
alias ccp="claude -p"
alias ccc="claude -c"

# Functions
claude-init() {
    [ ! -d ".claude" ] && mkdir -p .claude && claude -p "Create CLAUDE.md"
}

EOF

source ~/.bashrc
```

### Fish Configuration

```bash
# Install fish
sudo pacman -S fish

# Make default
chsh -s $(which fish)

# Configure (~/.config/fish/config.fish)
cat >> ~/.config/fish/config.fish << 'EOF'

# Claude Code
set -x ANTHROPIC_API_KEY "sk-ant-your-key-here"
set -x CLAUDE_DEFAULT_MODEL "claude-sonnet-4-5-20250929"
set -x MAX_THINKING_TOKENS 10000

# Aliases
alias cc="claude"
alias ccp="claude -p"
alias ccc="claude -c"

# Functions
function claude-init
    if not test -d .claude
        mkdir -p .claude
        claude -p "Create CLAUDE.md for this project"
    else
        echo ".claude already exists"
    end
end

EOF
```

---

## Editor Integration

### VS Code Integration

**Install Extensions:**
```bash
# Anthropic Claude extension (official)
code --install-extension Anthropic.claude-code

# Related useful extensions
code --install-extension GitHub.copilot
code --install-extension ms-python.python
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
```

**Configure settings.json:**
```json
{
  "claude-code.apiKey": "Use environment variable",
  "claude-code.model": "claude-sonnet-4-5-20250929",
  "claude-code.autoSuggest": true,

  "terminal.integrated.shell.linux": "/bin/zsh",
  "terminal.integrated.fontSize": 13,

  "editor.fontSize": 14,
  "editor.fontFamily": "'JetBrainsMono Nerd Font', monospace",
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",

  "files.exclude": {
    "**/.claude/cache": true
  }
}
```

### Neovim Integration

**Install lazy.nvim and configure:**
```lua
-- ~/.config/nvim/lua/plugins/claude.lua
return {
  {
    "anthropics/claude-nvim",
    config = function()
      require("claude").setup({
        api_key = os.getenv("ANTHROPIC_API_KEY"),
        model = "claude-sonnet-4-5-20250929",

        keymaps = {
          ask = "<leader>ca",
          explain = "<leader>ce",
          fix = "<leader>cf",
          optimize = "<leader>co",
        }
      })
    end
  }
}
```

### Vim Integration

```vim
" ~/.vimrc
" Claude Code integration

" Quick ask Claude
nnoremap <leader>ca :!claude -p "Explain this code: " % <CR>

" Send selection to Claude
vnoremap <leader>cs :w !claude -p<CR>

" Open Claude in terminal split
nnoremap <leader>cc :split \| terminal claude<CR>
```

---

## Git Configuration

### Global Git Config for Claude Code

```bash
# Configure Git for Claude Code workflows
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Default branch name
git config --global init.defaultBranch main

# Editor for commit messages
git config --global core.editor "vim"

# Helpful aliases for Claude workflows
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
git config --global alias.unstage 'reset HEAD --'

# Pretty log for Claude to analyze
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Diff configuration
git config --global diff.algorithm histogram
git config --global merge.conflictStyle diff3

# Auto-stash when pulling
git config --global rebase.autoStash true

# Sign commits (recommended)
git config --global commit.gpgsign false  # Enable if you have GPG
```

### Git Ignore for Claude Projects

**Global gitignore:**
```bash
# Create global gitignore
cat > ~/.gitignore_global << 'EOF'
# Claude Code
.claude/cache/
.claude/sessions/
.claude/settings.local.json
CLAUDE.local.md

# API Keys
.env
.env.local
*.key
credentials.json

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Node
node_modules/
npm-debug.log

# Python
__pycache__/
*.py[cod]
venv/

EOF

# Apply globally
git config --global core.excludesfile ~/.gitignore_global
```

**Project-specific .gitignore:**
```bash
# Add to each project's .gitignore
cat >> .gitignore << 'EOF'

# Claude Code local settings
.claude/settings.local.json
CLAUDE.local.md

EOF
```

---

## Project Structure

### Optimal Project Layout

```
your-project/
├── .claude/
│   ├── CLAUDE.md                 # Team-shared memory
│   ├── CLAUDE.local.md           # Personal notes (gitignored)
│   ├── settings.json             # Team settings
│   ├── settings.local.json       # Personal settings (gitignored)
│   ├── agents/                   # Custom subagents
│   │   ├── code-reviewer.md
│   │   ├── test-runner.md
│   │   └── security-auditor.md
│   ├── commands/                 # Custom slash commands
│   │   ├── test.md
│   │   ├── deploy.md
│   │   └── review.md
│   ├── rules/                    # Modular rules
│   │   ├── code-style.md
│   │   ├── testing.md
│   │   └── security.md
│   └── skills/                   # Custom skills
│       └── api-testing.md
├── src/                          # Your code
├── tests/                        # Tests
├── docs/                         # Documentation
├── .git/                         # Git repo
├── .gitignore                    # Git ignore
├── package.json                  # Node project
└── README.md                     # Project readme
```

### Initialize New Project

```bash
# Create project
mkdir my-project
cd my-project

# Initialize git
git init

# Initialize Claude
claude
> /init

# This creates .claude/CLAUDE.md with template

# Add to git
git add .claude/CLAUDE.md
git add .gitignore

# Commit
git commit -m "Initial commit with Claude Code setup"
```

---

## Performance Optimization

### System Requirements

**Minimum:**
- 2GB RAM
- 1GB free disk space
- Stable internet (500kbps+)

**Recommended:**
- 8GB+ RAM
- 5GB free disk space
- Fast internet (5Mbps+)
- SSD storage

### Optimize for Speed

**1. Disk Cache Configuration:**
```bash
# Create cache directory
mkdir -p ~/.claude/cache

# Set cache size limit (in settings.json)
cat > ~/.claude/settings.json << 'EOF'
{
  "cache": {
    "enabled": true,
    "maxSizeMB": 1000,
    "ttlHours": 24
  },
  "performance": {
    "maxConcurrentRequests": 5,
    "requestTimeout": 30000
  }
}
EOF
```

**2. Network Optimization:**
```bash
# If behind proxy
export HTTPS_PROXY="http://proxy:8080"
export NO_PROXY="localhost,127.0.0.1"

# DNS optimization (add to /etc/hosts)
sudo cat >> /etc/hosts << 'EOF'
# Anthropic API
52.85.165.45 api.anthropic.com
EOF
```

**3. Terminal Performance:**
```bash
# Disable shell bloat in ~/.zshrc
# Comment out unused plugins
# Use faster theme (pure, starship)

# Install starship (fast prompt)
sudo pacman -S starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

---

## Arch Linux Specific (Your Setup)

### Pacman Configuration

```bash
# Optimize pacman for faster downloads
sudo vim /etc/pacman.conf

# Uncomment/add:
# ParallelDownloads = 5
# Color
```

### AUR Helper for Claude Updates

```bash
# Install yay if not already
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Update Claude Code
yay -S claude-code-bin

# Auto-update with systemd timer
systemctl --user enable --now yay-update.timer
```

### NVIDIA GPU Configuration

```bash
# If using NVIDIA GPU for ML work with Claude

# Install NVIDIA drivers
sudo pacman -S nvidia nvidia-utils

# Install CUDA toolkit
sudo pacman -S cuda cudnn

# Add to ~/.zshrc
export CUDA_HOME=/opt/cuda
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# Verify
nvidia-smi

# Now Claude can help with CUDA/PyTorch code
```

### Dotfiles Integration

```bash
# Add Claude config to your dotfiles repo
cd ~/dotfiles

# Create claude directory
mkdir -p claude

# Symlink configurations
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md

# Add to git
git add claude/
git commit -m "Add Claude Code configuration"
```

---

## Advanced Configuration

### Multi-Account Setup

```bash
# Work account
export ANTHROPIC_API_KEY_WORK="sk-ant-work-key"

# Personal account
export ANTHROPIC_API_KEY_PERSONAL="sk-ant-personal-key"

# Function to switch
switch-claude-work() {
    export ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY_WORK
    echo "Switched to work account"
}

switch-claude-personal() {
    export ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY_PERSONAL
    echo "Switched to personal account"
}

# Add to ~/.zshrc
```

### Proxy Configuration

```bash
# Corporate proxy
export HTTP_PROXY="http://proxy.company.com:8080"
export HTTPS_PROXY="http://proxy.company.com:8080"
export NO_PROXY="localhost,127.0.0.1,.company.com"

# With authentication
export HTTPS_PROXY="http://username:password@proxy:8080"

# Test proxy
curl -I https://api.anthropic.com
```

### Custom Settings Per Project

```bash
# Project A (strict settings)
# .claude/settings.json
{
  "permissions": {
    "defaultMode": "default",
    "alwaysRequireApproval": true
  },
  "tools": {
    "allowed": ["Read", "Grep", "Glob"]
  }
}

# Project B (permissive)
# .claude/settings.json
{
  "permissions": {
    "defaultMode": "acceptEdits"
  },
  "tools": {
    "allowed": ["*"]
  }
}
```

---

## Verification Checklist

After completing environment setup:

- [ ] Terminal configured with proper theme
- [ ] Shell integration working (test aliases)
- [ ] API key in environment variables
- [ ] Git configured for Claude workflows
- [ ] Editor integration setup
- [ ] Test Claude command: `claude -p "Hello"`
- [ ] Project structure template ready
- [ ] Performance optimizations applied

```bash
# Run verification script
cat > ~/verify-claude-setup.sh << 'EOF'
#!/bin/bash

echo "=== Claude Code Environment Verification ==="
echo ""

# Check Claude installation
if command -v claude &> /dev/null; then
    echo "✓ Claude Code installed: $(claude --version)"
else
    echo "✗ Claude Code not found"
fi

# Check API key
if [ -n "$ANTHROPIC_API_KEY" ]; then
    echo "✓ API Key configured: ${ANTHROPIC_API_KEY:0:20}..."
else
    echo "✗ API Key not set"
fi

# Check shell integration
if alias cc &> /dev/null; then
    echo "✓ Shell aliases configured"
else
    echo "✗ Shell aliases not found"
fi

# Check git configuration
if git config --global user.name &> /dev/null; then
    echo "✓ Git configured: $(git config --global user.name)"
else
    echo "✗ Git not configured"
fi

# Check terminal
echo "✓ Terminal: $TERM"

# Test Claude connection
echo ""
echo "Testing Claude API connection..."
if claude -p "ping" &> /dev/null; then
    echo "✓ API connection successful"
else
    echo "✗ API connection failed"
fi

echo ""
echo "=== Setup Complete ==="
EOF

chmod +x ~/verify-claude-setup.sh
~/verify-claude-setup.sh
```

---

## Next Steps

1. **Complete First Steps** → [first-steps.md](first-steps.md)
2. **Learn Basic Commands** → [../01-fundamentals/basic-commands.md](../01-fundamentals/basic-commands.md)
3. **Start Your First Project**
4. **Explore Templates** → [../07-templates/](../07-templates/)

---

**Environment Optimized!** 🚀

Your Claude Code setup is now production-ready.
