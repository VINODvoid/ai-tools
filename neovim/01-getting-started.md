# Getting Started with Neovim

*Your first steps into Neovim - explained simply with visual guides*

## What You'll Learn

By the end of this guide (30 min), you'll:
- ✅ Understand Neovim's modes
- ✅ Know how to enter/exit insert mode
- ✅ Save and quit files
- ✅ Complete your first practice session
- ✅ Feel comfortable opening Neovim

---

## Opening Neovim

### From Terminal

```bash
# Open Neovim
nvim

# Open a file
nvim myfile.txt

# Open to a specific line (line 42)
nvim +42 myfile.txt
```

### What You See

When you open Neovim, you'll see something like this:

```
╔════════════════════════════════════════╗
║                                        ║
║         Welcome to Neovim!             ║
║                                        ║
║     Type :help to get started         ║
║     Type :q to quit                   ║
║                                        ║
║                                        ║
║~                                       ║
║~                                       ║
║~                                       ║
╚════════════════════════════════════════╝
```

Lines with `~` are empty lines (no content).

---

## Understanding Modes

This is the most important concept in Neovim.

### The Four Modes

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  1. NORMAL MODE (Default - Command Mode)        │
│     - Navigate around                           │
│     - Delete, copy, paste                       │
│     - Give commands                             │
│     - This is where you spend most time         │
│                                                 │
└─────────────────────────────────────────────────┘
         │                           ▲
         │ Press: i, a, o, O         │
         │                           │ Press: <Esc> or jk
         ▼                           │
┌─────────────────────────────────────────────────┐
│                                                 │
│  2. INSERT MODE (Typing Mode)                   │
│     - Type text like a normal editor            │
│     - Get in, type what you need, get out       │
│                                                 │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│                                                 │
│  3. VISUAL MODE (Selection Mode)                │
│     - Select text (like click and drag)         │
│     - Press: v, V, or <C-v> in normal mode      │
│                                                 │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│                                                 │
│  4. COMMAND-LINE MODE (Run Commands)            │
│     - Save files (:w)                           │
│     - Quit (:q)                                 │
│     - Search and replace                        │
│     - Press: : in normal mode                   │
│                                                 │
└─────────────────────────────────────────────────┘
```

### How to Tell Which Mode You're In

Look at the bottom left of your Neovim window:

```
-- INSERT --        ← You're in insert mode
-- VISUAL --        ← You're in visual mode
(blank)             ← You're in normal mode
```

---

## Your First 5 Minutes

### Exercise 1: Open, Type, Save, Quit

**Step 1: Create a practice file**

```bash
nvim practice.txt
```

**Step 2: Enter insert mode**

Press `i` (for "insert")

You'll see `-- INSERT --` at the bottom.

**Step 3: Type something**

```
Hello, Neovim!
This is my first file.
I am learning to use Neovim.
```

**Step 4: Exit insert mode**

Press `<Esc>` (escape key)

Or press `jk` quickly (your config has this shortcut!)

The `-- INSERT --` disappears.

**Step 5: Save the file**

Type: `:w` and press `<Enter>`

```
:w<Enter>
```

You'll see: `"practice.txt" 3L, 64B written`

**Step 6: Quit Neovim**

Type: `:q` and press `<Enter>`

```
:q<Enter>
```

You're back at the terminal!

### Visual Representation

```
Terminal → nvim practice.txt → Neovim Opens
                                    │
                                    │ Press i
                                    ▼
                                INSERT MODE
                                    │
                                    │ Type your text
                                    │ Press <Esc>
                                    ▼
                                NORMAL MODE
                                    │
                                    │ Type :w<Enter>
                                    ▼
                                File Saved!
                                    │
                                    │ Type :q<Enter>
                                    ▼
                                Back to Terminal
```

---

## Essential Commands (Memorize These)

### Entering Insert Mode

```
i     Insert before cursor
      ┌─────┐
      │ cursor
      ▼
      Hello |World

      Press i → type "New " → Hello New |World

