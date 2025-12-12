# Performance Optimization - Speed Up Claude Code

**Make Claude Code faster and more efficient**

---

## Response Speed

### Use Appropriate Models

**Haiku (fastest):**
```bash
claude --model haiku -p "Find pattern in code"
# For: Searches, simple tasks
# Speed: ~2-3x faster than Sonnet
# Cost: ~20x cheaper
```

**Sonnet (balanced):**
```bash
claude --model sonnet
# For: General development
# Speed: Standard
# Cost: Medium
```

**Opus (slowest but most capable):**
```bash
claude --model opus
# For: Complex analysis, security reviews
# Speed: Slower
# Cost: Highest
```

---

## Context Optimization

### Keep Context Clean

```
# Monitor context
> /context

# Compact at 60-70%
> /compact

# Clear between unrelated tasks
> /clear
```

### Load Files Strategically

**Slow:**
```
> Read all files in @src/
# Loads everything
```

**Fast:**
```
> ! grep -r "pattern" src/
> Read @src/specific-file.ts
# Only loads what's needed
```

---

## Network Optimization

### Check Connection

```bash
# Test API latency
ping api.anthropic.com

# Check bandwidth
curl -o /dev/null https://api.anthropic.com
```

### Use Caching

```bash
# Enable cache (default)
export CLAUDE_CACHE_ENABLED=true

# Set cache location to fast disk
export CLAUDE_CACHE_DIR=/ssd/claude-cache
```

---

## System Resources

### Increase Performance

```bash
# More memory for Node
export NODE_OPTIONS="--max-old-space-size=4096"

# Use fast terminal
# Alacritty, Kitty (GPU-accelerated)
# Not: default Terminal.app
```

---

## Measuring Performance

```bash
# Time operations
time claude -p "Task"

# Profile session
claude --verbose | ts -s

# Monitor tokens/second
claude --debug api
```

---

**Optimize for maximum speed!** 🚀
