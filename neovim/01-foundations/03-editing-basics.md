# Editing Basics: Your First Week of Real Editing

*Simple, focused guide to the core editing commands you'll use every day*

## What You'll Learn

After completing this guide, you'll be able to:
- Delete words, lines, and text sections efficiently
- Change (replace) text without multiple steps
- Copy and paste like a pro
- Understand and use text objects (the secret sauce!)
- Perform 90% of daily editing tasks

**Time to competence**: 3-5 days of practice

---

## The Three Core Operators

Neovim editing is built on **operators** + **motions**. Think of it like a sentence:
- **Operator** = verb (what to do)
- **Motion** = noun (what to do it to)

Example: `dw` = "delete word"
- `d` = delete (operator)
- `w` = word (motion)

### The Big Three Operators

1. **`d`** - Delete (cut)
2. **`c`** - Change (delete and enter insert mode)
3. **`y`** - Yank (copy)

---

## Operator 1: Delete (`d`)

### Basic Deletes

```vim
dw          " Delete from cursor to start of next word
d$          " Delete from cursor to end of line
dd          " Delete entire line
```

### Visual Guide

```
Before:  The |quick brown fox
dw:      The |brown fox         (deleted "quick ")
d$:      The |                  (deleted to end)
dd:      |                      (entire line gone)
```

### More Delete Patterns

```vim
d2w         " Delete next 2 words
d5j         " Delete current line + 5 lines down
dG          " Delete from cursor to end of file
dgg         " Delete from cursor to start of file
```

### Practice Exercise 1: Delete

Open a practice file and try:

```javascript
// Practice on this:
const userName = "John Doe";
const userEmail = "john@example.com";
const userAge = 30;
const userCountry = "USA";

// Try these:
// 1. Put cursor on "John", do: dw
// 2. Put cursor on start of line 2, do: dd
// 3. Put cursor anywhere on line 3, do: d$
// 4. Put cursor on "USA", do: dw
```

**Success Check**: Can you delete without thinking?

---

## Operator 2: Change (`c`)

**Change = Delete + Insert Mode**

This is the MOST used command in Neovim. Master it!

### Basic Changes

```vim
cw          " Change from cursor to end of word
c$          " Change from cursor to end of line
cc          " Change entire line (keeps indentation)
```

### Visual Guide

```
Before:  const oldName| = 10;
cw:      const | = 10;           (deleted "oldName", in insert mode)
         const newName| = 10;   (after typing "newName")
```

### The Magic: Text Objects

This is where Neovim gets REALLY powerful.

Instead of `cw`, use **text objects**:

```vim
ciw         " Change Inner Word (anywhere in word!)
ci"         " Change Inside quotes
ci(         " Change Inside parentheses
ci{         " Change Inside braces
ci[         " Change Inside brackets
```

### Why Text Objects Are Better

```javascript
// Traditional way (positioning matters):
const foo = "hello";
// Cursor must be at start of word for cw to work

// Text object way (position doesn't matter):
const foo = "hello";
// Cursor anywhere on "hello", use ci" - BOOM!
```

### Visual Comparison

```
Text: const userName = "J|ohn Doe";
      (cursor on 'o' in John)

cw:  Won't work as expected (only changes part of word)
ciw: Deletes entire "John" (but you're inside quotes... not what we want)
ci": Deletes "John Doe" and puts cursor inside quotes - PERFECT!
```

### Practice Exercise 2: Change

```javascript
// Practice on this:
const firstName = "Alice";
const lastName = "Smith";
function greet(name, age) {
    console.log("Hello");
    return true;
}

// Try these:
// 1. Cursor anywhere on "Alice", do: ci" → type "Bob"
// 2. Cursor anywhere on firstName, do: ciw → type "userName"
// 3. Cursor on "name, age", do: ci( → type "userName"
// 4. Cursor on "Hello", do: ci" → type "Goodbye"
```

**Success Check**: Can you change text without carefully positioning cursor?

---

## Operator 3: Yank (Copy) (`y`)

### Basic Yanks

