# Neovim Learning Path: 4-Week Structured Plan

*A day-by-day guide to mastering Neovim in 4 weeks*

## Overview

This plan assumes **30 minutes of focused practice per day**. Follow this schedule and you'll be proficient in Neovim within a month.

**Key Principles:**
1. **Practice daily** - 30 min/day beats 3 hours once a week
2. **Use it for real work** - Apply what you learn immediately
3. **Don't skip ahead** - Each day builds on the previous
4. **Review regularly** - Repetition creates muscle memory

---

## Week 1: Fundamentals

**Goal:** Master the basics - modes, movement, basic editing

### Day 1: Setup & Modes

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Getting Started](01-getting-started.md) - Sections: "Opening Neovim" through "Understanding Modes"
2. Complete Practice Session 1 from Getting Started

**Afternoon (15 min):**
3. Complete Practice Session 2 from Getting Started
4. Do [Exercise 1.1-1.3](practice-exercises.md#day-1-modes-and-insert) from Practice Exercises

**Homework:**
- Open and close Neovim 10 times before bed
- Practice `jk` to exit insert mode until automatic

**Success Criteria:**
- [ ] Can open Neovim
- [ ] Can enter insert mode (`i`, `a`, `o`, `O`)
- [ ] Can exit insert mode with `jk` automatically
- [ ] Can save (`:w`) and quit (`:q`)

---

### Day 2: Basic Movement `hjkl`

**Time:** 30 minutes

**Morning (20 min):**
1. Read [Basic Motions](02-basic-motions.md) - "The `hjkl` Foundation" section
2. Complete Practice Exercise 1.1 from Basic Motions
3. Do [Exercise 2.1-2.3](practice-exercises.md#day-2-basic-motions-hjkl) from Practice Exercises

**Afternoon (10 min):**
4. Open a real code file
5. Navigate using only `hjkl` for 10 minutes
6. **Disable arrow keys** if you keep reaching for them

**Homework:**
- Edit a real file using only `hjkl` for movement
- No arrow keys allowed!

**Success Criteria:**
- [ ] Can navigate with `hjkl` without looking at keyboard
- [ ] Fingers automatically use `hjkl` instead of arrows
- [ ] Comfortable moving around small files

---

### Day 3: Word Motions

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Basic Motions](02-basic-motions.md) - "Word Motions" section
2. Complete Practice Exercise 1.2 from Basic Motions
3. Do [Exercise 3.1-3.2](practice-exercises.md#day-3-word-motions) from Practice Exercises

**Afternoon (15 min):**
4. Open a code file
5. Practice navigating functions using `w`, `b`, `e`
6. Try adding counts: `3w`, `5b`

**Homework:**
- Use `w` and `b` for ALL navigation tomorrow
- Avoid `hjkl` when possible

**Success Criteria:**
- [ ] Can jump words with `w`, `b`, `e` automatically
- [ ] Can use counts (`3w`, `5b`)
- [ ] Faster than using `l` repeatedly

---

### Day 4: Line & Find Motions

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Basic Motions](02-basic-motions.md) - "Line Motions" and "Search Within Line"
2. Complete Practice Exercises 1.3 and 1.6 from Basic Motions
3. Do [Exercise 4.1-4.3](practice-exercises.md#day-4-find-and-till) from Practice Exercises

**Afternoon (15 min):**
4. Open code with lots of parentheses/quotes
5. Practice `f{char}` to jump to characters
6. Use `0`, `^`, `$` to jump to line starts/ends

**Homework:**
- Use `f` instead of `w` when looking for specific characters
- Use `^` and `$` instead of holding `h` or `l`

**Success Criteria:**
- [ ] Can jump to line start/end with `0`, `^`, `$`
- [ ] Can find characters with `f{char}`
- [ ] Can repeat finds with `;` and `,`

---

### Day 5: Delete Operations

**Time:** 30 minutes

**Morning (15 min):**
1. Read about Delete in documentation
2. Do [Exercise 8.1-8.2](practice-exercises.md#day-8-delete-operations) from Practice Exercises

**Commands to learn:**
```
dw    - delete word
dd    - delete line
d$    - delete to end of line
dt{char} - delete till character
```

**Afternoon (15 min):**
3. Open a code file
4. Practice deleting:
   - Words with `dw`
   - Lines with `dd`
   - To end of line with `d$`
   - Till characters with `dt{char}`

**Homework:**
- Delete 20 different things using `dw`, `dd`, `d$`
- Use `u` to undo if you delete wrong thing

**Success Criteria:**
- [ ] Can delete words with `dw`
- [ ] Can delete lines with `dd`
- [ ] Can delete to specific characters with `dt`
- [ ] Know how to undo with `u`

---

### Day 6: Change Operations

**Time:** 30 minutes

**Morning (15 min):**
1. Do [Exercise 9.1-9.2](practice-exercises.md#day-9-change-operations) from Practice Exercises

**Commands to learn:**
```
cw    - change word
ciw   - change inner word (better!)
ci"   - change inside quotes
ci(   - change inside parentheses
```

**Afternoon (15 min):**
2. Open a code file
3. Practice changing:
   - Variable names with `ciw`
   - Strings with `ci"`
   - Function parameters with `ciw`
   - Function arguments with `ci(`

**Homework:**
- Rename 10 variables using `ciw`
- Change 5 strings using `ci"`

**Success Criteria:**
- [ ] Can change words with `ciw`
- [ ] Can change inside quotes with `ci"`
- [ ] Understand text objects (`iw`, `i"`, `i(`)
- [ ] Prefer `ciw` over `dw` then `i`

---

### Day 7: Copy & Paste + Week Review

**Time:** 45 minutes (longer for review)

**Morning (15 min):**
1. Do [Exercise 10.1-10.4](practice-exercises.md#day-10-copy-and-paste) from Practice Exercises

**Commands to learn:**
```
yy    - yank (copy) line
yw    - yank word
p     - put (paste)
yyp   - duplicate line
```

**Afternoon (30 min):**
2. Review entire week:
   - Open a real code file
   - Navigate using all motions learned
   - Delete, change, copy, paste different things
   - Time yourself - try to beat yesterday's speed

**Weekend Homework:**
- Use Neovim exclusively for all coding
- Review [Cheatsheet](cheatsheet.md) - print it out
- Redo Day 5-7 exercises if anything felt shaky

**Week 1 Completion Criteria:**
- [ ] Navigate files without mouse
- [ ] Use `hjkl`, `w`, `b`, `e`, `f`, `t` automatically
- [ ] Can delete, change, copy, paste
- [ ] Understand text objects (`iw`, `i"`, `i(`)
- [ ] Comfortable with basic editing

---

## Week 2: Building Fluency

**Goal:** Combine skills, learn project navigation, search/replace

### Day 8: Your Keybindings & File Navigation

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Your Keybindings](your-keybindings.md) - "File Navigation (Telescope)" section
2. Learn:
   - `<Space>ff` - Find files
   - `<Space>fs` - Search in files
   - `<Space>fb` - Find buffers
   - `<Space>fr` - Recent files

**Afternoon (15 min):**
3. Practice in your real project:
   - Open Neovim: `nvim .`
   - Find files: `<Space>ff` → type partial name → `<Enter>`
   - Search content: `<Space>fs` → search term → `<Enter>`
   - Switch buffers: `<Space>fb` → select file

**Homework:**
- Use `<Space>ff` for ALL file opening (no manual `:e`)
- Use `<Space>fs` to find code instead of manual grep

**Success Criteria:**
- [ ] Can find files with `<Space>ff`
- [ ] Can search project with `<Space>fs`
- [ ] Can switch buffers with `<Space>fb`
- [ ] Never manually typing file paths

---

### Day 9: Window & Tab Management

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Your Keybindings](your-keybindings.md) - "Window Management" section
2. Learn:
   - `<Space>sv` - Split vertically
   - `<Space>sh` - Split horizontally
   - `<C-h/j/k/l>` - Navigate windows
   - `<Space>sx` - Close split

**Afternoon (15 min):**
3. Practice:
   - Open file: `<Space>ff`
   - Split: `<Space>sv`
   - Open another file: `<Space>ff`
   - Navigate: `<C-h>`, `<C-l>`
   - Close split: `<Space>sx`

**Homework:**
- Work with at least 2 splits open all day
- Practice `<C-h/j/k/l>` until automatic

**Success Criteria:**
- [ ] Can split windows
- [ ] Can navigate between windows with `<C-h/j/k/l>`
- [ ] Comfortable working in split view

---

### Day 10: LSP Basics (Go to Definition)

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Your Keybindings](your-keybindings.md) - "LSP Navigation" section
2. Learn:
   - `gd` - Go to definition
   - `<C-o>` - Jump back
   - `K` - Hover documentation
   - `gR` - Show references

**Afternoon (15 min):**
3. Open a code file with functions
4. Practice the pattern:
   - Cursor on function call
   - `gd` → see definition
   - `<C-o>` → jump back
   - Repeat 20 times

**Homework:**
- Use `gd` then `<C-o>` pattern 50 times today
- Explore codebase using LSP navigation

**Success Criteria:**
- [ ] Can jump to definitions with `gd`
- [ ] Always use `<C-o>` to jump back
- [ ] Can view docs with `K`
- [ ] Starting to feel like an IDE

---

### Day 11: LSP Code Actions & Diagnostics

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Your Keybindings](your-keybindings.md) - "LSP Code Actions" section
2. Learn:
   - `<Space>ca` - Code actions
   - `]d` / `[d` - Next/prev diagnostic
   - `<Space>d` - Show diagnostic
   - `<Space>rn` - Rename

**Afternoon (15 min):**
3. Practice:
   - Find file with errors: `]d` to jump to first
   - View error: `<Space>d`
   - Fix it: `<Space>ca` → select fix
   - Find variable: `<Space>rn` → rename it

**Homework:**
- Fix 10 errors using `]d` + `<Space>ca`
- Rename 5 things using `<Space>rn`

**Success Criteria:**
- [ ] Can navigate errors with `]d` and `[d`
- [ ] Can apply fixes with `<Space>ca`
- [ ] Can rename with `<Space>rn`
- [ ] Prefer LSP rename over find/replace

---

### Day 12: Search & Replace Basics

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Search & Replace](search-and-replace.md) - "Search Patterns" and "Substitute Command"
2. Learn:
   - `/pattern` - Search
   - `n` / `N` - Next/previous match
   - `:s/old/new/` - Replace on line
   - `:%s/old/new/g` - Replace in file
   - `:%s/old/new/gc` - Replace with confirmation

