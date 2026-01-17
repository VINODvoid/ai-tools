# Neovim Mastery: Usage Guide

*Master Neovim for production development - focused on actual usage, not configuration*

## Overview

You have Neovim configured. Now learn to use it at expert level. This guide covers real-world workflows, advanced techniques, and production patterns used by developers who live in Neovim.

## Learning Path

### Foundation (Master These First)

1. **[Modal Editing Mastery](modal-editing.md)**
   - Motion combinations that matter
   - Composable commands
   - Thinking in text objects
   - Building muscle memory efficiently

2. **[Navigation](navigation.md)**
   - Buffer/window/tab management
   - File jumping and marks
   - LSP-powered navigation
   - Project-wide movement

### Core Skills (Your Daily Workflow)

3. **[Text Manipulation](text-manipulation.md)**
   - Operators and text objects
   - Visual mode patterns
   - Indentation and formatting
   - Multi-line editing

4. **[Search and Replace](search-and-replace.md)**
   - Pattern matching with `/` and `?`
   - Substitute commands (`:%s`)
   - Global commands (`:g`)
   - Project-wide search (with plugins)

5. **[Workflow](workflow.md)**
   - Real coding scenarios
   - Refactoring patterns
   - Debugging in Neovim
   - Git integration usage

### Advanced (Power User Territory)

6. **[LSP Usage](lsp-usage.md)**
   - Go-to definition workflows
   - Code actions and refactoring
   - Diagnostics navigation
   - Hover and documentation

7. **[Advanced Techniques](advanced-techniques.md)**
   - Macros for repetitive tasks
   - Registers and clipboard
   - Marks and jumplist
   - Expression register tricks

### Reference

8. **[Mistakes to Avoid](mistakes-to-avoid.md)**
   - Common antipatterns
   - Inefficient habits
   - Performance killers
   - Muscle memory traps

9. **[Cheatsheet](cheatsheet.md)**
   - Essential motions
   - Command combinations
   - Production shortcuts
   - Scenario-based quick reference

## How to Use This Guide

### If you're transitioning from VSCode/IntelliJ:
1. Start with [Workflow](workflow.md) - see how common tasks translate
2. Read [Modal Editing Mastery](modal-editing.md) - understand the paradigm shift
3. Practice with [Cheatsheet](cheatsheet.md) open
4. Review [Mistakes to Avoid](mistakes-to-avoid.md) weekly

### If you know basic Vim:
1. Jump to [Advanced Techniques](advanced-techniques.md)
2. Read [LSP Usage](lsp-usage.md) - this is what makes Neovim modern
3. Study [Text Manipulation](text-manipulation.md) for gaps in knowledge
4. Use [Cheatsheet](cheatsheet.md) for reference

### For maximum efficiency:
1. Learn one technique per day from any section
2. Force yourself to use it for all work that day
3. Keep [Cheatsheet](cheatsheet.md) visible
4. Review [Mistakes to Avoid](mistakes-to-avoid.md) when you feel slow

## Core Philosophy

**Neovim is about composition, not memorization.**

You don't memorize 1000 commands. You learn:
- 10 motions (`w`, `b`, `e`, `{`, `}`, `f`, `t`, `/`, `n`, `%`)
- 10 operators (`d`, `c`, `y`, `v`, `>`, `<`, `=`, `g~`, `gu`, `gU`)
- 10 text objects (`iw`, `aw`, `i"`, `a"`, `i(`, `a(`, `it`, `at`, `ip`, `ap`)

Then combine them: `d2w`, `ci"`, `>ip`, `gUaw`, etc.

This gives you 10 × 10 × 10 = **1000 combinations** from 30 concepts.

## The Neovim Mindset

### Think in Operations
- Not: "move right 5 times and delete"
- Think: "delete to end of word" → `dw`

### Think in Text Objects
- Not: "select these characters"
- Think: "change inside quotes" → `ci"`

### Think in Repetition
- Not: "do this 10 times manually"
- Think: "record macro, replay" → `qq...q`, then `10@q`

## Essential `:help` Topics

Neovim's built-in help is comprehensive. Master these:

```vim
:help motion.txt          " All motions explained
:help operator.txt        " All operators explained
:help text-objects        " Text objects in detail
:help pattern             " Regex patterns
:help registers           " Named registers
:help marks               " Mark system
:help quickfix            " Quickfix list
:help lsp                 " LSP integration
```

## Practice Regimen

### Week 1: Motions Only
- Disable arrow keys: `noremap <Up> <Nop>`
- Use only `hjkl`, `w`, `b`, `e`, `{`, `}`, `f`, `t`
- Goal: Never hold `j` or `l` - always use precise motions

### Week 2: Operators
- Delete, change, yank with motions: `dw`, `caw`, `yip`
- Goal: Stop using visual mode for simple edits

### Week 3: Text Objects
- Force yourself to use `iw`, `i"`, `i(`, `it` for everything
- Goal: Change entire logical units, not character-by-character

### Week 4: Combination
- Chain complex commands: `dt,`, `ci{`, `>a}`
- Goal: Complete edits in single commands

### Week 5+: Advanced
- Macros for repetitive refactoring
- Regex search and replace
- LSP workflow mastery

## Measuring Progress

You're getting good when:
- You think "delete to next comma" not "move and delete"
- Your fingers execute before your brain finishes thinking
- You use visual mode rarely (only for irregular selections)
- You fix typos without leaving insert mode (`:help i_CTRL-W`)
- You prefer Neovim for quick file edits over `nano` or `sed`

You've mastered it when:
- You feel slow in other editors
- You subvocalize motions while reading code
- You contribute Neovim patterns to this guide

## Quick Wins (Learn These Today)

```vim
ciw     " Change inner word - fastest way to replace a word
dap     " Delete around paragraph - remove whole block
vi{     " Select inside braces - select function body
`.      " Jump to last change - return to where you edited
gd      " Go to definition (with LSP)
<C-o>   " Jump back - like browser back button
<C-i>   " Jump forward - like browser forward button
zz      " Center screen on cursor - improve focus
*       " Search for word under cursor
<C-a>   " Increment number - change 1 to 2
<C-x>   " Decrement number - change 2 to 1
```

## Real Talk

**Neovim has a learning curve.** You'll be slower for 2-4 weeks. Then you'll be faster than you've ever been. The investment pays off for decades.

Use Neovim for all work from day one. No switching back and forth. Struggle is how you learn.

---

**Next**: Start with [Modal Editing Mastery](modal-editing.md) or jump to [Cheatsheet](cheatsheet.md) if you prefer learning by doing.