```vim
yw          " Yank word
y$          " Yank to end of line
yy          " Yank entire line
```

### Paste

```vim
p           " Paste after cursor/below line
P           " Paste before cursor/above line
```

### Visual Guide

```
Before:  const name = "Alice";
         |const age = 30;

yy:      (copies "const age = 30;")
p:       const name = "Alice";
         const age = 30;
         const age = 30;|        (pasted below)
```

### Practice Exercise 3: Copy & Paste

```javascript
// Practice on this:
const x = 1;

// Try these:
// 1. Cursor on line 1, do: yy → move to line 2 → p (duplicate line)
// 2. Cursor on "const", do: yw → move anywhere → p
// 3. Cursor on "1", do: yiw → move anywhere → p
```

---

## Understanding Text Objects

**Text objects are the secret to Neovim mastery!**

### The Pattern: `[operator][i/a][object]`

- **operator**: `d`, `c`, `y`
- **i/a**:
  - `i` = "inner" (inside, excludes delimiters)
  - `a` = "around" (includes delimiters)
- **object**: `w`, `"`, `(`, `{`, `[`, `p`, etc.

### Inner (`i`) vs Around (`a`)

```javascript
// Example:
const message = "Hello World";

// Cursor anywhere on "Hello World"
ci":  "| "                    (change inside quotes)
ca":  const message = | ;     (change around quotes, includes quotes)

di":  "| "                    (delete inside, leaves quotes)
da":  const message = | ;     (delete around, removes quotes too)
```

### Common Text Objects

```vim
iw / aw     " word
i" / a"     " double quotes
i' / a'     " single quotes
i` / a`     " backticks
i( / a(     " parentheses (also ib / ab)
i{ / a{     " braces (also iB / aB)
i[ / a[     " brackets
it / at     " HTML/XML tags
ip / ap     " paragraph
```

### Real-World Examples

```javascript
// Example 1: Change function argument
function greet(userName) {
                ^cursor anywhere here
    ciw → type "user" → "user"
}

// Example 2: Change string content
const msg = "Hello";
             ^cursor anywhere in string
    ci" → type "Goodbye" → "Goodbye"

// Example 3: Delete function parameters
function calc(x, y, z) {
                  ^cursor anywhere in params
    di( → function calc() {
}

// Example 4: Change inside braces
if (true) { code here }
               ^cursor anywhere inside braces
    ci{ → type "new code" → { new code }
```

### Practice Exercise 4: Text Objects

```javascript
// Practice on this code:
const settings = {
    theme: "dark",
    fontSize: 16,
    autoSave: true
};

function processUser(userName, userAge, userEmail) {
    const greeting = "Hello, user!";
    console.log(greeting);
    return { success: true };
}

// Try these combinations:
// 1. Put cursor on "dark", do: ci" → change string
// 2. Put cursor on 16, do: ciw → change number
// 3. Put cursor on "userName", do: ciw → rename param
// 4. Put cursor inside (userName...), do: ci( → change all params
// 5. Put cursor inside { success: true }, do: ci{ → change object content
// 6. Put cursor on "Hello, user!", do: ci" → change string
```

**Success Check**: Can you use `ciw`, `ci"`, `ci(`, `ci{` without thinking?

---

## Practical Patterns for Daily Work

### Pattern 1: Rename Variable

```javascript
// Bad way:
const oldName = 10;
// Cursor to 'o', delete 7 characters, type "newName"

// Good way:
const oldName = 10;
// Cursor anywhere on "oldName", do: ciw → type "newName"
```

### Pattern 2: Change String Content

```javascript
// Bad way:
const msg = "Hello";
// Cursor to 'H', visual select, delete, type

// Good way:
const msg = "Hello";
// Cursor anywhere on "Hello", do: ci" → type "Goodbye"
```

### Pattern 3: Update Function Parameters

```javascript
// Bad way:
function greet(name, age) {
// Carefully select ", age" and delete

// Good way:
function greet(name, age) {
// Cursor anywhere inside (), do: ci( → type "user"
// Result: function greet(user) {
```

