# Neovim Practice Exercises

*Hands-on drills to build muscle memory - Do these daily!*

## How to Use This File

1. **Do one section per day** (15-30 minutes)
2. **Repeat until automatic** - Your fingers should move without thinking
3. **Track your progress** - Check off completed exercises
4. **Practice on real code** - Apply what you learn immediately

---

## Week 1: Fundamentals

### Day 1: Modes and Insert

**Setup:**
```bash
nvim practice-day1.txt
```

**Exercise 1.1: Mode Switching (5 min)**

1. Open Neovim (you're in normal mode)
2. Press `i` → type "Hello" → press `<Esc>` (or `jk`)
3. Repeat 10 times until automatic
4. Try `a` → type "World" → `<Esc>`
5. Try `o` → type "New line" → `<Esc>`
6. Try `O` → type "Line above" → `<Esc>`

**Goal:** Enter/exit insert mode without thinking.

**Exercise 1.2: Save and Quit Variations (5 min)**

Create some text, then practice:

1. `:w` → (save) → make change → `:q!` → (quit without saving)
2. Reopen → make change → `:wq` → (save and quit)
3. Reopen → make change → `:x` → (save if changed, quit)
4. Reopen → `:q` → (quit, see error if unsaved)
5. `:q!` → (force quit)

Repeat until you know which command to use when.

**Exercise 1.3: Real File Practice (10 min)**

Open a real code file from your projects:

```bash
cd ~/your-project
nvim src/index.js  # or any file
```

Tasks:
1. Navigate to a function
2. Press `o` → add a comment → `<Esc>` → `:w`
3. Press `A` → add semicolon → `<Esc>` → `:w`
4. Press `I` → add space at start → `<Esc>` → `:w`
5. Exit with `:q`

**Progress Check:**
- [ ] Can enter insert mode with `i`, `a`, `o`, `O` without thinking
- [ ] Can exit insert mode with `jk` automatically
- [ ] Know when to use `:w`, `:q`, `:wq`, `:x`, `:q!`

---

### Day 2: Basic Motions `hjkl`

**Setup:**
```bash
echo "The quick brown fox jumps over the lazy dog" > practice-day2.txt
echo "Pack my box with five dozen liquor jugs" >> practice-day2.txt
echo "How vexingly quick daft zebras jump" >> practice-day2.txt
nvim practice-day2.txt
```

**Exercise 2.1: Character Movement (10 min)**

1. Cursor at start of line 1
2. Press `l` 10 times (move right)
3. Press `h` 5 times (move left)
4. Press `j` (move down)
5. Press `k` (move up)

**Challenge:** Navigate to each word's first letter using only `hjkl` - No arrow keys!

**Exercise 2.2: Line Navigation (10 min)**

For each line:
1. Press `0` → (start of line)
2. Press `$` → (end of line)
3. Press `^` → (first character)
4. Repeat 5 times per line

**Exercise 2.3: Disable Arrow Keys (Ongoing)**

Add to your practice:
```vim
" Temporarily disable arrows to build muscle memory
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
```

Practice navigating your practice file for 10 minutes.

**Progress Check:**
- [ ] Can navigate with `hjkl` without thinking about it
- [ ] Fingers automatically use `h/j/k/l` instead of arrows
- [ ] Can jump to line start/end with `0`, `^`, `$`

---

### Day 3: Word Motions

**Setup:**
```bash
cat << 'EOF' > practice-day3.txt
The quick brown fox jumps over the lazy dog
JavaScript is a programming language
const result = calculateTotal(price, quantity)
function getUserData(userId, includeProfile)
EOF
nvim practice-day3.txt
```

**Exercise 3.1: Forward Word Motion (10 min)**

Line 1, cursor at start:
1. Press `w` → (next word)
2. Count how many `w` presses to reach "dog"
3. Now try `8w` → (8 words forward in one command!)
4. Go back to start: press `b` 8 times or `8b`

**Exercise 3.2: Word Motion Combinations (10 min)**

Practice these patterns on each line:

```
Pattern 1: Start → 3w → 2b → 4w → $
Pattern 2: Start → e → e → e → 0
Pattern 3: $ → 4b → 5w → ^
```

Repeat until you can do them without thinking.

**Exercise 3.3: Real Code Navigation (15 min)**

Open a JavaScript/Python file:

Tasks:
1. Navigate to function name using `w`/`b`
2. Jump to end of function name with `e`
3. Jump to start of line with `^`
4. Jump to end with `$`

Do this for 10 different lines.

**Progress Check:**
- [ ] Can navigate by words faster than by characters
- [ ] Understand when to use `w`, `b`, or `e`
- [ ] Can use counts with motions (`3w`, `5b`)

---

### Day 4: Find and Till

**Setup:**
```bash
cat << 'EOF' > practice-day4.txt
const user = getUserData();
const profile = user.profile.settings.theme;
const result = calculatePrice(100, 0.2);
import { useState, useEffect } from 'react';
EOF
nvim practice-day4.txt
```

**Exercise 4.1: Find Character `f` (10 min)**

Line 1:
1. Cursor at start
2. Press `fu` → (find 'u')
3. Press `;` → (next 'u')
4. Press `;` → (next 'u')
5. Press `,` → (previous 'u')

Repeat for each line with different characters.

**Exercise 4.2: Till Character `t` (10 min)**

Line 3:
1. Cursor at start
2. Press `t(` → (till opening paren)
3. Press `t,` → (till comma)
4. Press `t)` → (till closing paren)

**Exercise 4.3: Speed Challenge (10 min)**

For each line, get to these positions as fast as possible:

Line 1: Get to '=' using `f=`
Line 2: Get to second '.' using `f.` then `;`
Line 3: Get to '(' using `t(`
Line 4: Get to '{' using `f{`

Time yourself. Try to beat your time.

**Progress Check:**
- [ ] Can find characters with `f` without thinking
- [ ] Can repeat finds with `;` and `,`
- [ ] Understand difference between `f` and `t`

---

### Day 5-7: Combination Practice

**Setup: Create Real File**
```bash
cat << 'EOF' > practice-week1-final.js
function calculateDiscount(price, percentage) {
  const discount = price * (percentage / 100);
  const finalPrice = price - discount;
  return finalPrice;
}

const userCart = {
  items: ['apple', 'banana', 'cherry'],
  total: 42.50,
  discount: 10
};

function processPayment(amount, method) {
  if (method === 'credit') {
    return chargeCreditCard(amount);
  } else if (method === 'debit') {
    return chargeDebitCard(amount);
  }
  return false;
}
EOF
nvim practice-week1-final.js
```

**Exercise 5.1: Navigate Function (15 min)**

Tasks:
1. Get to 'calculateDiscount' using `gg` + `w`
2. Get to 'percentage' using `f%` (or `fp` then `w`)
3. Jump to line 2 using `2j` or `2G`
4. Get to '=' on line 2 using `f=`
5. Jump to end of function using `}` or `/return` then `<Enter>`

**Exercise 5.2: Navigate Object (10 min)**

Go to userCart object:
1. Jump to line 7: Press `7G`
2. Navigate to 'items' using word motions
3. Jump between quotes using `f'` and `;`
4. Get to closing '}' using `%` (on opening brace)

**Exercise 5.3: Speed Run (20 min)**

**Challenge:** Navigate through entire file using only:
- `w`, `b`, `e` (word motions)
- `f`, `t` (find/till)
- `0`, `^`, `$` (line motions)
- `{`, `}` (paragraph motions)
- `gg`, `G` (file top/bottom)

**NO `hjkl` or arrows allowed!** (Except small adjustments)

Time yourself. Repeat until you're twice as fast.

**Progress Check:**
- [ ] Can navigate entire files without mouse
- [ ] Use motions without conscious thought
- [ ] Faster than using arrow keys
- [ ] Ready for editing commands

---

## Week 2: Editing Basics

### Day 8: Delete Operations

**Setup:**
```bash
cat << 'EOF' > practice-day8.txt
The quick brown fox jumps over the lazy dog
Remove this entire line please
This sentence has extra      spaces
Delete me
function oldFunction() { console.log('delete this'); }
EOF
nvim practice-day8.txt
```

**Exercise 8.1: Delete Commands (15 min)**

Practice each on different lines:

```
dw    - delete word (cursor to end of word)
db    - delete back (start of word to cursor)
dd    - delete entire line
d$    - delete to end of line
d^    - delete to start of line
d3w   - delete 3 words
d2j   - delete current line + 2 below
```

**Task List:**
1. Line 1: Delete "quick" → cursor on 'q' → `dw`
2. Line 2: Delete entire line → `dd`
3. Line 3: Delete "extra      spaces" → cursor on 'e' → `d$`
4. Line 4: Delete line → `dd`
5. Line 5: Delete "oldFunction" → cursor on 'o' → `dw`

**Exercise 8.2: Delete with Find (10 min)**

```
dt{char}  - delete till character
df{char}  - delete find character (inclusive)
```

Line: `const result = calculatePrice(100, 0.2);`

Tasks:
1. Cursor at start → `dt=` → deletes "const result "
2. Undo with `u` → cursor at start → `df=` → deletes "const result ="
3. `dt(` → deletes till opening paren
4. `dt)` → deletes till closing paren

**Exercise 8.3: Real Code Deletion (15 min)**

Open a code file. Practice:
1. Delete function names with `dw`
2. Delete parameters with `dt,` or `dt)`
3. Delete comments with `dd`
4. Delete to end of lines with `d$`

Undo with `u` after each!

**Progress Check:**
- [ ] Can delete words with `dw` without thinking
- [ ] Can delete lines with `dd`
- [ ] Can delete to specific characters with `dt`
- [ ] Understand undo with `u`

---

### Day 9: Change Operations

**Setup:**
```bash
cat << 'EOF' > practice-day9.txt
old_variable_name
const oldValue = 42;
function incorrectName() {}
let wrong = "fix this string";
const user = getOldUserData();
EOF
nvim practice-day9.txt
```

**Exercise 9.1: Change Commands (15 min)**

```
cw    - change word (delete word + enter insert)
cc    - change entire line
c$    - change to end of line (also C)
ciw   - change inner word (whole word)
ct{char} - change till character
```

**Tasks:**
1. Line 1: Change "old" to "new" → cursor on 'o' → `cw` → type "new" → `<Esc>`
2. Line 2: Change "oldValue" to "newValue" → cursor on 'o' → `ciw` → type "newValue" → `<Esc>`
3. Line 3: Change "incorrectName" to "correctName" → `ciw`
4. Line 4: Change string → cursor on "fix" → `ct"` → type "correct string" → `<Esc>`
5. Line 5: Change "getOldUserData" to "getNewUserData" → `ciw`

**Exercise 9.2: Change with Motions (10 min)**

Practice these patterns:

```
c3w   - change 3 words
c$    - change to end of line
ci"   - change inside quotes
ci(   - change inside parentheses
ct;   - change till semicolon
```

Create practice text with quotes, parentheses, semicolons and practice each.

**Exercise 9.3: Refactoring Practice (15 min)**

Open a real code file:

1. Find a variable name → change it with `ciw`
2. Find a string → change contents with `ci"`
3. Find a function parameter → change with `ciw`
4. Find a function call → change function name with `cw`

**Progress Check:**
- [ ] Can change words with `cw` or `ciw`
- [ ] Understand difference between `cw` and `ciw`
- [ ] Can change inside quotes/parentheses with `ci"` and `ci(`
- [ ] Prefer `c` over delete-then-insert

---

### Day 10: Copy and Paste

**Setup:**
```bash
cat << 'EOF' > practice-day10.txt
Copy this line
Duplicate me
const important = 'save this';
function example() {
  return true;
}
EOF
nvim practice-day10.txt
```

**Exercise 10.1: Yank and Put (15 min)**

```
yy    - yank (copy) line
yw    - yank word
y$    - yank to end of line
p     - put (paste) after cursor
P     - put before cursor
```

**Tasks:**
1. Line 1: Yank line → `yy` → move down → `p` (paste)
2. Line 2: Yank "Duplicate" → `yw` → move to end → `p`
3. Line 3: Yank "'save this'" → `yi'` → move somewhere → `p`
4. Lines 4-6: Yank entire function → `y}` or `3yy` → paste with `p`

**Exercise 10.2: Multiple Copies (10 min)**

```
Pattern: Yank once, paste many times

yy   - yank line
p    - paste
p    - paste again
p    - paste again (it's still in register!)
```

Task: Copy a line 5 times using `yy` then `5p`

**Exercise 10.3: Duplicate Lines (10 min)**

The classic duplicate line pattern:

```
yyp   - yank line, paste below (duplicate)
```

Practice:
1. Any line → `yyp` → line duplicated
2. Repeat on different lines
3. Try `3yyp` → duplicates 3 lines

**Exercise 10.4: Code Duplication Practice (15 min)**

Open real code:

1. Duplicate a variable declaration → `yyp`
2. Copy a function signature → `yy` then paste in new location
3. Copy an import statement → `yyp`
4. Copy a code block → `y}` then paste

**Progress Check:**
- [ ] Can copy lines with `yy`
- [ ] Can paste with `p` and `P`
- [ ] Can duplicate lines with `yyp` without thinking
- [ ] Can copy code blocks with `y}` or visual mode

---

### Day 11-14: Combination Mastery

**Exercise 11.1: Text Objects Introduction (20 min)**

```bash
cat << 'EOF' > practice-text-objects.txt
"hello world"
'single quotes'
(inside parentheses)
{inside braces}
function test() { return "value"; }
<div>HTML content</div>
EOF
nvim practice-text-objects.txt
```

**Text Objects to Practice:**

```
iw, aw   - inner word, around word
i", a"   - inside quotes, around quotes
i', a'   - inside single quotes, around single quotes
i(, a(   - inside parens, around parens
i{, a{   - inside braces, around braces
it, at   - inside tag, around tag
```

**Tasks:**
1. Line 1: `di"` → deletes "hello world"
2. Undo with `u`
3. Line 1: `ci"` → changes to new text
4. Line 3: `di(` → deletes content inside parens
5. Line 5: `di{` → deletes function body
6. Line 6: `dit` → deletes HTML content

**Exercise 11.2: Real-World Refactoring (30 min)**

Create this file:
```javascript
function calculateTotal(items) {
  const subtotal = items.reduce((sum, item) => sum + item.price, 0);
  const tax = subtotal * 0.08;
  const total = subtotal + tax;
  return { subtotal, tax, total };
}

const order = {
  id: "12345",
  user: "john@example.com",
  items: [
    { name: "Widget", price: 10.00 },
    { name: "Gadget", price: 25.50 }
  ]
};
```

**Refactoring Tasks:**
1. Change "calculateTotal" to "computeTotal" → `ciw`
2. Change "items" to "products" throughout → `ciw` + manual or search/replace
3. Change 0.08 to 0.10 → `cw`
4. Change email → `ci"`
5. Change "Widget" → `ci"`
6. Delete entire object → `da{`

**Exercise 11.3: Speed Challenge (20 min)**

**Task:** Make these changes as fast as possible:

1. Delete word → `dw`
2. Change inside quotes → `ci"`
3. Duplicate line → `yyp`
4. Delete line → `dd`
5. Change function name → `ciw`
6. Jump to end and append → `A`

Time yourself. Repeat until 2x faster.

**Progress Check:**
- [ ] Can use text objects (`iw`, `i"`, `i(`) automatically
- [ ] Combine operators with motions without thinking
- [ ] Faster at editing than your old editor
- [ ] Muscle memory is forming

---

## Week 3: Real Workflows

### Day 15: LSP Practice

**Setup:** Open a real project with LSP configured

**Exercise 15.1: Navigation (15 min)**

1. Open a file with multiple functions
2. Place cursor on function name → `gd` (go to definition)
3. Press `<C-o>` (jump back)
4. Place cursor on variable → `gR` (find references)
5. Navigate results → `<C-j>`/`<C-k>` → `<Enter>` to select

**Exercise 15.2: Code Actions (15 min)**

1. Find an unimported function
2. Cursor on it → `<Space>ca` (code actions)
3. Select "Add import"
4. Find a warning/error → `]d` (next diagnostic)
5. `<Space>ca` → apply fix

**Exercise 15.3: Refactoring (20 min)**

1. Pick a variable to rename
2. Cursor on variable → `<Space>rn` (rename)
3. Type new name → `<Enter>`
4. Verify all references updated

Repeat with:
- Function names
- Class names
- Parameters

**Progress Check:**
- [ ] Can navigate with LSP (`gd`, `gR`)
- [ ] Can use code actions (`<Space>ca`)
- [ ] Can rename safely (`<Space>rn`)
- [ ] Understand LSP workflow

---

### Day 16-21: Daily Practice Routine

**Morning Drill (5 min):**
```bash
nvim practice-morning.txt
```

1. Navigate entire file using only motions (no `hjkl`)
2. Delete 5 words with `dw` / `ciw`
3. Duplicate 3 lines with `yyp`
4. Change 5 strings with `ci"`
5. Jump to 5 locations with `f{char}`

**Lunchtime Drill (5 min):**

Open any code file:
1. Find a function → `gd` → `<C-o>`
2. Find references → `gR`
3. Rename something → `<Space>rn`
4. Fix an error → `]d` → `<Space>ca`

**Evening Review (10 min):**

Answer these:
1. What was the hardest motion today?
2. What did you use most?
3. What did you avoid (and should practice more)?
4. Are you faster than yesterday?

---

## Week 4: Mastery Drills

### Macro Practice

**Exercise:** Automate repetitive edits

Setup:
```javascript
name
email
phone
address
city
```

**Task:** Convert to:
```javascript
const name = '';
const email = '';
const phone = '';
const address = '';
const city = '';
```

**Using Macros:**
1. Cursor on first line
2. `qa` (start recording macro 'a')
3. `I` → type "const " → `<Esc>`
4. `A` → type " = '';" → `<Esc>`
5. `j` (move to next line)
6. `q` (stop recording)
7. `4@a` (replay macro 4 times)

**Progress Check:**
- [ ] Can record macros
- [ ] Understand when macros are useful
- [ ] Can repeat macros with counts

---

## Daily Muscle Memory Checklist

Print and check off daily:

### Morning Warm-Up (5 min)
- [ ] `hjkl` navigation
- [ ] Word motions (`w`, `b`, `e`)
- [ ] Line motions (`0`, `^`, `$`)
- [ ] Find (`f`, `t`)

### Main Practice (20 min)
- [ ] Delete operations (`dw`, `dd`, `dt`)
- [ ] Change operations (`cw`, `ciw`, `ci"`)
- [ ] Copy/paste (`yy`, `p`, `yyp`)
- [ ] Text objects (`iw`, `i"`, `i(`)

### Real Work (All Day)
- [ ] Used Neovim for all coding
- [ ] Avoided mouse/arrows
- [ ] Used LSP features (`gd`, `<Space>ca`, `<Space>rn`)
- [ ] Felt faster than yesterday

---

## Speed Tests

### Test 1: Navigation Speed

**File:** Any code file with 100+ lines

**Task:** Jump to these as fast as possible
1. Line 50 → `50G`
2. Top of file → `gg`
3. Bottom → `G`
4. Back to line 25 → `25G`
5. Find "function" → `/function<Enter>`

**Goal:** Under 10 seconds

### Test 2: Editing Speed

**Task:** Make these edits in 30 seconds
1. Delete 3 words
2. Change a string
3. Duplicate 2 lines
4. Delete a line
5. Change a function name

**Goal:** All edits in under 30 seconds

### Test 3: Real Refactoring

**Task:** Refactor this code:
```javascript
const old_name = getOldData();
const old_result = processOld(old_name);
```

To:
```javascript
const newName = getNewData();
const newResult = processNew(newName);
```

**Goal:** Complete refactor in under 1 minute

---

## Monthly Review

At the end of each month, test yourself:

1. **Speed Test:** Are you faster than Week 1?
2. **Comfort Test:** Do motions feel natural?
3. **Real Work Test:** Do you prefer Neovim to old editor?
4. **Teaching Test:** Could you teach someone these basics?

If yes to 3+, you're on track to mastery! 🎉

---

## Continue Practicing

- Use Neovim for all work
- Review [Cheatsheet](cheatsheet.md) daily
- Study [Mistakes to Avoid](mistakes-to-avoid.md) weekly
- Push yourself to learn one new technique per week

**Remember:** Mastery is a journey, not a destination. Keep practicing! 💪

---

**[← Back to README](README.md)**
