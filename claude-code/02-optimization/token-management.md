# Token Management - Optimize Context Usage

**Reduce token costs by 30-50% through smart context management**

---

## Table of Contents

- [Understanding Tokens](#understanding-tokens)
- [Context Window Mechanics](#context-window-mechanics)
- [Measuring Token Usage](#measuring-token-usage)
- [Token Optimization Strategies](#token-optimization-strategies)
- [Context Compression](#context-compression)
- [Selective File Loading](#selective-file-loading)
- [Smart Conversation Patterns](#smart-conversation-patterns)
- [Cost Tracking and Budgeting](#cost-tracking-and-budgeting)
- [Advanced Optimization](#advanced-optimization)

---

## Understanding Tokens

### What is a Token?

A **token** is a chunk of text Claude processes. Roughly:

```
1 token ≈ 4 characters
1 token ≈ 0.75 words
100 tokens ≈ 75 words

Example:
"Hello, world!" = 4 tokens
"function calculateTotal(items) {" = 7 tokens
```

**Why tokens matter:**
- You're charged per token
- Limited context window
- More tokens = higher cost + slower responses

### Token Counting

**Input tokens:** Your prompts + context + files
**Output tokens:** Claude's responses

**Cost (approximate for Sonnet 4.5):**
- Input: $3 per 1M tokens
- Output: $15 per 1M tokens

**Real examples:**
```
Simple question: ~50 tokens input, ~200 tokens output
Code explanation: ~500 tokens input, ~800 tokens output
Full file review: ~2000 tokens input, ~1500 tokens output
Large refactoring: ~5000 tokens input, ~3000 tokens output
```

---

## Context Window Mechanics

### Context Window Size

```
Total context window: ~200,000 tokens
System prompt: ~20,000 tokens
Available for you: ~180,000 tokens
```

**What fills the context:**
1. System instructions (~20K tokens)
2. Memory files (CLAUDE.md, etc.)
3. Your conversation history
4. File contents you reference
5. Tool outputs (bash commands, searches)
6. Claude's responses

### Context Lifecycle

```
Session starts → Context: 0%
├─ Load CLAUDE.md → Context: 5%
├─ Your prompt → Context: 6%
├─ Read @large-file.ts → Context: 15%
├─ Claude responds → Context: 18%
├─ Read 5 more files → Context: 35%
├─ Long conversation → Context: 60%
├─ More file operations → Context: 85%
└─ AUTO-COMPACT triggers → Context: 45%
```

### Check Context Usage

```
> /context
```

**Output:**
```
Context usage: 45% (81,000 / 180,000 tokens)

Memory files loaded:
- Project: .claude/CLAUDE.md (1,200 tokens)
- User: ~/.claude/CLAUDE.md (800 tokens)

Conversation: 65,000 tokens
Files in context: 14,000 tokens
```

---

## Measuring Token Usage

### Real-Time Monitoring

```
> /context
# Shows current usage

> /cost
# Shows accumulated cost
```

**Example /cost output:**
```
Total cost: $1.23
Total duration (API): 12m 34s
Total duration (wall): 2h 15m 30s

Input tokens: 245,000
Output tokens: 89,000

Average per request:
- Input: 8,200 tokens
- Output: 3,000 tokens
```

### Estimating Costs

**Before starting work:**
```
# Check project size
> ! tokei src/

# Rough estimate:
# - 10K lines of code ≈ 40K tokens
# - Reviewing all would cost ~$0.12 input
# - Plus output costs
```

**During work:**
```
> /cost
# Check periodically

# If cost growing too fast:
> /compact
# Compress history
```

---

## Token Optimization Strategies

### Strategy 1: Don't Load Everything

❌ **Wasteful:**
```
> Read all files in @src/ and explain the architecture
# Loads thousands of tokens unnecessarily
```

✅ **Efficient:**
```
> Show me the directory structure of @src/

# After seeing structure:
> Read @src/index.ts to understand entry point

# Then:
> Read @src/routes/ overview

# Progressive loading as needed
```

### Strategy 2: Use Search Instead of Read

❌ **Wasteful:**
```
> Read all files in @src/ to find where User model is defined
# Loads everything
```

✅ **Efficient:**
```
> ! grep -r "class User" src/
# or
> Search for "class User" in @src/

# Then only read the specific file:
> Read @src/models/User.ts
```

### Strategy 3: Summarize Large Files

❌ **Wasteful:**
```
> Read @logs/application.log
# 100K line log file = massive tokens
```

✅ **Efficient:**
```
> ! grep "ERROR" logs/application.log | head -50

> Summarize these errors

# Or:
> What are the top 5 error types in @logs/application.log?
# Claude reads but summarizes
```

### Strategy 4: Clear Context Between Tasks

```
# Working on feature A
> Implement user authentication
# ...long conversation...

> /cost
# Total: $0.45

# Done with feature A, starting feature B
> /clear
# Reset context

> Implement payment processing
# Fresh start, previous context not using tokens
```

### Strategy 5: Use Subagents

```
# Instead of loading everything in main conversation:
> Use the Explore subagent to find all API endpoints

# Subagent runs separately, doesn't pollute main context
# Returns only summary to main conversation
```

### Strategy 6: Compact Strategically

```
# After completing a feature
> /compact Preserve:
> - API changes made
> - Database schema updates
> - Important decisions
> Summarize:
> - Debug attempts
> - Exploratory code reading
> - Earlier iterations
```

---

## Context Compression

### When to Compress

**Auto-compact triggers at 95%:**
- Automatic summarization
- Preserves important context
- Frees up space

**Manual compact:**
```
> /compact

# With focus:
> /compact Focus on the authentication feature changes

# Custom instructions:
> /compact Keep all code samples, summarize discussions
```

### What Gets Compressed

**Preserved:**
- Recent conversation (last ~10 turns)
- Code you wrote/modified
- Important decisions
- Error messages and fixes
- Commands run and outputs

**Summarized:**
- Early exploration
- Explanatory text
- Redundant information
- Intermediate iterations

**Example:**

**Before compact (10,000 tokens):**
```
You: Read @src/auth.ts
Claude: Here's the full file: [2000 tokens of code]
You: Explain how login works
Claude: [800 tokens explaining]
You: Can you add error handling?
Claude: Sure, here's the updated code: [2000 tokens]
You: Actually, use try-catch instead
Claude: Updated code: [2000 tokens]
You: Perfect, now add logging
Claude: Here's with logging: [2000 tokens]
[Plus 1200 tokens of discussion]
```

**After compact (2,500 tokens):**
```
Summary: Added error handling and logging to auth.ts login function.
Final code with try-catch error handling and debug logging implemented.
User approved final version.

Code: [Final 2000 token version]
```

### Compact Best Practices

1. **Before switching tasks:**
   ```
   > /compact Preserve auth feature work
   # Then start new task
   ```

2. **After debugging:**
   ```
   # After fixing bug with lots of trial/error
   > /compact Keep the fix, summarize debugging process
   ```

3. **Before major file operations:**
   ```
   > /context
   # At 80%
   
   > /compact
   # Free up space before loading more files
   ```

---

## Selective File Loading

### Pattern: Just-In-Time Loading

**Don't load files speculatively:**

❌ **Wasteful:**
```
> Read @src/app.ts, @src/server.ts, @src/config.ts, @src/database.ts
> I want to add a feature
```

✅ **Efficient:**
```
> I want to add user notifications
> Which files should I look at?

# Claude suggests files
# Then load only what's needed:

> Read @src/services/NotificationService.ts
```

### Pattern: Progressive Discovery

```
# Step 1: Overview
> What's the structure of @src/?

# Step 2: Entry point
> Read @src/index.ts

# Step 3: Specific module
> Based on index.ts, read @src/routes/users.ts

# Step 4: Implementation
> Now I understand the pattern, create notifications route
```

### Pattern: Summarize First

```
> Give me a high-level summary of @src/components/Dashboard.tsx
> Don't show all the code

# Claude reads but returns summary (saves tokens in conversation)

# If you need details:
> Now show me the data fetching logic
```

---

## Smart Conversation Patterns

### Pattern 1: Batch Questions

❌ **Token-Wasteful:**
```
> What does this project do?
# Response

> What's the tech stack?
# Response

> How is it structured?
# Response

> What are the main features?
# Response
```

✅ **Token-Efficient:**
```
> Tell me about this project:
> - What it does
> - Tech stack
> - Structure
> - Main features
```

### Pattern 2: Specific References

❌ **Wasteful:**
```
> I have a bug in my authentication code
# Claude asks: Which file?
> It's in the login function
# Claude asks: Which file has login?
> src/auth/login.ts
```

✅ **Efficient:**
```
> There's a bug in the login function in @src/auth/login.ts
> Users get 401 error even with correct credentials
```

### Pattern 3: Reuse Context

❌ **Wasteful:**
```
# After Claude reads a file:
> Create a new file like that one
# "What file?" - have to reload
```

✅ **Efficient:**
```
# After Claude reads @src/routes/users.ts:
> Create @src/routes/products.ts following the same pattern
# Claude remembers the pattern, no reload needed
```

### Pattern 4: Consolidate File Operations

❌ **Wasteful:**
```
> Fix @file1.ts
# ...fix applied...

> Now fix @file2.ts
# ...fix applied...

> Now fix @file3.ts
# ...fix applied...
```

✅ **Efficient:**
```
> Fix the same error in @file1.ts, @file2.ts, and @file3.ts
# All fixed in one turn
```

---

## Cost Tracking and Budgeting

### Set Daily Budget

```bash
# In your shell config
export DAILY_CLAUDE_BUDGET=5.00  # $5/day

# Create tracking script
cat > ~/bin/claude-cost-check << 'EOF'
#!/bin/bash
COST=$(claude -p "What's my session cost?" | grep -oP '\$\K[\d.]+')
if (( $(echo "$COST > $DAILY_CLAUDE_BUDGET" | bc -l) )); then
    echo "⚠️  Daily budget exceeded: \$$COST"
    exit 1
fi
EOF
chmod +x ~/bin/claude-cost-check
```

### Cost Optimization Targets

**Individual developer:**
- **Target:** $3-6/day
- **High:** $10+/day (review practices)

**Strategies to stay within budget:**

1. **Use Haiku for searches:**
   ```bash
   claude --model haiku -p "Find all TODO comments"
   # Cheaper model for simple tasks
   ```

2. **Use print mode for one-shots:**
   ```bash
   # Instead of interactive session for quick query:
   claude -p "Explain async/await"
   # No session overhead
   ```

3. **Clear context regularly:**
   ```
   > /clear
   # Between unrelated tasks
   ```

4. **Compact frequently:**
   ```
   > /context
   # If >50%, compact

   > /compact
   ```

### Track Per-Project Costs

```bash
# In project .claude/settings.json
{
  "costTracking": {
    "enabled": true,
    "budget": {
      "daily": 10.00,
      "monthly": 200.00
    },
    "alerts": {
      "50percent": true,
      "75percent": true,
      "90percent": true
    }
  }
}
```

---

## Advanced Optimization

### Technique 1: Pre-Process Large Files

```bash
# Instead of loading huge log in Claude:
# Pre-process with bash tools

grep "ERROR" huge.log | sort | uniq -c | sort -rn > error-summary.txt

# Then:
claude -p "Analyze this error summary" < error-summary.txt
# Much fewer tokens
```

### Technique 2: Use Memory Files Wisely

**Don't put everything in CLAUDE.md:**

❌ **Wasteful CLAUDE.md** (loaded every session):
```markdown
# Complete API Documentation
[5000 tokens of API docs]

# All Environment Variables  
[2000 tokens of env vars]

# Entire Database Schema
[3000 tokens of schema]

# Complete Coding Standards
[4000 tokens]
```

✅ **Efficient CLAUDE.md:**
```markdown
# Project: E-Commerce API

## Tech Stack
Node.js, Express, PostgreSQL, Redis

## Key Patterns
- Use async/await for all async operations
- Validate with Joi schemas (see @src/validators/)
- Error handling via middleware (see @src/middleware/errors.ts)

## Documentation Links
- API docs: @docs/api.md (load when needed)
- Database schema: @docs/schema.md (load when needed)
- Coding standards: @docs/standards.md (load when needed)
```

### Technique 3: Modular Rules

**Instead of one large CLAUDE.md, use .claude/rules/:**

```
.claude/rules/
├── code-style.md         # 500 tokens
├── api-patterns.md       # 400 tokens
├── testing.md            # 300 tokens
└── security.md           # 600 tokens
```

**With path filtering:**
```markdown
---
# .claude/rules/react-patterns.md
paths: src/**/*.{tsx,jsx}
---

# React Component Guidelines
[Only loaded for React files]
```

### Technique 4: Smart Subagent Usage

**Use Explore subagent (Haiku model) for searches:**

```
> Use Explore subagent to find all database queries

# Subagent runs on cheaper Haiku model
# Returns only summary to main conversation
# Saves tokens + money
```

### Technique 5: Streaming vs Full Response

```bash
# For long outputs, stream to save memory
claude -p "Generate API docs" --output-format stream-json

# Process as it arrives instead of loading all in memory
```

---

## Token Optimization Checklist

Before each session:
- [ ] Do I need everything in CLAUDE.md? Can I split it?
- [ ] Can I use Haiku model for this task?
- [ ] Is print mode better than interactive?

During session:
- [ ] Am I loading files unnecessarily?
- [ ] Can I search instead of read?
- [ ] Should I compact before continuing?
- [ ] Am I asking batch questions?
- [ ] Am I reusing loaded context?

After session:
- [ ] Check /cost
- [ ] Was I efficient?
- [ ] Can I improve for next time?

---

## Real-World Examples

### Example 1: Efficient Bug Fix

❌ **Wasteful (Est. 15K tokens):**
```
> Read all files in @src/
> Now find the bug
> Try changing file1.ts
> That didn't work, try file2.ts
> Still not working, read logs.txt (10K lines)
```

✅ **Efficient (Est. 3K tokens):**
```
> ! npm test 2>&1 | grep -A 10 "FAIL"
> The error mentions "user.email undefined" in auth.ts
> Read @src/auth.ts and find the bug
> # Claude finds and fixes
> ! npm test
```

**Savings: 80% fewer tokens**

### Example 2: Feature Implementation

❌ **Wasteful (Est. 40K tokens):**
```
> Read entire codebase
> Explain everything
> Now add feature X
> (Reads codebase again in follow-ups)
```

✅ **Efficient (Est. 8K tokens):**
```
> I need to add feature X
> It should work like existing feature Y in @src/features/Y/
> 
> Review @src/features/Y/index.ts to understand the pattern
> 
> Now create @src/features/X/ following the same structure
```

**Savings: 80% fewer tokens**

---

## Measuring Success

### Good Token Efficiency:

✅ Context stays <60% most of the time
✅ Daily costs <$6 for active development
✅ Monthly costs $100-150/developer
✅ Can work full day without compacting
✅ Rarely hit context limits

### Poor Token Efficiency:

❌ Context constantly >80%
❌ Daily costs >$12 regularly
❌ Monthly costs >$300/developer
❌ Need to compact every 30 minutes
❌ Frequently hit context limits

---

## Quick Reference

### Commands

```
/context      # Check token usage
/cost         # Check accumulated cost
/compact      # Compress history
/clear        # Reset context
```

### Strategies

```
1. Search before reading
2. Load files progressively
3. Use Haiku for simple tasks
4. Compact between features
5. Clear between projects
6. Use print mode for one-shots
7. Batch related questions
8. Reuse loaded context
9. Summarize large files
10. Use subagents wisely
```

---

## Next Steps

- **Context Efficiency** → [context-efficiency.md](context-efficiency.md)
- **Folder Structure** → [folder-structure-best-practices.md](folder-structure-best-practices.md)
- **CLAUDE.md Guide** → [claude-md-guide.md](claude-md-guide.md)

---

**Optimize your tokens, optimize your costs!** 💰