### Pattern 4: Duplicate Lines

```javascript
// Copy line and paste below
const x = 1;
// Do: yyp
// Result:
const x = 1;
const x = 1;
```

### Pattern 5: Swap Line Content

```javascript
const message = "old value";
const message = "new value";  // Want this content in line above

// On line 2, do: yy (yank)
// Go to line 1, do: dd (delete old line)
// Do: P (paste above)
```

---

## Combining with Motions You Know

Remember from `02-basic-motions.md`? Combine with operators!

### Motion + Operator Combos

```vim
" Delete motions
dt,         " Delete until comma
df.         " Delete until and including period
d}          " Delete until next paragraph
d%          " Delete to matching bracket

" Change motions
ct;         " Change until semicolon
cf)         " Change until and including )
c}          " Change until next paragraph

" Yank motions
yt,         " Yank until comma
y}          " Yank until next paragraph
```

### Practice Exercise 5: Combining

```javascript
// Practice on this:
const result = calculateTotal(price, quantity, tax);
console.log("Total: " + result);

// Try these:
// 1. Cursor on 'c' in calculateTotal, do: dt( → deletes until (
// 2. Cursor on 'p' in price, do: ct, → change until comma
// 3. Cursor on quote, do: dt" → delete until quote
```

---

## Common Beginner Mistakes

### Mistake 1: Using Visual Mode Unnecessarily

```vim
" Bad (too many steps):
v3wd    " Visual select 3 words, delete

" Good (direct):
d3w     " Delete 3 words
```

### Mistake 2: Not Using Text Objects

```vim
" Bad (position-dependent):
f"llllllld    " Find quote, move, delete

" Good (position-independent):
ci"           " Change inside quotes (works anywhere!)
```

### Mistake 3: Deleting in Insert Mode

```vim
" Bad (slow):
i → backspace backspace backspace...

" Good (fast):
<Esc> → db    " Exit insert, delete word back
```

### Mistake 4: Not Using Repeat (`.`)

```vim
" Bad (repetitive):
ciw newName <Esc> → /nextVar <CR> → ciw newName <Esc>

" Good (efficient):
ciw newName <Esc> → /nextVar <CR> → .
" The . repeats the entire "ciw newName" action!
```

### Mistake 5: Ignoring Undo

Always use `u` (undo) when you make a mistake. There's no penalty!

```vim
u           " Undo
<C-r>       " Redo
```

---

## Essential Shortcuts

### Insert Mode Shortcuts

```vim
i           " Insert before cursor
a           " Insert after cursor (append)
I           " Insert at start of line
A           " Insert at end of line
o           " Open new line below
O           " Open new line above
s           " Substitute character (delete char, enter insert)
S           " Substitute line (delete line, enter insert)
```

### Quick Changes

```vim
x           " Delete character under cursor
X           " Delete character before cursor
r{char}     " Replace single character
~           " Toggle case of character
```

### Visual Guide for Insert Shortcuts

```
Text:  The |quick brown fox

i:     Inserts here: The |quick...
a:     Inserts here: The q|uick...
I:     Inserts at start: |The quick...
A:     Inserts at end: The quick brown fox|
o:     Creates new line below and inserts
O:     Creates new line above and inserts
```

---

## Daily Practice Drills

### Drill 1: Change Words (5 minutes)

```javascript
const apple = 1;
const banana = 2;
const cherry = 3;
const date = 4;
const elderberry = 5;

// Do these:
// 1. Change "apple" to "orange" using ciw
// 2. Change "banana" to "grape" using ciw
// 3. Change all number values to 99 using ciw
// 4. Change "elderberry" to "fig" using ciw
```

### Drill 2: Change Strings (5 minutes)

```javascript
const firstName = "Alice";
const lastName = "Smith";
const email = "alice@example.com";
const city = "New York";

// Do these:
// 1. Change "Alice" to "Bob" using ci"
// 2. Change "Smith" to "Johnson" using ci"
// 3. Change the email using ci"
// 4. Change "New York" to "Los Angeles" using ci"
```

