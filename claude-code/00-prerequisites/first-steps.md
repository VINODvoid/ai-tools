# First Steps with Claude Code

**Your first Claude Code session - hands-on introduction**

---

## Table of Contents

- [Your First Interactive Session](#your-first-interactive-session)
- [Understanding the REPL](#understanding-the-repl)
- [Basic Interactions](#basic-interactions)
- [File Operations Intro](#file-operations-intro)
- [Using Print Mode](#using-print-mode)
- [Common Beginner Mistakes](#common-beginner-mistakes)
- [Quick Wins](#quick-wins)
- [What's Next](#whats-next)

---

## Your First Interactive Session

### Starting Claude Code

```bash
# Navigate to a test directory
cd ~/Documents
mkdir claude-test
cd claude-test

# Start Claude Code
claude
```

**What you'll see:**
```
Claude Code v0.1.0
Type /help for available commands
Press Tab to toggle extended thinking

>
```

The `>` prompt means Claude is ready for your input.

### Your First Prompt

Try this simple interaction:

```
> Hello! Can you help me understand what you can do?
```

**Claude will respond** with an introduction to its capabilities.

### Exit Claude

Multiple ways to exit:

```
Ctrl+C          # Quick exit
Ctrl+D          # EOF exit (Unix standard)
/exit           # Slash command
```

---

## Understanding the REPL

### REPL = Read-Eval-Print Loop

**How it works:**

1. **Read**: You type a prompt
2. **Eval**: Claude processes it
3. **Print**: Claude responds
4. **Loop**: Ready for next prompt

### REPL Features

**Multi-line Input:**
```
> Can you explain:
> 1. What is React?
> 2. How does it work?
> 3. When should I use it?
```

Press `Enter` to submit. Claude understands multi-line prompts naturally.

**Command History:**
- `Up Arrow`: Previous prompts
- `Down Arrow`: Next prompts
- `Ctrl+R`: Search history

**Inline Editing:**
- `Ctrl+A`: Start of line
- `Ctrl+E`: End of line
- `Ctrl+U`: Clear line
- `Ctrl+W`: Delete word
- `Ctrl+K`: Delete to end

### Interactive vs Print Mode

**Interactive Mode** (REPL):
```bash
claude              # Start interactive session
> Your prompts here
```

**Print Mode** (one-shot):
```bash
claude -p "What is 2+2?"
# Outputs: 4
# Returns to shell
```

---

## Basic Interactions

### Exercise 1: Simple Questions

```bash
claude
```

Try these prompts:

```
> What programming languages do you support?

> Explain async/await in JavaScript in simple terms

> What's the difference between var, let, and const?
```

### Exercise 2: Code Explanations

Create a test file:

```bash
cat > test.js << 'EOF'
function fibonacci(n) {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}
console.log(fibonacci(10));
EOF
```

Ask Claude about it:

```
> Explain the code in test.js

> What's the time complexity of the fibonacci function?

> Can you optimize this fibonacci implementation?
```

### Exercise 3: Code Generation

```
> Create a function that reverses a string

> Write a Python function to check if a number is prime

> Generate a React component for a todo list item
```

### Exercise 4: Debugging Help

Create a buggy file:

```bash
cat > buggy.js << 'EOF'
function divide(a, b) {
    return a / b;
}
console.log(divide(10, 0));
EOF
```

Ask Claude:

```
> What's wrong with buggy.js?

> How can I handle division by zero properly?

> Add error handling to the divide function
```

---

## File Operations Intro

### Reading Files

**Method 1: @ Mention**
```
> Explain @test.js

> What does @buggy.js do?
```

**Method 2: Direct Reference**
```
> Read test.js and explain it

> Analyze the code in buggy.js
```

**Method 3: Directory**
```
> What files are in @./

> Show me the structure of this directory
```

### Editing Files

```
> Fix the bug in buggy.js

> Add comments to test.js explaining each line

> Refactor test.js to use iteration instead of recursion
```

Claude will:
1. Read the file
2. Propose changes
3. Ask for approval
4. Apply edits

### Creating Files

```
> Create a file called hello.py that prints "Hello, World!"

> Generate package.json for a Node.js project

> Create a README.md for this project
```

### Working with Multiple Files

```
> Compare test.js and buggy.js

> Refactor both test.js and buggy.js to follow best practices
```

---

## Using Print Mode

### Simple Queries

```bash
# Quick answer
claude -p "What is the capital of France?"

# Code explanation
claude -p "Explain this: const x = [1,2,3].map(n => n * 2)"

# Math
claude -p "Calculate 15% tip on $45.67"
```

### Pipe Input to Claude

```bash
# Analyze logs
cat error.log | claude -p "Summarize these errors"

# Explain command output
ls -la | claude -p "Explain this output"

# Code review
git diff | claude -p "Review these changes"
```

### Output to Files

```bash
# Generate and save
claude -p "Create a Python script to fetch weather data" > weather.py

# Explain and save
claude -p "Explain REST API" > rest-api-notes.txt
```

### Scripting with Claude

```bash
#!/bin/bash
# analyze-logs.sh

# Get errors from last hour
journalctl --since "1 hour ago" > /tmp/logs.txt

# Ask Claude to analyze
claude -p "Analyze these logs and find critical errors" < /tmp/logs.txt
```

---

## Common Beginner Mistakes

### Mistake 1: Not Reading Files First

**Wrong:**
```
> Fix the bug in app.js
# Claude: "I don't have access to app.js content"
```

**Right:**
```
> Read @app.js and fix any bugs you find
# OR
> Explain @app.js
> # Then in next prompt: Fix the bug we just discussed
```

### Mistake 2: Vague Requests

**Vague:**
```
> Make it better
> Fix this
> Improve the code
```

**Specific:**
```
> Refactor this function to reduce time complexity
> Fix the null pointer exception in line 45
> Add error handling and input validation
```

### Mistake 3: Not Using Context

**Without Context:**
```
> Add authentication
# Claude needs more info
```

**With Context:**
```
> I'm building a Node.js REST API with Express. Add JWT-based authentication to @app.js
```

### Mistake 4: Ignoring File References

**Manual:**
```
> Here's my code: [paste 200 lines]
```

**Better:**
```
> Review the code in @src/index.js
```

### Mistake 5: Not Using Slash Commands

**Manual:**
```
> Show me help
> Clear the conversation
> What's my token usage?
```

**Built-in Commands:**
```
/help
/clear
/context
```

---

## Quick Wins

### Win 1: Instant Documentation

```bash
# Generate README
claude
> Create a comprehensive README.md for this project based on the code structure
```

### Win 2: Code Explanation

```bash
# Understand unfamiliar code
> Explain @src/utils/crypto.js in simple terms
> What does each function do?
> Are there any security concerns?
```

### Win 3: Test Generation

```bash
> Generate unit tests for @src/calculator.js
> Use Jest framework
> Cover edge cases
```

### Win 4: Refactoring

```bash
> Refactor @legacy-code.js to modern ES6+ syntax
> Convert callbacks to async/await
> Add TypeScript types
```

### Win 5: Git Commit Messages

```bash
# In your project with changes
claude
> Review my git changes and suggest a commit message

# Or in print mode
git diff | claude -p "Generate a conventional commit message for these changes"
```

### Win 6: Quick Scripts

```bash
claude -p "Create a bash script to backup my ~/Documents to ~/Backups with timestamp"
```

### Win 7: Learning New Concepts

```
> I'm new to Docker. Explain it like I'm familiar with VMs

> What's the difference between REST and GraphQL?

> Teach me React hooks with examples
```

---

## Your First Real Task

### Complete Workflow Example

Let's build a simple todo CLI app:

```bash
# Create project
mkdir todo-cli
cd todo-cli

# Start Claude
claude
```

**Session:**

```
> I want to create a simple command-line todo app in Node.js
> Features:
> - Add todos
> - List todos
> - Mark as complete
> - Delete todos
> - Store in JSON file
>
> Let's start by creating the project structure
```

Claude will:
1. Create `package.json`
2. Generate `todo.js` with full implementation
3. Add `README.md` with usage instructions
4. Create `.gitignore`

**Then continue:**

```
> Add colorful output using chalk library

> Add ability to filter by complete/incomplete

> Create unit tests for all functions
```

**Finally:**

```
> Review all the code for best practices

> Create a git commit for this initial version
```

---

## Practice Exercises

### Exercise Set 1: Basics (15 minutes)

1. **Start Claude and ask**:
   ```
   > What can you help me with?
   ```

2. **Create a simple program**:
   ```
   > Create a Python script that prints Fibonacci numbers up to 100
   ```

3. **Explain code**:
   ```
   > Explain @fibonacci.py line by line
   ```

4. **Optimize**:
   ```
   > Optimize fibonacci.py for better performance
   ```

5. **Test it**:
   ```bash
   python fibonacci.py
   ```

### Exercise Set 2: File Operations (15 minutes)

1. **Create project structure**:
   ```
   > Create a basic Express.js project structure with:
   > - src/app.js (main server)
   > - src/routes/users.js
   > - src/middleware/auth.js
   > - package.json
   > - README.md
   ```

2. **Explore**:
   ```
   > Show me what's in each file
   ```

3. **Enhance**:
   ```
   > Add error handling middleware to app.js
   > Add input validation to users.js
   ```

### Exercise Set 3: Real Workflow (20 minutes)

Create a REST API with full CRUD:

```
> Let's create a RESTful API for managing books
> Technology: Node.js + Express + PostgreSQL
>
> Structure:
> - Database schema
> - API routes (GET, POST, PUT, DELETE)
> - Error handling
> - Input validation
>
> Create all necessary files
```

Then:
```
> Add comprehensive documentation

> Generate Postman collection JSON

> Create Docker setup for the database

> Add unit tests

> Review security best practices
```

---

## Understanding Claude's Responses

### Types of Responses

**1. Explanatory:**
```
> What is async/await?

Claude explains concepts clearly with examples
```

**2. Code Generation:**
```
> Create a React component

Claude generates complete, working code
```

**3. Code Analysis:**
```
> Review @app.js

Claude analyzes and provides feedback
```

**4. Interactive Problem Solving:**
```
> How do I optimize this database query?

Claude asks clarifying questions, then provides solutions
```

### Response Quality Indicators

**Good Response:**
- Specific and actionable
- Includes code examples
- Explains reasoning
- Considers edge cases
- Follows best practices

**Needs Improvement:**
If response is vague, ask follow-up:
```
> Can you be more specific?
> Show me a code example
> What are the trade-offs?
```

---

## Keyboard Shortcuts Reference

| Shortcut | Action |
|----------|--------|
| `Enter` | Submit prompt |
| `Tab` | Toggle extended thinking |
| `Ctrl+C` | Exit Claude |
| `Ctrl+D` | Exit Claude (EOF) |
| `Ctrl+L` | Clear screen (keep history) |
| `Up Arrow` | Previous command |
| `Down Arrow` | Next command |
| `Ctrl+R` | Search history |
| `Ctrl+A` | Start of line |
| `Ctrl+E` | End of line |
| `Ctrl+U` | Clear line |
| `Ctrl+W` | Delete word |
| `Ctrl+K` | Delete to end |
| `!` + command | Run bash command |
| `@` + path | Reference file/directory |

---

## Essential Slash Commands

Try these built-in commands:

```bash
/help          # Show all commands
/clear         # Clear conversation (fresh start)
/context       # Show token usage
/cost          # Show session cost
/memory        # Edit memory files
/agents        # Manage subagents
/init          # Initialize CLAUDE.md
/todos         # List TODO items
```

---

## Tips for Effective Communication

### 1. Be Specific

**Instead of:**
```
> Make a website
```

**Try:**
```
> Create an HTML page with:
> - Header with navigation
> - Hero section with image
> - Features grid (3 columns)
> - Contact form
> - Responsive design
```

### 2. Provide Context

**Include:**
- Technology stack
- Project structure
- Existing code patterns
- Constraints or requirements

**Example:**
```
> I'm building a Next.js 14 app with TypeScript
> Using App Router and Server Components
> Create a dynamic blog post page at /blog/[slug]
```

### 3. Iterate

**First prompt:**
```
> Create a user authentication system
```

**Refine:**
```
> Add password reset functionality
> Include email verification
> Add rate limiting
> Use bcrypt for hashing
```

### 4. Use Examples

```
> Create an API endpoint similar to @existing-endpoint.js
> But for managing products instead of users
> Follow the same patterns
```

---

## What You've Learned

After completing these first steps, you can:

- ✅ Start and exit Claude Code
- ✅ Use interactive REPL mode
- ✅ Use print mode for quick queries
- ✅ Reference files with @
- ✅ Ask Claude to create, read, and edit files
- ✅ Use basic slash commands
- ✅ Navigate command history
- ✅ Pipe input/output
- ✅ Communicate effectively with Claude

---

## What's Next

### Immediate Next Steps

1. **Learn Basic Commands**
   → [../01-fundamentals/basic-commands.md](../01-fundamentals/basic-commands.md)

2. **Master File Operations**
   → [../01-fundamentals/file-operations.md](../01-fundamentals/file-operations.md)

3. **Understand Conversation Patterns**
   → [../01-fundamentals/conversation-patterns.md](../01-fundamentals/conversation-patterns.md)

### Start a Real Project

```bash
# Create your first real project
mkdir my-first-claude-project
cd my-first-claude-project

# Initialize
git init
claude
> /init
> Let's build [your project idea]
```

---

## Quick Reference Card

**Starting:**
```bash
claude              # Interactive
claude -p "query"   # One-shot
claude -c           # Continue last
```

**In Session:**
```
/help               # Help
/clear              # Fresh start
/context            # Token usage
@file.js            # Reference file
! git status        # Run bash
```

**Exit:**
```
Ctrl+C              # Quick exit
Ctrl+D              # EOF exit
```

---

**Congratulations!** 🎉

You've completed your first steps with Claude Code. You're ready to dive deeper into the fundamentals.

Continue to → [../01-fundamentals/basic-commands.md](../01-fundamentals/basic-commands.md)