**Afternoon (15 min):**
3. Practice in a code file:
   - Search for variable: `/varName`
   - Jump through matches: `n`, `n`, `n`
   - Replace in file: `:%s/varName/newName/gc`

**Homework:**
- Use `/` for all searching (not `<Space>fs`)
- Try `:%s` for simple renames (use `<Space>rn` for code)

**Success Criteria:**
- [ ] Can search with `/`
- [ ] Can navigate matches with `n` and `N`
- [ ] Can replace with `:%s/old/new/gc`
- [ ] Understand when to use LSP rename vs `:%s`

---

### Day 13: Advanced Search & Telescope Integration

**Time:** 30 minutes

**Morning (15 min):**
1. Read [Search & Replace](search-and-replace.md) - "Multi-File Search"
2. Learn the pattern:
   - `<Space>fs` → search term
   - `<C-q>` → send to quickfix
   - `:cfdo %s/old/new/g | update` → replace across files

**Afternoon (15 min):**
3. Practice multi-file replace:
   - Search: `<Space>fs` → "oldFunction"
   - Send to quickfix: `<C-q>`
   - Replace: `:cfdo %s/oldFunction/newFunction/g | update`

**Homework:**
- Do one multi-file refactor using this pattern

**Success Criteria:**
- [ ] Can search across project with `<Space>fs`
- [ ] Can send results to quickfix with `<C-q>`
- [ ] Can replace across multiple files
- [ ] Comfortable with project-wide changes