### Drill 3: Change Parameters (5 minutes)

```javascript
function add(x, y) { return x + y; }
function multiply(a, b) { return a * b; }
function greet(name, age) { return "Hello"; }
function calculate(price, quantity, tax) { return 0; }

// Do these:
// 1. In add(), use ci( to change params to (num1, num2)
// 2. In multiply(), use ci( to change params to (value1, value2)
// 3. In greet(), use ci( to change params to (user)
// 4. In calculate(), use ci( to change params to (total)
```

### Drill 4: Delete Lines (3 minutes)

```javascript
const line1 = 1;
const line2 = 2;
const line3 = 3;
const line4 = 4;
const line5 = 5;
const line6 = 6;
const line7 = 7;
const line8 = 8;

// Do these:
// 1. Delete line2 using dd
// 2. Delete line4 using dd
// 3. Delete line6 using dd
// 4. Delete from line7 to end using dG
```

### Drill 5: Copy & Paste (3 minutes)

```javascript
const template = "COPY ME";

// Do these:
// 1. Use yy to copy the line
// 2. Paste it 5 times below using p
// 3. Copy just the word "COPY" using yiw
// 4. Paste it elsewhere using p
```

---

## Speed Test: Can You Do This in 2 Minutes?

```javascript
// Starting code:
const userName = "oldName";
const userEmail = "old@example.com";
const userAge = 25;

function greetUser(name, email) {
    console.log("Hello");
    return true;
}

// Tasks:
// 1. Change "oldName" to "Alice"
// 2. Change "old@example.com" to "alice@example.com"
// 3. Change 25 to 30
// 4. Change greetUser to welcomeUser
// 5. Change parameters (name, email) to (user)
// 6. Change "Hello" to "Welcome"
// 7. Duplicate the entire function (copy and paste)

// Expected result:
const userName = "Alice";
const userEmail = "alice@example.com";
const userAge = 30;

function welcomeUser(user) {
    console.log("Welcome");
    return true;
}

function welcomeUser(user) {
    console.log("Welcome");
    return true;
}
```

**Commands used**:
1. `ci"` → type "Alice"
2. `ci"` → type "alice@example.com"
3. `ciw` → type "30"
4. `ciw` → type "welcomeUser"
5. `ci(` → type "user"
6. `ci"` → type "Welcome"
7. `V` + `6j` + `y` + `p` (or just select function and yank/paste)

---

## Completion Checklist

Before moving to the next file, you should be able to:

- [ ] Delete words with `dw` automatically
- [ ] Delete lines with `dd` without thinking
- [ ] Change words with `ciw` from any cursor position
- [ ] Change text inside quotes with `ci"`
- [ ] Change text inside parentheses with `ci(`
- [ ] Understand "inner" (`i`) vs "around" (`a`)
- [ ] Copy lines with `yy` and paste with `p`
- [ ] Use `.` to repeat your last change
- [ ] Use `u` to undo mistakes confidently
- [ ] Prefer text objects over motion commands

---

## What's Next?

You now have the core editing foundation!

**Next steps**:
1. Practice these commands daily for 3-5 days
2. Use them in real code (force yourself!)
3. When comfortable, move to: `navigation.md` or `your-keybindings.md`

**Keep this file as reference** - come back when you forget a command.

---

## Quick Reference Card

```
# The Essentials (memorize these first)
ciw        Change word (MOST USED)
ci"        Change inside quotes
ci(        Change inside parentheses
dd         Delete line
yy         Copy line
p          Paste
u          Undo
.          Repeat last change

# The Pattern
[operator][i/a][object]
c = change, d = delete, y = yank
i = inner, a = around
w = word, " = quotes, ( = parens, { = braces

# Insert Shortcuts
i          Insert mode
a          Append after cursor
I          Insert at line start
A          Append to line end
o          Open line below
O          Open line above
```

**Print this section and keep it visible!**

---

**[← Previous: Basic Motions](02-basic-motions.md) | [Next: Navigation →](navigation.md)**

Practice makes permanent. Use these commands every day! 🚀
