# Learn Neovim: From Zero to Hero

*A structured, beginner-friendly guide to mastering Neovim step-by-step*

## Welcome! 👋

This guide will teach you Neovim from the ground up. No prior Vim/Neovim experience needed. You'll learn through:

- **Clear explanations** - Concepts explained simply
- **Visual diagrams** - See what's happening
- **Practice exercises** - Build muscle memory
- **Progressive difficulty** - Start easy, build up gradually
- **Real examples** - Practice on actual code

**Time commitment:** 2-4 weeks to become proficient (30 min/day)

---

## How to Use This Guide

### Learning Path (Recommended Order)

**Week 1: Fundamentals** ⭐ START HERE
1. [Getting Started](01-getting-started.md) - Install, configure, first steps (Day 1-2)
2. [Basic Motions](02-basic-motions.md) - Moving around efficiently (Day 3-4)
3. [Editing Basics](03-editing-basics.md) - Making changes to text (Day 5-7)
4. [Your Keybindings](your-keybindings.md) - Reference for YOUR setup

**Week 2: Building Skills**
5. [Intermediate Skills](04-intermediate-skills.md) - Text objects, operators, combinations
6. [Navigation](navigation.md) - Files, buffers, windows, tabs
7. [Search & Replace](search-and-replace.md) - Finding and changing text

**Week 3: Real Workflows**
8. [Workflow](workflow.md) - Coding in Neovim (the real stuff)
9. [LSP Usage](lsp-usage.md) - IDE-like features (autocomplete, go-to-definition)
10. [Text Manipulation](text-manipulation.md) - Advanced editing patterns

**Week 4: Master Level**
11. [Advanced Techniques](advanced-techniques.md) - Macros, registers, power moves
12. [Mistakes to Avoid](mistakes-to-avoid.md) - Common pitfalls
13. [Cheatsheet](cheatsheet.md) - Quick reference

### Practice Materials

- **[Learning Path Guide](learning-path.md)** - Week-by-week study plan
- **[Practice Exercises](practice-exercises.md)** - Hands-on drills with solutions
- **[Cheatsheet](cheatsheet.md)** - Keep this open while coding

---

## The Neovim Learning Method

### 1. Learn One Concept at a Time

Don't try to memorize everything. Learn 3-5 commands, use them for a full day, then add more.

```
Day 1:  Learn hjkl, i, <Esc>, :w, :q
Day 2:  Add w, b, e (word motions)
Day 3:  Add dw, dd, yy, p (delete, copy, paste)
...and so on
```

### 2. Practice with Real Code

Don't just read. Open real files and practice:

```bash
# Practice on actual code
nvim ~/your-project/src/main.js

# Or create a practice file
echo "practice neovim here" > practice.txt
nvim practice.txt
```

### 3. Use Visual Guides

Each section includes visual diagrams showing cursor movement:

```
Before:  The |quick brown fox
Motion:  w (move forward one word)
After:   The quick |brown fox
```

### 4. Build Muscle Memory

Repeat exercises until your fingers move automatically. We've included drills for this.

### 5. Track Progress

Check off skills as you learn them. There's a progress tracker in the learning path.

---

## Quick Start (5 Minutes)

### Right Now: Open Neovim

```bash
nvim practice.txt
```

You'll see Neovim's welcome screen.

### Your First Commands

1. **Enter insert mode** - Press `i`
   - Now you can type normally
   - Type: "Hello, Neovim!"

2. **Exit insert mode** - Press `<Esc>` (or `jk` in your config)
   - You're back in "normal mode"

3. **Save the file** - Type `:w` and press `<Enter>`
   - The file is saved

4. **Quit Neovim** - Type `:q` and press `<Enter>`
   - You're back to the terminal

### You Just Learned:

- `i` - Enter insert mode (type text)
- `<Esc>` - Return to normal mode
- `:w` - Write (save) file
- `:q` - Quit Neovim

**That's the foundation!** Everything builds from here.

---

## Understanding Neovim's Modes

Neovim has different "modes" for different tasks. Think of them like gears in a car.

### Visual Representation

```
┌─────────────────────────────────────────┐
│                                         │
│         NORMAL MODE (Default)           │
│     Navigate and execute commands       │
│                                         │
└─────────────────────────────────────────┘
         │              ▲
         │ i,a,o,O      │ <Esc>
         ▼              │
┌─────────────────────────────────────────┐
│                                         │
│         INSERT MODE                     │
│        Type text normally               │
│                                         │
└─────────────────────────────────────────┘
```

**Think of it this way:**
- **Normal mode** = Command mode (give orders)
- **Insert mode** = Typing mode (write text)

Most editors are always in "insert mode". Neovim is different - you spend most time in "normal mode" giving commands.

---

## The Big Picture: Why Learn Neovim?

### Speed Comparison

**Traditional Editor:**
```
1. Move mouse to line 47
2. Click to position cursor
3. Click and drag to select text
4. Press Delete
5. Type replacement
```

**Neovim (once you learn):**
```
:47<Enter>  (jump to line)
ciw         (change word)
→ type replacement
```

### The Learning Curve (Be Honest)

```
Productivity
    ▲
    │     ┌─────────────  (Neovim Master)
    │    ╱
    │   ╱
    ├──╯ ← "The Valley" (2-3 weeks)
    │
    │ ← Your current editor
    │
    └─────────────────────────────▶ Time
      Start     2 weeks    4 weeks
```

**Reality check:**
- Week 1-2: You'll be SLOWER than your current editor
- Week 3: You'll match your current speed
- Week 4+: You'll be FASTER than ever before

**Is it worth it?** If you code for years to come, absolutely.

