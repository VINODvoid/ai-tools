# Mistakes to Avoid

Common antipatterns and pitfalls that slow down Neovim users. Learn from others' mistakes.

## Motion Antipatterns

### ❌ Holding Down Movement Keys

```vim
# Bad: Holding j for 20 lines
jjjjjjjjjjjjjjjjjjjj

# Good: Count + motion or search
20j
or
/targetLine<CR>
or
{  (jump paragraph)
```

**Why bad:** Slow, imprecise, finger fatigue.

**Fix:** Use counts (`{number}j/k`), paragraph jumps (`{}`), search (`/`), or relative line numbers.

---

### ❌ Character-by-Character Movement

```vim
# Bad: Moving character by character
lllllllll

# Good: Word motion
w or e
or f{char}
```

**Why bad:** Extremely slow for horizontal movement.

**Fix:** `w` (word), `e` (end of word), `b` (back), `f{char}` (find char).

---

### ❌ Not Using Text Objects

```vim
# Bad: Visual select word
vllllx

# Good: Text object
diw

# Bad: Delete to semicolon
/;<CR>dh

# Good: Delete until semicolon
dt;
```

**Why bad:** More keystrokes, slower, error-prone.

**Fix:** Master text objects: `iw`, `i"`, `i(`, `it`, `ap`.

---

### ❌ Arrow Keys

```vim
# Bad: Using arrow keys
<Up><Up><Up><Right><Right>

# Good: Vim motions
3k2w
```

**Why bad:** Hands leave home row, slow.

**Fix:** Force yourself: `noremap <Up> <Nop>` in config. Use `hjkl`, `w/b/e`, `{/}`.

---

## Editing Antipatterns

### ❌ Staying in Insert Mode

```vim
# Bad: Backspace in insert mode
typing... <backspace><backspace><backspace><backspace>

# Good: Exit to normal, delete, re-enter
typing... <Esc> dw i
```

**Why bad:** Insert mode is for inserting, not navigation/deletion.

**Fix:** `<Esc>` (or `jk` in your config), make edit, re-enter insert.

---

### ❌ Using Visual Mode for Simple Edits

```vim
# Bad: Visual select to delete word
viwd

# Good: Text object delete
diw

# Bad: Visual select to change inside quotes
vi"c

# Good: Change inside quotes
ci"
```

**Why bad:** Extra keystrokes, visual mode is slower.

**Fix:** If text object can do it, don't use visual mode.

---

### ❌ Not Using the Dot Command (`.`)

```vim
# Bad: Repeating command manually
dw ... navigate ... dw ... navigate ... dw

# Good: Delete once, repeat with dot
dw ... navigate ... . ... navigate ... .
```

**Why bad:** Repetitive, error-prone.

**Fix:** Make change once, use `.` to repeat.

---

### ❌ Manual Repetition Instead of Macros

```vim
# Bad: Manually add semicolons to 50 lines
A;<Esc> j A;<Esc> j A;<Esc> j ... (48 more times)

# Good: Record macro
qa A;<Esc> j q
48@a
```

**Why bad:** Tedious, waste of time.

**Fix:** If you do something 3+ times, record a macro.

---

## Search/Replace Antipatterns

### ❌ Using Regex for Code Refactoring

```vim
# Bad: Rename function with substitute
:%s/oldFunction/newFunction/g

# Good: Use LSP rename
cursor on oldFunction → <Space>rn → newFunction
```

**Why bad:** Not scope-aware, renames wrong things, misses imports.

**Fix:** Use LSP rename (`<Space>rn`) for code, regex for text.

---

### ❌ Not Testing Pattern First

```vim
# Bad: Blind substitute
:%s/complex.*pattern/replacement/g
→ (breaks everything)

# Good: Test search first
/complex.*pattern<CR>
→ verify matches
→ :%s//replacement/gc
```

**Why bad:** Can break code unexpectedly.

**Fix:** Always test with `/pattern` before `:s`, use `c` flag for confirmation.

---

### ❌ Forgetting the `g` Flag

```vim
# Bad: Only replaces first match per line
:%s/foo/bar/

# Good: Global on each line
:%s/foo/bar/g
```

**Why bad:** Incomplete replacements.

**Fix:** Almost always use `/g` flag.

---

## Navigation Antipatterns

### ❌ Not Using Telescope/Fuzzy Finder

```vim
# Bad: Manual file navigation
:e src/
:e src/components/
:e src/components/User/
:e src/components/User/Profile.tsx

# Good: Fuzzy find
<Space>ff → type "userprof" → <CR>
```

