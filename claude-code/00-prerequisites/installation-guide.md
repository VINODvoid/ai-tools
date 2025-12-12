# Installation Guide - Claude Code CLI

**Complete installation and setup for all platforms**

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation Methods](#installation-methods)
- [Platform-Specific Instructions](#platform-specific-instructions)
- [API Key Setup](#api-key-setup)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Next Steps](#next-steps)

---

## Prerequisites

Before installing Claude Code, ensure you have:

### Required
- **Operating System**: Linux, macOS, or Windows (WSL2 recommended)
- **Terminal**: bash, zsh, fish, or PowerShell
- **Internet Connection**: For downloading and API calls
- **Disk Space**: 500MB minimum
- **Anthropic API Key**: [Get one here](https://console.anthropic.com/)

### Recommended
- **Node.js**: 18+ (for JavaScript/TypeScript development)
- **Git**: Latest version
- **Text Editor**: VS Code, Vim, Neovim, or similar
- **Modern Terminal**: iTerm2 (macOS), Windows Terminal, Alacritty, etc.

---

## Installation Methods

### Method 1: NPM/NPX (Recommended)

**Global Installation:**
```bash
npm install -g @anthropic-ai/claude-code
```

**Run without installing:**
```bash
npx @anthropic-ai/claude-code
```

**Verify:**
```bash
claude --version
```

### Method 2: Homebrew (macOS/Linux)

```bash
brew tap anthropics/claude-code
brew install claude-code
```

**Update later:**
```bash
brew upgrade claude-code
```

### Method 3: Download Binary

**Linux (Arch/Ubuntu/Debian):**
```bash
# Download latest release
curl -fsSL https://github.com/anthropics/claude-code/releases/latest/download/claude-linux-x64 -o claude

# Make executable
chmod +x claude

# Move to PATH
sudo mv claude /usr/local/bin/

# Verify
claude --version
```

**macOS:**
```bash
# Download for your architecture
# For Apple Silicon (M1/M2/M3):
curl -fsSL https://github.com/anthropics/claude-code/releases/latest/download/claude-macos-arm64 -o claude

# For Intel Mac:
curl -fsSL https://github.com/anthropics/claude-code/releases/latest/download/claude-macos-x64 -o claude

# Make executable
chmod +x claude

# Move to PATH
sudo mv claude /usr/local/bin/

# Verify
claude --version
```

**Windows (WSL2):**
```bash
# Inside WSL2 terminal
curl -fsSL https://github.com/anthropics/claude-code/releases/latest/download/claude-linux-x64 -o claude
chmod +x claude
sudo mv claude /usr/local/bin/
```

---

## Platform-Specific Instructions

### Arch Linux (Your Setup)

**Using AUR:**
```bash
# With yay
yay -S claude-code-bin

# With paru
paru -S claude-code-bin

# Manual build
git clone https://aur.archlinux.org/claude-code-bin.git
cd claude-code-bin
makepkg -si
```

**Post-Installation:**
```bash
# Verify installation
which claude
claude --version

# Check permissions
ls -la $(which claude)
```

### macOS

**Additional Steps:**

1. **Security Permissions** (first run):
   ```bash
   claude
   # If blocked: System Preferences > Security & Privacy > Allow
   ```

2. **Add to Shell Profile** (if using Homebrew):
   ```bash
   # For zsh (default on modern macOS)
   echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
   source ~/.zshrc
   ```

### Ubuntu/Debian

```bash
# Install via npm (easiest)
sudo apt update
sudo apt install nodejs npm
sudo npm install -g @anthropic-ai/claude-code

# Or download binary (see Method 3 above)
```

### Windows (Native - Experimental)

```powershell
# Install via npm
npm install -g @anthropic-ai/claude-code

# Or use WSL2 (recommended)
wsl --install
# Then follow Linux instructions
```

---

## API Key Setup

### Step 1: Get Your API Key

1. Go to https://console.anthropic.com/
2. Sign up or log in
3. Navigate to **API Keys** section
4. Click **Create Key**
5. Name it (e.g., "claude-code-dev")
6. Copy the key (starts with `sk-ant-`)
7. **Save it securely** - it won't be shown again

### Step 2: Configure API Key

**Option 1: Environment Variable (Recommended)**

Add to your shell configuration file:

```bash
# For bash (~/.bashrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
source ~/.bashrc

# For zsh (~/.zshrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.zshrc
source ~/.zshrc

# For fish (~/.config/fish/config.fish)
echo 'set -x ANTHROPIC_API_KEY "sk-ant-your-key-here"' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

**Option 2: Claude Code Settings File**

```bash
# Create settings directory
mkdir -p ~/.claude

# Create settings file
cat > ~/.claude/settings.json << 'EOF'
{
  "apiKey": "sk-ant-your-key-here"
}
EOF

# Secure the file
chmod 600 ~/.claude/settings.json
```

**Option 3: Interactive Setup**

```bash
# Claude will prompt for API key on first run
claude

# Enter key when prompted
# It will be saved to ~/.claude/settings.json
```

### Step 3: Verify API Key

```bash
# Test connection
claude -p "Hello, Claude!"

# Should get a response
# If error: "Invalid API key" - check your key
```

---

## Verification

### Basic Verification

```bash
# Check version
claude --version
# Expected: claude-code version X.X.X

# Check help
claude --help
# Should show command options

# Test interactive mode
claude
# Should start REPL
# Type: Hello
# Get response
# Exit: Ctrl+C or Ctrl+D
```

### Advanced Verification

```bash
# Test print mode
claude -p "What is 2+2?"
# Should output: 4

# Test with file operations
cd /tmp
mkdir claude-test
cd claude-test
echo "console.log('test')" > test.js
claude -p "Explain the code in test.js"
# Should read and explain the file

# Clean up
cd ..
rm -rf claude-test
```

### Check Installation Paths

```bash
# Find Claude binary
which claude
# Expected: /usr/local/bin/claude or similar

# Check npm global packages (if installed via npm)
npm list -g --depth=0 | grep claude
# Expected: @anthropic-ai/claude-code@X.X.X

# Verify permissions
ls -la $(which claude)
# Should be executable (rwxr-xr-x)
```

---

## Troubleshooting

### Issue: "claude: command not found"

**Solution 1: PATH not set**
```bash
# Find where claude is installed
find / -name claude 2>/dev/null

# Add to PATH temporarily
export PATH="/path/to/claude/directory:$PATH"

# Add permanently to shell config
echo 'export PATH="/path/to/claude/directory:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Solution 2: Reinstall**
```bash
# Using npm
sudo npm install -g @anthropic-ai/claude-code

# Verify
which claude
```

### Issue: "Permission denied"

```bash
# Fix permissions
chmod +x $(which claude)

# If in user directory
sudo chown $USER:$USER $(which claude)
```

### Issue: "API key not found"

```bash
# Check if environment variable is set
echo $ANTHROPIC_API_KEY
# Should show: sk-ant-...

# If empty, set it
export ANTHROPIC_API_KEY="sk-ant-your-key-here"

# Make permanent
echo 'export ANTHROPIC_API_KEY="sk-ant-your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: "Invalid API key"

```bash
# Verify key format
echo $ANTHROPIC_API_KEY
# Should start with: sk-ant-

# Test key via curl
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-3-5-sonnet-20241022","max_tokens":10,"messages":[{"role":"user","content":"Hi"}]}'

# If error: Get new key from console.anthropic.com
```

### Issue: "Network connection failed"

```bash
# Check internet connection
ping api.anthropic.com

# Check proxy settings (if using proxy)
echo $HTTP_PROXY
echo $HTTPS_PROXY

# If behind corporate proxy, set:
export HTTPS_PROXY="http://proxy.company.com:8080"
```

### Issue: Node.js version too old

```bash
# Check Node version
node --version
# Needs: v18 or higher

# Update Node.js
# Using nvm (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install 18
nvm use 18

# Or using package manager
# Ubuntu/Debian:
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Arch:
sudo pacman -S nodejs npm
```

---

## Next Steps

Once installed and verified:

1. **Read First Steps Guide**
   - [first-steps.md](first-steps.md) - Your first Claude session

2. **Configure Your Environment**
   - [environment-setup.md](environment-setup.md) - Optimize your setup

3. **Learn Basic Commands**
   - [../01-fundamentals/basic-commands.md](../01-fundamentals/basic-commands.md)

4. **Set Up Your First Project**
   ```bash
   cd ~/projects/my-project
   claude
   > /init
   # This creates .claude/CLAUDE.md for project memory
   ```

---

## Best Practices

### Security

- **Never commit API keys** to git
- Add to `.gitignore`:
  ```bash
  echo '.env' >> .gitignore
  echo '.claude/settings.local.json' >> .gitignore
  ```
- Use environment variables, not hardcoded keys
- Rotate keys periodically
- Use separate keys for different environments (dev/prod)

### Shell Configuration

```bash
# Add to ~/.bashrc or ~/.zshrc

# Claude Code API Key
export ANTHROPIC_API_KEY="sk-ant-your-key-here"

# Optional: Set default model
export CLAUDE_DEFAULT_MODEL="claude-sonnet-4-5-20250929"

# Optional: Enable extended thinking by default
export MAX_THINKING_TOKENS=10000

# Optional: Set proxy if needed
# export HTTPS_PROXY="http://proxy:8080"

# Alias for quick access
alias cc="claude"
alias ccp="claude -p"
alias ccc="claude -c"
```

### Directory Organization

```bash
# Create workspace for Claude projects
mkdir -p ~/claude-projects
cd ~/claude-projects

# Each project gets its own config
project-a/
  .claude/
    CLAUDE.md           # Project memory
    settings.json       # Project settings
    agents/             # Custom subagents
    commands/           # Custom slash commands

project-b/
  .claude/
    CLAUDE.md
    settings.json
```

---

## Official Resources

- **Documentation**: https://code.claude.com/docs/
- **Installation Guide**: https://code.claude.com/docs/en/installation.md
- **CLI Reference**: https://code.claude.com/docs/en/cli-reference.md
- **GitHub**: https://github.com/anthropics/claude-code
- **API Console**: https://console.anthropic.com/
- **Support**: https://github.com/anthropics/claude-code/issues

---

**Installation Complete!** 🎉

Continue to → [first-steps.md](first-steps.md)
