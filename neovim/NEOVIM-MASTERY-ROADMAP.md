# Neovim Mastery Roadmap
*Your Complete Path from Beginner to Expert*

## 📚 What You Have vs What You Need

### ✅ Files That Exist
- `01-getting-started.md` - Installation, modes, first steps
- `02-basic-motions.md` - Movement fundamentals (YOU'VE READ THIS)
- `text-manipulation.md` - Comprehensive editing guide
- `workflow.md` - Real-world development patterns
- `navigation.md` - File/buffer/window navigation
- `search-and-replace.md` - Finding and changing text
- `lsp-usage.md` - IDE features (autocomplete, go-to-definition)
- `advanced-techniques.md` - Macros, registers, visual block
- `cheatsheet.md` - Quick reference
- `your-keybindings.md` - Your specific keybindings
- `practice-exercises.md` - Hands-on drills
- `mistakes-to-avoid.md` - Common pitfalls
- `modal-editing.md` - Understanding modal editing
- `learning-path.md` - Week-by-week plan

### ⚠️ Referenced But Missing
- `03-editing-basics.md` - Should cover basic editing operations
- `04-intermediate-skills.md` - Should cover combining skills

**Good news**: The content for these exists in `text-manipulation.md`, it's just very advanced. I'll create a proper learning structure below.

---

## 🎯 Your Structured Learning Path

### Phase 1: Foundation (Week 1)
**You are here → transitioning to Phase 2**

#### Day 1-2: Getting Started ✅
**File**: `01-getting-started.md`
- Understand modes (normal, insert, visual, command)
- Basic file operations (`:w`, `:q`, `:x`)
- Insert mode entries (`i`, `a`, `o`, `O`)

#### Day 3-4: Basic Motions ✅ COMPLETED
**File**: `02-basic-motions.md`
- `hjkl` navigation
- Word motions (`w`, `b`, `e`)
- Line motions (`0`, `^`, `$`, `gg`, `G`)
- Character finding (`f`, `F`, `t`, `T`)
- Jumping (`{`, `}`, `%`)

#### Day 5-7: Editing Basics (NEXT STEP)
**Primary file**: `text-manipulation.md` (sections: Operators, Text Objects)
**Focus on these sections**:
1. **Delete Operator** (lines 5-22)
   - `dw` - delete word
   - `dd` - delete line
   - `d$` - delete to end
   - `dt;` - delete until semicolon

2. **Change Operator** (lines 43-81)
   - `cw` - change word
   - `ciw` - change inner word
   - `ci"` - change inside quotes
   - `ci(` - change inside parentheses
   - `cc` - change line

3. **Yank (Copy) Operator** (lines 83-119)
   - `yy` - copy line
   - `yw` - copy word
   - `yi"` - copy inside quotes
   - `p` - paste after
   - `P` - paste before

4. **Text Objects Introduction** (lines 222-308)
   - `iw`/`aw` - word objects
   - `i"`/`a"` - quote objects
   - `i(`/`a(` - parentheses objects
   - Understanding "inner" vs "around"

**Practice Priority**:
- Spend 2 days on: `dw`, `dd`, `ciw`, `ci"`, `yy`, `p`
- These 6 commands cover 80% of editing needs

---

### Phase 2: Building Fluency (Week 2)

#### Day 8-10: Navigation & Your Setup
**Files**:
1. `navigation.md` - Project navigation
2. `your-keybindings.md` - Your custom bindings

**Master these**:
- Telescope file finding (`<Space>ff`)
- Buffer navigation (`<Space>fb`)
- Window splits (`<Space>sv`, `<Space>sh`)
- Window navigation (`<C-h/j/k/l>`)

#### Day 11-14: LSP & Search
**Files**:
1. `lsp-usage.md` - IDE features
2. `search-and-replace.md` - Find and replace

**Master these**:
- `gd` - go to definition
- `<C-o>` - jump back
- `<Space>ca` - code actions
- `<Space>rn` - rename
- `]d`/`[d]` - next/prev error
- `/pattern` - search
- `:%s/old/new/gc` - replace

---

### Phase 3: Real Workflows (Week 3)

#### Day 15-21: Production Development
**File**: `workflow.md` (READ THIS THOROUGHLY)

**Focus on these scenarios**:
1. Opening projects (lines 8-28)
2. Implementing new functions (lines 63-81)
3. Refactoring variables (lines 85-99)
4. Fixing linting errors (lines 101-122)
5. Multi-file refactors (lines 208-226)
6. Split screen work (lines 229-251)

**Key Pattern to Memorize**:
```
1. Find file: <Space>ff → filename
2. Navigate: gd (go to def), <C-o> (back)
3. Edit: ciw, di", etc.
4. Search: <Space>fs → pattern
5. Replace: :%s/old/new/gc
```

---

### Phase 4: Mastery (Week 4)

#### Day 22-25: Advanced Techniques
**File**: `advanced-techniques.md`

**Focus**:
- Macros (record repetitive tasks)
- Registers (clipboard management)
- Visual block mode (column editing)

#### Day 26-28: Polish & Speed
**Files**:
1. `mistakes-to-avoid.md` - Fix bad habits
2. `cheatsheet.md` - Keep this OPEN always
3. `practice-exercises.md` - Daily drills

---

## 🚀 Quick Start: What to Do RIGHT NOW

### Step 1: Read This Section of text-manipulation.md

Since you can't find "03-editing-basics.md", use `text-manipulation.md` as your next step:

```bash
nvim neovim/text-manipulation.md
```

**Read ONLY these sections** (don't overwhelm yourself):
1. Lines 5-40: Delete operator basics
2. Lines 43-81: Change operator basics
3. Lines 83-119: Yank operator basics
4. Lines 222-273: Text objects (word and quote objects)

### Step 2: Practice These 10 Commands (30 minutes)

Open a practice file:
```bash
nvim neovim/pratice-playground/practice-motions.txt
```

Practice:
1. `dw` - delete word (5 times)
2. `dd` - delete line (5 times)
3. `ciw` - change word (10 times) ⭐ MOST IMPORTANT
4. `ci"` - change inside quotes (5 times)
5. `ci(` - change inside parentheses (5 times)
6. `yy` - copy line (5 times)
7. `yw` - copy word (5 times)
8. `p` - paste (10 times)
9. `u` - undo (as needed)
10. `.` - repeat last change (5 times)

### Step 3: Real Work Test (15 minutes)

Open a real code file and:
1. Find a variable → `ciw` → rename it
2. Find a string → `ci"` → change content
3. Find a function call → `ci(` → change arguments
4. Delete 3 lines → `dd` → `dd` → `dd`
5. Copy a line → `yy` → move cursor → `p`

---

## 📖 Your Next 7 Days

### Today (Day 1)
- ✅ Read this roadmap (you're doing it!)
- ⏳ Read text-manipulation.md sections mentioned above (30 min)
- ⏳ Practice 10 commands in practice file (30 min)
- ⏳ Try on real code (15 min)

### Day 2-3: Master Text Objects
**Goal**: Make `ciw`, `ci"`, `ci(` automatic

Morning (20 min):
- Read text-manipulation.md lines 222-308 (Text Objects)
- Understand "inner" (`i`) vs "around" (`a`)

Practice (20 min):
- `ciw` - change 20 different words
- `ci"` - change 10 different strings
- `ci(` - change 5 function arguments
- `dap` - delete 5 paragraphs

Real work (20 min):
- Use ONLY text objects for all editing
- No visual mode allowed!

### Day 4-5: Combine Skills
**Goal**: Chain motions with operators

Practice combining:
- Find + change: `f(` → `ci(`
- Multiple changes: `ciw` → `n` → `.`
- Search + replace: `/pattern` → `ciw` → `n` → `.`

### Day 6-7: Workflow Integration
**Goal**: Use Neovim for real work

Read: `workflow.md` (entire file)
- Focus on "Daily Development Workflow" section
- Learn your Telescope keybindings
- Practice file navigation

Use Neovim exclusively:
- Open your project: `nvim .`
- Find files: `<Space>ff`
- Search code: `<Space>fs`
- Edit using what you learned

---

## 🎓 Learning Principles

### 1. Master One Thing Before Moving On
Don't learn 50 commands. Learn 5, use them for 2 days, then add 5 more.

**Week 1 focus**: `hjkl`, `w`, `b`, `dw`, `dd`, `ciw`, `ci"`, `yy`, `p`
**Week 2 focus**: Add Telescope, LSP (`gd`, `<C-o>`)
**Week 3 focus**: Real workflows
**Week 4 focus**: Speed and polish

### 2. Practice > Reading
Reading 10 files won't make you fast. Practicing 10 commands will.

**Minimum daily practice**:
- Morning: 10 minutes in practice file
- Work: Use Neovim exclusively
- Evening: Review one section from docs

### 3. Use the Cheatsheet
**Always keep open**:
```bash
nvim neovim/cheatsheet.md
```

Split screen while coding:
```vim
<Space>sv  " Split vertically
<Space>ff  " Open cheatsheet
<C-h>      " Back to code
```

### 4. Understand Composability

You don't memorize 1000 commands. You learn:
- **10 operators**: `d`, `c`, `y`, `>`, `<`, `=`, etc.
- **10 motions**: `w`, `b`, `$`, `}`, `%`, etc.
- **10 text objects**: `iw`, `i"`, `i(`, `ip`, etc.

Then **combine**: `d` + `iw` = delete word, `c` + `i"` = change inside quotes

That's **10 × 10 × 10 = 1000 combinations** from **30 concepts**!

---

## 📊 Track Your Progress

### Week 1 Checklist
- [ ] Can navigate with `hjkl` without thinking
- [ ] Use `w`, `b`, `e` for word movement
- [ ] Can delete with `dw`, `dd`
- [ ] Can change with `ciw`, `ci"`, `ci(`
- [ ] Can copy/paste with `yy`, `p`
- [ ] Understand text objects (inner vs around)
- [ ] Use `.` to repeat changes

### Week 2 Checklist
- [ ] Find files with `<Space>ff`
- [ ] Search code with `<Space>fs`
- [ ] Navigate splits with `<C-h/j/k/l>`
- [ ] Use `gd` to jump to definitions
- [ ] Use `<C-o>` to jump back
- [ ] Fix errors with `]d` and `<Space>ca`
- [ ] Rename with `<Space>rn`

### Week 3 Checklist
- [ ] Use Neovim for all daily work
- [ ] Open projects smoothly
- [ ] Navigate without mouse
- [ ] Edit faster than old editor
- [ ] Use LSP features naturally
- [ ] Refactor across multiple files

### Week 4 Checklist
- [ ] Record and use macros
- [ ] Use registers effectively
- [ ] Visual block mode comfortable
- [ ] Know when to use advanced techniques
- [ ] Faster than before starting Neovim
- [ ] Can teach basics to others

---

## 🔥 The Essential 20 Commands

If you only learn 20 things, learn these:

### Navigation (5)
1. `w` / `b` - word forward/back
2. `f{char}` - find character
3. `{` / `}` - paragraph up/down
4. `gg` / `G` - top/bottom of file
5. `*` - search word under cursor

### Editing (10)
6. `ciw` - change word ⭐
7. `ci"` - change inside quotes ⭐
8. `ci(` - change inside parens ⭐
9. `dd` - delete line
10. `yy` - copy line
11. `p` - paste
12. `u` - undo
13. `.` - repeat last change ⭐
14. `A` - append to line end
15. `I` - insert at line start

### Your Custom Bindings (5)
16. `<Space>ff` - find files ⭐
17. `<Space>fs` - search in files ⭐
18. `gd` - go to definition ⭐
19. `<C-o>` - jump back ⭐
20. `<Space>ca` - code actions ⭐

**⭐ = Use these daily**

---

## 🗺️ The Complete File Reading Order

### Beginner Path (In Order)
1. ✅ `01-getting-started.md` - Done presumably
2. ✅ `02-basic-motions.md` - You've read this
3. 📖 `text-manipulation.md` - Read sections 1-3 (operators) **← YOU ARE HERE**
4. 📖 `your-keybindings.md` - Learn your setup
5. 📖 `navigation.md` - Project navigation
6. 📖 `workflow.md` - Real-world patterns
7. 📖 `lsp-usage.md` - IDE features
8. 📖 `search-and-replace.md` - Find and change

### Reference Materials (Keep Open)
- `cheatsheet.md` - Always available
- `practice-exercises.md` - Daily drills

### Advanced Topics (Later)
- `advanced-techniques.md` - Week 4
- `mistakes-to-avoid.md` - Week 4
- `modal-editing.md` - Theory (read anytime)

---

## 💡 Pro Tips

### Tip 1: Don't Skip Text Objects
`ciw` is better than `dw` then `i`. Learn text objects early!

### Tip 2: Use `.` Religiously
Change one thing, then `n` to next match, then `.` to repeat. This alone 10x's your speed.

### Tip 3: Keep Cheatsheet Visible
Split screen with cheatsheet open. Check it 100 times a day.

### Tip 4: No Arrow Keys
Force yourself to use `hjkl`. Pain now, speed later.

### Tip 5: Use Neovim Exclusively
Don't switch back to VSCode. Commit to 2 weeks minimum.

---

## 🆘 When You're Stuck

### "I don't know what to practice"
→ Open `practice-exercises.md`, do the drills

### "I can't remember the commands"
→ Keep `cheatsheet.md` open, check it constantly

### "This is too slow"
→ Normal! Week 1-2 are hard. Week 3 you'll match your old speed. Week 4 you'll be faster.

### "I want to give up"
→ Don't! The valley is temporary. 2 weeks of pain = years of speed gain.

### "What file should I read next?"
→ Follow the order in this roadmap. Don't jump around.

---

## 🎯 Your Immediate Next Steps

1. **Right Now** (5 min):
   - Open `text-manipulation.md`
   - Read lines 5-119 (Delete, Change, Yank operators)

2. **Today** (30 min):
   - Practice the 10 commands listed above
   - Use practice file for drills

3. **This Week** (Daily):
   - Morning: 10 min practice
   - Work: Use Neovim exclusively
   - Evening: Read next section in roadmap

4. **Bookmark This File**:
   ```bash
   nvim neovim/NEOVIM-MASTERY-ROADMAP.md
   ```
   Come back when you need direction.

---

## 📚 Quick File Reference

```
Foundation:
├── 01-getting-started.md         (Installation, modes)
├── 02-basic-motions.md          (Movement - COMPLETED)
└── text-manipulation.md         (Editing - READ NEXT)

Building Skills:
├── your-keybindings.md          (Your setup)
├── navigation.md                (Files, buffers, windows)
├── workflow.md                  (Real development)
├── lsp-usage.md                 (IDE features)
└── search-and-replace.md        (Find & replace)

Mastery:
├── advanced-techniques.md       (Macros, registers)
├── mistakes-to-avoid.md         (Common pitfalls)
└── modal-editing.md            (Philosophy)

Always Available:
├── cheatsheet.md               (Quick reference)
├── practice-exercises.md        (Daily drills)
├── learning-path.md            (Week-by-week plan)
└── NEOVIM-MASTERY-ROADMAP.md   (This file)
```

---

## 🚀 Remember

**Week 1-2**: You'll be slower than your old editor (the valley)
**Week 3**: You'll match your old speed
**Week 4+**: You'll be faster than ever before

**Every expert was once a beginner who didn't quit.**

You've got this! 💪

---

**Next Action**: Open `text-manipulation.md` and read the operators section (lines 5-119)

```bash
nvim neovim/text-manipulation.md
```