**Why bad:** Extremely slow for large projects.

**Fix:** Use your Telescope bindings: `<Space>ff`, `<Space>fs`.

---

### ❌ Not Using `<C-o>` After `gd`

```vim
# Bad: Navigate manually back after goto definition
gd → read code → <Space>ff → find original file → find line

# Good: Jump back
gd → read code → <C-o>
```

**Why bad:** Wastes time, you have a jump stack!

**Fix:** `gd` then `<C-o>` is the pattern. Always.

---

### ❌ Not Using Marks

```vim
# Bad: Navigate to important location repeatedly
/important line<CR> ... do work ... /important line<CR> ... repeat

# Good: Set mark
/important line<CR> → mI ... do work ... 'I
```

**Why bad:** Repeated searches waste time.

**Fix:** Mark important locations with `m{a-zA-Z}`, jump with `'{mark}`.

---

### ❌ Scrolling to Find Line Number

```vim
# Bad: Error says line 247
<C-d><C-d><C-d><C-d>... until you see line 247

# Good: Jump directly
:247<CR>
or
247G
```

**Why bad:** Extremely slow.

**Fix:** Use `:line_number` or `{number}G`.

---

## LSP Antipatterns

### ❌ Not Using LSP for Imports

```vim
# Bad: Manually typing import statement
import { useState } from 'react';

# Good: Type and auto-import
useState → <Space>ca → "Add import from react"
```

**Why bad:** Wastes time, typos possible.

**Fix:** Use `<Space>ca` for auto-imports.

---

### ❌ Ignoring Diagnostics

```vim
# Bad: Code has 20 errors, you ignore them
(red squiggly lines everywhere)

# Good: Fix as you go
]d → <Space>ca → fix → ]d → repeat
```

**Why bad:** Tech debt accumulates, harder to fix later.

**Fix:** Address diagnostics immediately: `]d`, `<Space>d`, `<Space>ca`.

---

### ❌ Not Restarting LSP When Stuck

```vim
# Bad: Completions stopped working 10 minutes ago, still struggling

# Good: Restart immediately
<Space>rs
or :LspRestart
```

**Why bad:** Wastes debugging time, simple restart fixes most issues.

**Fix:** If LSP acts weird, restart. It's fast.

---

## Configuration Antipatterns

### ❌ Too Many Plugins

```vim
# Bad: 50+ plugins installed
→ slow startup (3+ seconds)
→ conflicting keybindings
→ hard to debug
```

**Why bad:** Neovim becomes slow, unreliable.

**Fix:** Audit plugins quarterly, remove unused ones, lazy-load when possible.

---

### ❌ Not Lazy-Loading Plugins

```vim
# Bad: All plugins load on startup
→ startup time: 2 seconds

# Good: Lazy-load with lazy.nvim
→ startup time: 50ms
```

**Why bad:** Slow startup kills productivity.

**Fix:** Use `lazy.nvim` properly, load plugins on events/commands.

---

### ❌ Copying Configs Without Understanding

```vim
# Bad: Copy entire Kickstart.nvim, don't know what half of it does

# Good: Start minimal, add config as you learn what you need
```

**Why bad:** Can't customize, can't debug, cargo-cult programming.

**Fix:** Build config incrementally, understand each line.

---

### ❌ Not Using Version Control for Config

```vim
# Bad: No git repo for config
→ break something, can't revert

# Good: Git repo at ~/.config/nvim/
→ git commit after every change
→ easy rollback
```

**Why bad:** Config changes can break things, no rollback.

**Fix:** `cd ~/.config/nvim && git init`, commit regularly.

---

## Workflow Antipatterns

### ❌ Opening Multiple Neovim Instances for Same Project

```vim
# Bad: 5 terminal tabs, each with nvim in same project
→ changes in one not visible in others
→ LSP runs 5 times

# Good: One Neovim, multiple buffers/tabs
<Space>ff → open files as buffers
<Space>fb → switch between buffers
```

**Why bad:** Inconsistent state, resource waste.

**Fix:** Use buffers, splits, tabs within one instance.

---

### ❌ Not Using Sessions

```vim
# Bad: Close Neovim, lose all open files, window layout
→ next day, manually re-open everything

# Good: Session management (you have auto-session!)
→ sessions auto-save/restore
```

**Why bad:** Waste time reconstructing workspace.

**Fix:** Use your auto-session plugin, or `:mksession`.

---

### ❌ Fighting Neovim Instead of Learning

```vim
# Bad: "This is too hard, I'll just use VSCode"
→ never invest time to learn
→ never reap benefits

# Good: Commit to 2-4 weeks of pain
→ slower at first
→ much faster after
```