a     Append after cursor
      Hello| World
      Press a → type "!" → Hello!| World

o     Open new line below
      Line 1|
      Press o →
      Line 1
      |         ← cursor on new line

O     Open new line above
      |Line 2
      Press O →
      |         ← cursor on new line above
      Line 2

I     Insert at start of line

A     Append at end of line
```

### Exiting Insert Mode

```
<Esc>     Standard way (reach for escape key)
jk        Quick way (configured in your setup)
<C-[>     Alternative (Ctrl + [)
```

**Pro tip:** Use `jk` - it's faster and your fingers stay on home row!

### Saving and Quitting

```
:w        Write (save) file
:q        Quit Neovim
:wq       Write and quit
:q!       Quit without saving (discard changes)
:x        Write if changed, then quit (smarter than :wq)
```

### Visual Guide: The :wq Family

```
┌──────────────────────────────────────────────┐
│  You made changes to file                    │
└──────────────────────────────────────────────┘
                    │
        ┌───────────┼───────────┐
        │                       │
   Keep changes?           Discard changes?
        │                       │
        ▼                       ▼
      :wq                     :q!
   (save & quit)        (quit without saving)


┌──────────────────────────────────────────────┐
│  You might have made changes                 │
└──────────────────────────────────────────────┘
                    │
                    ▼
                   :x
          (saves only if changed,
           then quits - efficient!)
```

---

## Practice Session 1 (10 Minutes)

### Setup

```bash
nvim practice1.txt
```

### Exercises

**Exercise 1.1: Basic Insert**

1. Press `i`
2. Type: `The quick brown fox`
3. Press `<Esc>` (or `jk`)
4. Success! You entered and exited insert mode.

**Exercise 1.2: Insert at Different Positions**

Current text: `The quick brown fox`

1. Move cursor to 'q' (we'll learn movement soon, use arrow keys for now)
2. Press `i`, type `very `, press `<Esc>`
3. Result: `The very quick brown fox`

**Exercise 1.3: Append**

Current text: `The very quick brown fox`

1. Move cursor to 'x'
2. Press `a`, type ` jumps`, press `<Esc>`
3. Result: `The very quick brown fox jumps`

**Exercise 1.4: New Lines**

1. Press `o` (new line below)
2. Type: `over the lazy dog`
3. Press `<Esc>`
4. Press `O` (new line above current)
5. Type: `---`
6. Press `<Esc>`

Result:
```
The very quick brown fox jumps
---
over the lazy dog
```

**Exercise 1.5: Save and Quit**

1. Type `:w` and press `<Enter>` (file saved)
2. Type `:q` and press `<Enter>` (Neovim closed)

### Check Your Understanding

✅ Can you open Neovim?
✅ Can you enter insert mode with `i`?
✅ Can you exit insert mode with `<Esc>` or `jk`?
✅ Can you save with `:w`?
✅ Can you quit with `:q`?

If yes to all, you're ready to continue!

---

## Common Questions

### "How do I know if I'm in insert mode?"

Look at the bottom left. If you see `-- INSERT --`, you're in insert mode. If it's blank, you're in normal mode.

### "I pressed a key and weird stuff happened!"

You were probably in normal mode. In normal mode, keys are commands, not text.

**Solution:** Press `<Esc>` a few times to ensure you're in normal mode, then press `u` to undo.

### "How do I close Neovim if I'm stuck?"

1. Press `<Esc>` several times (get to normal mode)
2. Type `:q!` and press `<Enter>` (quit without saving)

### "Can I use the mouse?"

Yes, but you'll learn it's slower. Neovim's power is keyboard-only navigation.

### "Do I really have to press <Esc> every time?"

No! Your config has `jk` as a shortcut. Press `j` then `k` quickly while in insert mode. Much faster!

---

## Your Neovim Configuration

You have Neovim configured at: `~/.config/nvim/`

### Useful Features Already Configured

1. **`jk` exits insert mode** - Faster than reaching for `<Esc>`
2. **Relative line numbers** - Shows distance to other lines
3. **System clipboard** - Copy/paste works with system clipboard
4. **Auto-save on `<C-s>`** - Ctrl+S saves (familiar shortcut)
5. **Telescope** - Fuzzy file finder (we'll learn this soon)
6. **LSP** - Code intelligence (autocomplete, go-to-definition)

### See Your Config

```bash
# View your main config file
nvim ~/.config/nvim/init.lua
```

Don't worry about understanding it all now. Just know it's there.

---

## Practice Session 2 (10 Minutes)

Let's practice the insert mode variations.

```bash
nvim practice2.txt
```

### Exercise 2.1: All Insert Commands

Type this poem, using different insert commands:

1. Press `i`, type `Roses are red` → `<Esc>`
2. Press `o`, type `Violets are blue` → `<Esc>`
3. Press `A` (jump to end of line), type `,` → `<Esc>`
4. Move to line 2, press `A`, type `.` → `<Esc>`
5. Press `O`, type `---` → `<Esc>`

Result:
```
Roses are red,
---
Violets are blue.
```

### Exercise 2.2: Fix Typos

1. Type (intentionally wrong): `Neovim is awsome`
2. Press `<Esc>`
3. Move cursor to 'w' in 'awsome'
4. Press `i`, type `e` → `<Esc>`
5. Result: `Neovim is awesome`

### Exercise 2.3: Save Practice

1. Type `:w` → `<Enter>` (save)
2. Make a change
3. Type `:q` → `<Enter>`
4. You'll see: `No write since last change`
5. Type `:q!` → `<Enter>` (quit without saving)

---

## Glossary of Terms

**Buffer** - A file loaded into memory (you'll have multiple open)
**Window** - A view of a buffer (can split screen)
**Tab** - A collection of windows
**Motion** - A command that moves the cursor
**Operator** - A command that acts on text (delete, copy, etc.)
**Text Object** - A semantic unit (word, sentence, paragraph)
**Command-line** - The `:` prompt at the bottom
**Leader key** - Special prefix for custom commands (yours is `<Space>`)

Don't worry about memorizing these. You'll learn them naturally.

---

## Next Steps

### You Now Know:

✅ How to open Neovim
✅ The four modes
✅ How to enter/exit insert mode
✅ How to save and quit
✅ Basic insert commands (`i`, `a`, `o`, `O`)

### What's Next:

**[Basic Motions →](02-basic-motions.md)**

You'll learn how to move around efficiently without arrow keys. This is where Neovim starts to feel powerful.

**Estimated time:** 30 minutes

---

## Quick Reference Card

Print or save this:

```
┌────────────────────────────────────────────────┐
│  ESSENTIAL COMMANDS - DAY 1                    │
├────────────────────────────────────────────────┤
│                                                │
│  OPEN:        nvim filename                    │
│                                                │
│  INSERT:      i (before cursor)                │
│               a (after cursor)                 │
│               o (new line below)               │
│               O (new line above)               │
│                                                │
│  EXIT INSERT: <Esc> or jk                      │
│                                                │
│  SAVE:        :w<Enter>                        │
│  QUIT:        :q<Enter>                        │
│  SAVE & QUIT: :wq<Enter> or :x<Enter>          │
│  QUIT NO SAVE::q!<Enter>                       │
│                                                │
│  UNDO:        u (in normal mode)               │
│                                                │
└────────────────────────────────────────────────┘
```

---

## Homework Before Next Lesson

1. **Open and close Neovim 10 times** - Build muscle memory
2. **Practice `jk` to exit insert mode** - Until it feels natural
3. **Edit a real file** - Try editing one of your code files
4. **Use only Neovim** - Don't open VSCode/other editor today

**Tomorrow:** Learn to move around without arrow keys!

---

**[← Back to README](README.md) | [Next: Basic Motions →](02-basic-motions.md)**
