# Common Issues - Troubleshooting Guide

**Solutions to frequently encountered problems**

---

## Installation Issues

### Issue: "claude: command not found"

**Cause:** Claude Code not in PATH

**Solution:**
```bash
# Find where installed
which claude

# If not found, reinstall
npm install -g @anthropic-ai/claude-code

# Verify
claude --version
```

### Issue: "Permission denied"

**Cause:** Insufficient permissions

**Solution:**
```bash
# Fix permissions
chmod +x $(which claude)

# Or reinstall with correct permissions
sudo npm install -g @anthropic-ai/claude-code
```

---

## API Key Issues

### Issue: "API key not found"

**Cause:** Environment variable not set

**Solution:**
```bash
# Check if set
echo $ANTHROPIC_API_KEY

# Set temporarily
export ANTHROPIC_API_KEY="sk-ant-..."

# Set permanently (add to ~/.bashrc or ~/.zshrc)
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
source ~/.bashrc
```

### Issue: "Invalid API key"

**Cause:** Wrong key or expired

**Solution:**
1. Get new key from https://console.anthropic.com/
2. Update environment variable
3. Verify format starts with `sk-ant-`

---

## Context Issues

### Issue: Context filling too fast

**Cause:** Loading too many files

**Solution:**
```
# Check what's using context
> /context

# Compact history
> /compact

# Or clear and start fresh
> /clear

# Use search instead of read
> ! grep -r "pattern" src/
# Instead of reading all files
```

### Issue: "Context window exceeded"

**Cause:** Hit 200K token limit

**Solution:**
```
# Immediate fix
> /clear

# Prevention
> /context  # Check regularly
> /compact  # At 60-70%

# Use subagents for separate tasks
> Use Explore subagent to search
```

---

## File Operation Issues

### Issue: File not found

**Cause:** Wrong path or file doesn't exist

**Solution:**
```
# List files
> What files are in @src/?

# Use correct path
> Read @src/app.ts  # Not @app.ts
```

### Issue: Can't edit file

**Cause:** Permission issues or file locked

**Solution:**
```bash
# Check permissions
ls -la path/to/file

# Fix permissions
chmod 644 path/to/file

# Check if file is locked
lsof path/to/file
```

---

## Git Issues

### Issue: Commit hooks fail

**Cause:** Pre-commit hooks modify files

**Solution:**
```
> The pre-commit hook modified files
> Amend the commit to include changes

# Claude will:
# 1. Check it's safe to amend
# 2. Amend the commit
# 3. Include hook changes
```

### Issue: Push rejected

**Cause:** Behind remote branch

**Solution:**
```
> ! git pull --rebase origin main
> # Resolve conflicts if any
> ! git push
```

---

## MCP Server Issues

### Issue: MCP server not available

**Cause:** Server not installed or configured

**Solution:**
```bash
# Check installation
claude mcp list

# Reinstall
claude mcp remove github
claude mcp add --transport http github https://api.githubcopilot.com/mcp/

# Verify
claude mcp list
```

### Issue: Authentication failed

**Cause:** Missing or invalid credentials

**Solution:**
```bash
# Check credentials
echo $GITHUB_TOKEN

# Re-authenticate
claude
> /mcp
# Follow OAuth flow
```

---

## Performance Issues

### Issue: Claude is slow

**Causes & Solutions:**

1. **Large context:**
   ```
   > /context
   # If >70%, compact
   > /compact
   ```

2. **Network issues:**
   ```bash
   # Check connection
   ping api.anthropic.com
   ```

3. **Using Opus unnecessarily:**
   ```bash
   # Use faster models for simple tasks
   claude --model haiku
   ```

---

## Quick Fixes

### Reset Everything

```bash
# Clear all sessions
rm -rf ~/.claude/sessions/

# Clear cache
rm -rf ~/.claude/cache/

# Restart Claude
claude
```

### Debug Mode

```bash
# Enable full debug output
claude --debug

# Check logs
tail -f ~/.claude/debug.log
```

### Verify Installation

```bash
# Check version
claude --version

# Check Node version (needs 18+)
node --version

# Reinstall if needed
npm install -g @anthropic-ai/claude-code
```

---

**Most issues are easily fixable!** 🔧