**Why bad:** Miss out on long-term productivity gains.

**Fix:** Use Neovim for *everything* for 1 month. No switching back and forth.

---

## Register/Clipboard Antipatterns

### ❌ Not Using Named Registers

```vim
# Bad: Yank, delete overwrites, lose original yank
yiw → delete other text → can't paste original word

# Good: Named register
"ayiw → delete other text → "ap
```

**Why bad:** Lose copied text easily.

**Fix:** Use named registers `"a` through `"z`.

---

### ❌ Not Using Black Hole Register

```vim
# Bad: Delete something, overwrites clipboard
yiw (copy word) → dd (delete line, overwrites!) → p (pastes deleted line, not word)

# Good: Delete to black hole
yiw → "_dd → p (pastes word!)
or use your binding: <Space>d
```

**Why bad:** Unintentionally clobber clipboard.

**Fix:** Delete to `"_` (black hole) when you don't need deleted text.

---

## Performance Antipatterns

### ❌ Syntax Highlighting for Huge Files

```vim
# Bad: Open 10,000-line minified JS file
→ Neovim lags

# Good: Disable syntax for large files
:syntax off
```

**Why bad:** Slow editing.

**Fix:** Auto-disable syntax for files >1MB (configure in options).

---

### ❌ Recursive Operations on Massive Directories

```vim
# Bad: `:grep pattern **/*` in node_modules/

# Good: Exclude large directories
:grep pattern --exclude-dir=node_modules **/*
```

**Why bad:** Extremely slow, often hangs.

**Fix:** Configure grep/Telescope to ignore `node_modules`, `.git`, `dist`, `build`.

---

## Miscellaneous Antipatterns

### ❌ Not Reading `:help`

```vim
# Bad: Google every Neovim question

# Good: :help motion.txt, :help registers, etc.
```

**Why bad:** External docs often outdated, `:help` is canonical.

**Fix:** `:help {topic}` first, Google second.

---

### ❌ Not Using Which-Key (or Similar)

```vim
# Bad: Forget keybindings constantly

# Good: which-key plugin shows available bindings
<Space> → wait → popup shows all leader bindings
```

**Why bad:** Can't use what you can't remember.

**Fix:** Install/configure which-key plugin.

---

### ❌ Trying to Make Neovim Exactly Like VSCode

```vim
# Bad: Install 20 plugins to replicate VSCode UI

# Good: Embrace Neovim's paradigm, minimal UI
```

**Why bad:** Defeats purpose of Neovim, bloated config.

**Fix:** Learn Neovim way, don't force VSCode patterns.

---

## Recovery from Mistakes

### Accidentally Deleted Important Text

```vim
# Undo
u

# Time travel
:earlier 5m

# Check registers
:registers
→ find deleted text in "1 through "9
"1p  (paste from register 1)
```

### Broke Config

```vim
# Rollback with git
cd ~/.config/nvim
git log
git checkout <previous-commit>

# Or rename config temporarily
mv ~/.config/nvim ~/.config/nvim.backup
→ restart Neovim (runs without config)
→ debug issue
```

### LSP Completely Broken

```vim
:checkhealth lsp
:Mason → reinstall language server
:LspRestart
```

### Neovim Frozen

```vim
# In terminal (outside Neovim)
kill -9 <pid>

# Or inside Neovim (if responsive)
:qa!
```

---

## Self-Check Quiz

You're making these mistakes if:

- [ ] You hold down `j` to scroll
- [ ] You use visual mode to delete a word
- [ ] You type imports manually
- [ ] You search for files with `:e` instead of Telescope
- [ ] You use `:wq` instead of `:x`
- [ ] You don't use `<C-o>` after `gd`
- [ ] You use `:s` for code refactoring
- [ ] You have 30+ plugins and don't know what they do
- [ ] You don't use macros for repetitive tasks
- [ ] You ignore LSP diagnostics

**If you checked 3+, review this file monthly.**

---

## The Path Forward

1. **Audit your habits** - Record yourself for 10 minutes, watch for antipatterns
2. **One fix per week** - Pick one mistake, consciously correct it for a week
3. **Review this file monthly** - Catch bad habits before they stick
4. **Pair program** - Watch proficient Neovim users, steal their patterns
5. **Read other people's configs** - See how experts structure theirs

**Mistakes are the path to mastery.** Recognize, correct, repeat.

---

**Next**: Use [Cheatsheet](cheatsheet.md) as your daily reference, or review [Your Keybindings](your-keybindings.md) for your specific setup.