---

## How This Guide is Different

### ❌ What This Guide is NOT:

- Not a reference manual (use `:help` for that)
- Not a complete list of every command
- Not for people who want to stay in VSCode

### ✅ What This Guide IS:

- A learning path from beginner to proficient
- Focused on what you'll actually use
- Includes practice exercises
- Tailored to YOUR config at `~/.config/nvim/`
- Designed to build muscle memory

---

## Prerequisites

### What You Need:

1. ✅ Neovim installed (you have this)
2. ✅ Your config at `~/.config/nvim/` (you have this)
3. ✅ 30 minutes per day
4. ✅ Willingness to be slow at first

### What You DON'T Need:

- ❌ Vim experience
- ❌ Command line expertise
- ❌ Perfect memory

---

## Learning Philosophy

### The Three Principles

**1. Composability Over Memorization**

You don't memorize 1000 commands. You learn:
- 10 motions (`w`, `b`, `{`, `}`, etc.)
- 10 operators (`d`, `c`, `y`, etc.)
- 10 text objects (`iw`, `i"`, `i(`, etc.)

Then combine: `d` + `w` = delete word, `c` + `i"` = change inside quotes.

That's 10 × 10 × 10 = **1000 combinations from 30 concepts**.

**2. Practice Beats Reading**

Reading this guide won't make you fast. Practicing will.

**3. Muscle Memory is the Goal**

Eventually your fingers should move before your brain finishes thinking. That only comes from repetition.

---

## Your Learning Checklist

Track your progress:

### Week 1: Fundamentals
- [ ] Complete [Getting Started](01-getting-started.md)
- [ ] Complete [Basic Motions](02-basic-motions.md)
- [ ] Complete [Editing Basics](03-editing-basics.md)
- [ ] Practice 30 minutes daily
- [ ] Can edit files without mouse

### Week 2: Building Skills
- [ ] Complete [Intermediate Skills](04-intermediate-skills.md)
- [ ] Complete [Navigation](navigation.md)
- [ ] Complete [Search & Replace](search-and-replace.md)
- [ ] Use Neovim for all coding
- [ ] Can navigate projects efficiently

### Week 3: Real Workflows
- [ ] Complete [Workflow](workflow.md)
- [ ] Complete [LSP Usage](lsp-usage.md)
- [ ] Complete [Text Manipulation](text-manipulation.md)
- [ ] Comfortable with daily development
- [ ] Faster than your old editor

### Week 4: Mastery
- [ ] Complete [Advanced Techniques](advanced-techniques.md)
- [ ] Review [Mistakes to Avoid](mistakes-to-avoid.md)
- [ ] Memorized [Cheatsheet](cheatsheet.md)
- [ ] Teaching others
- [ ] Neovim feels natural

---

## Daily Practice Routine

### Morning (5 min):
```bash
nvim practice-exercises.md
# Do one drill
```

### During Work (all day):
```bash
# Use Neovim for everything
# Keep cheatsheet.md open in split
```

### Evening (10 min):
```bash
# Review what you learned
# Read next section in guide
```

---

## When You Get Stuck

### "I can't remember the commands!"

**Normal.** Keep the [Cheatsheet](cheatsheet.md) open. Check it 100 times a day. Eventually you won't need it.

### "This is too slow!"

**Normal.** You're learning. Week 1-2 are the hardest. Push through.

### "I want to give up and use VSCode"

**Normal.** But if you quit, you'll never get fast. Give it 2 weeks minimum.

### "I don't understand what X means"

- Check the glossary in [Getting Started](01-getting-started.md)
- Use Neovim's help: `:help <topic>`
- Reread the section slowly

---

## Getting Help

### Built-in Help (Best Resource)

```vim
:help                  " General help
:help w                " Help on 'w' motion
:help :substitute      " Help on substitute command
:help modes            " Help on modes
```

Press `<Space>fh` (in your config) to search help with Telescope.

### This Guide's Structure

```
README.md (YOU ARE HERE)
    │
    ├── 01-getting-started.md      ← Start here
    ├── 02-basic-motions.md        ← Learn movement
    ├── 03-editing-basics.md       ← Learn editing
    ├── 04-intermediate-skills.md  ← Combine skills
    ├── 05-advanced-workflows.md   ← Real coding
    │
    ├── practice-exercises.md      ← Practice here daily
    ├── learning-path.md           ← Week-by-week plan
    └── cheatsheet.md              ← Quick reference
```

---

## Ready to Start?

### Next Step: [Getting Started →](01-getting-started.md)

This will take you through:
- Understanding your Neovim setup
- The four modes explained simply
- Your first practice session
- Setting up your learning environment

**Estimated time:** 30 minutes

---

## Tips for Success

1. **Use Neovim exclusively** - Don't switch between editors
2. **Practice daily** - 30 min/day beats 3 hours on Sunday
3. **One concept at a time** - Don't rush
4. **Keep cheatsheet visible** - Split screen while coding
5. **Celebrate small wins** - First time `ciw` works? Celebrate!
6. **Join the community** - r/neovim, Neovim Discord
7. **Be patient** - Mastery takes time

---

## What You'll Achieve

After completing this guide, you will:

✅ Navigate code without touching the mouse
✅ Edit text faster than ever before
✅ Use LSP for IDE-like features
✅ Refactor code with confidence
✅ Work efficiently on remote servers
✅ Customize Neovim to your needs
✅ Think in motions and text objects
✅ Never want to use another editor

---

## Let's Begin!

**[Start with Getting Started →](01-getting-started.md)**

Remember: Every expert was once a beginner. The difference is they didn't quit during week 1.

You've got this! 💪