---

### Day 14: Week Review & Speed Test

**Time:** 45 minutes

**Morning (20 min):**
1. Complete [Speed Tests](practice-exercises.md#speed-tests) from Practice Exercises
2. Time yourself - record results

**Afternoon (25 min):**
3. Real work test:
   - Open your project
   - Navigate to 5 different files using Telescope
   - Make edits to each using motions learned
   - Use LSP to explore code
   - Fix errors with code actions
   - Do a multi-file rename

**Weekend Homework:**
- Review all of Week 2
- Identify weakest skill and practice it
- Aim to be 2x faster than Week 1

**Week 2 Completion Criteria:**
- [ ] Navigate projects with Telescope effortlessly
- [ ] Use splits and windows comfortably
- [ ] LSP workflow feels natural (`gd`, `<C-o>`, `<Space>ca`)
- [ ] Can search and replace across files
- [ ] Faster than your old editor for navigation
- [ ] Starting to prefer Neovim

---

## Week 3: Real-World Workflows

**Goal:** Apply skills to daily development, advanced editing patterns

### Day 15-17: Workflow Practice

Follow [Workflow](workflow.md) guide, focusing on:

**Day 15:** Opening & File Navigation workflows
**Day 16:** Common Coding Scenarios (scenarios 1-5)
**Day 17:** Multi-File Refactor workflows

**Daily Practice (30 min each day):**
- Use Neovim for all work
- Follow workflows from guide
- Keep [Cheatsheet](cheatsheet.md) open

**Success Criteria:**
- [ ] Can start work in Neovim smoothly
- [ ] Handle common coding tasks efficiently
- [ ] Refactor across multiple files confidently

---

### Day 18-20: Advanced Text Manipulation

Follow [Text Manipulation](text-manipulation.md), focusing on:

**Day 18:** Text objects deep dive
**Day 19:** Multi-line editing
**Day 20:** Advanced editing patterns

**Daily Practice (30 min):**
- Focus on one text object per day
- Practice multi-line edits
- Try advanced refactoring patterns

**Success Criteria:**
- [ ] Master all text objects (`iw`, `i"`, `i(`, `it`, etc.)
- [ ] Can edit multiple lines efficiently
- [ ] Can perform complex refactors

---

### Day 21: Week Review & Real Project Work

**Time:** 60 minutes

**Full Hour:**
1. Pick a real feature to implement
2. Use only Neovim
3. Apply all skills learned
4. Time yourself vs. how long it would take in old editor

**Weekend Homework:**
- Use Neovim exclusively
- No switching back to VSCode "just this once"
- Review [Mistakes to Avoid](mistakes-to-avoid.md)

**Week 3 Completion Criteria:**
- [ ] Use Neovim for all daily work
- [ ] Handle real tasks efficiently
- [ ] Faster than old editor for most tasks
- [ ] Miss Neovim features when forced to use other editors

---

## Week 4: Mastery & Efficiency

**Goal:** Advanced techniques, macros, optimization, teaching others

### Day 22-24: Advanced Techniques

Follow [Advanced Techniques](advanced-techniques.md):

**Day 22:** Macros (Essential for automation)
**Day 23:** Registers (Clipboard mastery)
**Day 24:** Visual block mode (Column editing)

**Daily Practice (30 min):**
- Record at least one macro per day
- Use named registers for complex copy/paste
- Try visual block for column edits

**Success Criteria:**
- [ ] Can record and replay macros
- [ ] Use registers for complex copy/paste workflows
- [ ] Can edit columns with visual block mode

---

### Day 25-26: Polish & Optimization

**Day 25: Identify & Fix Weaknesses (30 min)**
1. Review [Mistakes to Avoid](mistakes-to-avoid.md)
2. Identify your most common antipatterns
3. Practice fixing them

**Day 26: Speed Optimization (30 min)**
1. Time yourself on common tasks
2. Find bottlenecks
3. Practice faster alternatives
4. Review [Cheatsheet](cheatsheet.md) for commands you forgot

**Success Criteria:**
- [ ] Eliminated main antipatterns
- [ ] Identified speed bottlenecks
- [ ] Know faster ways to do common tasks

---

### Day 27: Teach Someone Else

**Time:** 30-60 minutes

**Task:** Explain Neovim to a friend/colleague

Cover:
1. Why Neovim (modal editing concept)
2. Basic motions (`hjkl`, `w`, `b`)
3. Modes (normal, insert)
4. Basic editing (`dw`, `ciw`, `yy`, `p`)
5. One "wow" moment (LSP, macros, etc.)

**Why this works:** Teaching solidifies knowledge.

**Success Criteria:**
- [ ] Can explain modal editing
- [ ] Can demonstrate basic workflow
- [ ] Can answer beginner questions
- [ ] Realize how much you've learned!

---

### Day 28: Final Assessment & Future Planning

**Time:** 60 minutes

**Morning (30 min): Speed Test**
1. Repeat [Speed Tests](practice-exercises.md#speed-tests) from Week 2
2. Compare results - you should be 3-5x faster!

**Afternoon (30 min): Real Project Test**
1. Pick a complex refactoring task
2. Do it in Neovim
3. Time yourself
4. Compare to Week 1 estimate

**Final Checklist:**

**Fundamentals:**
- [ ] Navigate without mouse
- [ ] Use motions automatically (`w`, `b`, `f`, `t`)
- [ ] Edit text efficiently (`dw`, `ciw`, `ci"`)
- [ ] Understand text objects

**Project Work:**
- [ ] Open and navigate projects (Telescope)
- [ ] Use LSP features (`gd`, `<Space>ca`, `<Space>rn`)
- [ ] Search and replace across files
- [ ] Work with splits and windows

**Advanced:**
- [ ] Can record and use macros
- [ ] Use registers for complex workflows
- [ ] Know visual block mode
- [ ] Can customize config (if needed)

**Mindset:**
- [ ] Prefer Neovim to old editor
- [ ] Understand the philosophy
- [ ] Know how to learn new commands
- [ ] Can teach basics to others

---

## After 4 Weeks: Continuous Improvement

### Month 2 Goals

1. **Optimize your config** - Add plugins you need
2. **Learn language-specific features** - LSP per language
3. **Master macros** - Automate everything repetitive
4. **Contribute to projects** - Use Neovim professionally

### Monthly Review Checklist

Do this every month:

1. **Speed test** - Am I faster than last month?
2. **New technique** - Learn one new command/pattern
3. **Config review** - Remove unused plugins, add needed ones
4. **Teach someone** - Share knowledge, solidify learning

### Resources for Continued Learning

- `:help` - Neovim's built-in documentation
- `r/neovim` - Reddit community
- YouTube: ThePrimeagen, TJ DeVries
- GitHub: Explore others' configs

---

## Troubleshooting the Learning Path

### "I'm falling behind the schedule"

**Solution:** It's okay! Go at your own pace. Quality > speed.

### "Day X is too hard"

**Solution:** Repeat the previous day. Build foundation before advancing.

### "I'm tempted to use VSCode"

**Solution:** Don't! The "valley" (weeks 1-2) is hardest. Push through.

### "I forgot everything from earlier days"

**Solution:** Review is normal. Redo exercises from [Practice Exercises](practice-exercises.md).

### "This specific thing doesn't work for me"

**Solution:**
1. Check `:help <topic>`
2. Review your config
3. Ask in r/neovim

---

## Success Stories Template

Track your progress:

```
Week 1:
- Time to open and edit a file: ___ seconds
- Mouse usage: ___ times per hour
- Comfort level (1-10): ___

Week 2:
- Time to open and edit a file: ___ seconds
- Mouse usage: ___ times per hour
- Comfort level (1-10): ___

Week 3:
- Time to open and edit a file: ___ seconds
- Mouse usage: ___ times per hour
- Comfort level (1-10): ___

Week 4:
- Time to open and edit a file: ___ seconds
- Mouse usage: ___ times per hour
- Comfort level (1-10): ___

Improvement: ___%
```

---

## Graduation: You're a Neovim User!

After 4 weeks, you should:

✅ Navigate faster than ever before
✅ Edit text efficiently
✅ Use LSP like an IDE
✅ Prefer Neovim to other editors
✅ Feel confident in your skills
✅ Know how to continue learning

**Welcome to the Neovim community!** 🎉

Keep practicing, keep improving, keep sharing knowledge.

---

**[← Back to README](README.md) | [Practice Exercises →](practice-exercises.md)**
