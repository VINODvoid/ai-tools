# Extended Thinking - Deep Reasoning Mode

**Unlock Claude's deepest reasoning capabilities**

---

## What is Extended Thinking

**Extended thinking** allows Claude to reason through complex problems before responding, showing thought process in italicized text.

### How to Enable

**Method 1: Tab key**
```
Press Tab during session to toggle
```

**Method 2: Include in prompt**
```
> think about the best architecture for this system
> think hard about potential security vulnerabilities
> keep thinking about edge cases
```

**Method 3: Set environment variable**
```bash
export MAX_THINKING_TOKENS=10000
claude
```

---

## Thinking Levels

### Basic Thinking
- **Trigger:** `Tab` or "think"
- Moderate reasoning depth
- Good for standard problems
- ~1-3x token multiplier

### Deep Thinking
- **Trigger:** "think hard", "keep thinking"
- Intensified reasoning
- Better for complex problems
- ~3-5x token multiplier

### Ultra Thinking
- **Trigger:** "ultrathink"
- Deepest reasoning available
- Most challenging problems
- ~5-10x token multiplier

---

## When to Use

✅ **Use extended thinking for:**
- Complex architectural decisions
- Security analysis
- Debugging tricky issues
- Understanding unfamiliar code
- Evaluating tradeoffs

❌ **Don't use for:**
- Simple questions
- Straightforward code generation
- Quick searches

---

**Unlock deeper reasoning!** 🧠
