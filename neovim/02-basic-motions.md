# Basic Motions: Moving Around Efficiently

*Learn to navigate text without touching the mouse or arrow keys*

## What You'll Learn

By the end of this guide (30-45 min), you'll:
- ✅ Move with `hjkl` (basic movement)
- ✅ Jump by words with `w`, `b`, `e`
- ✅ Navigate lines with `0`, `^`, `$`
- ✅ Jump paragraphs with `{` and `}`
- ✅ Search within a line with `f` and `t`
- ✅ Feel comfortable without arrow keys

---

## Why Not Use Arrow Keys?

### The Problem with Arrow Keys

```
Your keyboard:
┌─────┬─────┬─────┬─────┐
│  7  │  8  │  9  │  0  │
├─────┼─────┼─────┼─────┤
│  U  │  I  │  O  │  P  │  ← Home row (where hands rest)
├─────┼─────┼─────┼─────┤
│  J  │  K  │  L  │  ;  │
└─────┴─────┴─────┴─────┘
                                    Arrow keys
                                     ┌────┐
                                     │ ↑  │
                                ┌────┼────┼────┐
                                │ ←  │ ↓  │ →  │
                                └────┴────┴────┘
                                   Way over here!
```

**Problem:** Your hand has to leave the home row, travel to arrows, then come back. Slow!

**Solution:** Use `hjkl` - your fingers never leave home row.

---

## The `hjkl` Foundation

### Basic Movement (Character by Character)

```
         k
         ↑
    h ←     → l
         ↓
         j
```

**Mnemonic:**
- `h` = **left** (h is on the left)
- `j` = **down** (j points down)
- `k` = **up** (k points up)
- `l` = **right** (l is on the right)

### Visual Example

```
Starting position:

The |quick brown fox
     ↑
   cursor here

Press l:  The q|uick brown fox
Press l:  The qu|ick brown fox
Press h:  The q|uick brown fox
Press j:  (moves to line below)
Press k:  (moves back up)
```

### Practice Exercise 1.1 (5 min)

Open a file:
```bash
nvim practice-motions.txt
```

Type this text (press `i` first):
```
Line 1: The quick brown fox
Line 2: jumps over the lazy dog
Line 3: Pack my box with five dozen liquor jugs
Line 4: The five boxing wizards jump quickly
```

Press `<Esc>` to exit insert mode.

**Now practice:**
1. Put cursor on 'T' in Line 1
2. Press `l` 5 times → cursor moves right 5 characters
3. Press `h` 3 times → cursor moves left 3 characters
4. Press `j` → cursor moves to Line 2
5. Press `k` → cursor moves back to Line 1
6. Press `j` 3 times → cursor at Line 4
7. Press `k` 2 times → cursor at Line 2

**Goal:** Get comfortable with `hjkl` before moving on.

---

## Word Motions (The Game Changer)

Character-by-character is slow. Let's move by words!

### The Big Three: `w`, `b`, `e`

```
w = word forward (to start of next word)
b = back (to start of previous word)
e = end (to end of current/next word)
```

### Visual Example: `w` (Forward by Word)

```
Start:    The |quick brown fox jumps
             ↑

Press w:  The quick |brown fox jumps
                    ↑

Press w:  The quick brown |fox jumps
                          ↑

Press w:  The quick brown fox |jumps
                              ↑
```

### Visual Example: `b` (Back by Word)

```
Start:    The quick brown |fox jumps
                          ↑

Press b:  The quick |brown fox jumps
                    ↑

Press b:  The |quick brown fox jumps
              ↑

Press b:  |The quick brown fox jumps
          ↑
```

### Visual Example: `e` (End of Word)

```
Start:    The |quick brown fox
              ↑

Press e:  The quic|k brown fox
                 ↑ (end of "quick")

Press e:  The quick brow|n fox
                       ↑ (end of "brown")

Press e:  The quick brown fo|x
                           ↑ (end of "fox")
```

### Practice Exercise 1.2 (5 min)

Using your practice file:

**Exercise: Navigate with `w`**
1. Cursor at start of Line 1
2. Press `w` → cursor on "quick"
3. Press `w` → cursor on "brown"
4. Press `w` → cursor on "fox"
5. Repeat until you can do this without thinking

**Exercise: Navigate with `b`**
1. Cursor at end of Line 1
2. Press `b` → cursor moves back one word
3. Keep pressing `b` until you reach the start
4. Notice how it's the opposite of `w`

**Exercise: Find the end with `e`**
1. Cursor at start of Line 2
2. Press `e` → cursor at end of first word
3. Press `e` → cursor at end of second word
4. Practice until natural

---

## Line Motions

Moving within a single line.

### The Line Family: `0`, `^`, `$`

```
0 = start of line (column 0)
^ = first non-blank character
$ = end of line
```

### Visual Example

```
Line with spaces:   ___The quick brown fox
                    ↑  ↑                  ↑
                    0  ^                  $
                    │  │                  │
                    │  first character    end
                    column 0
```

### Detailed Visual

```
Text:     "    The quick brown fox"
           ↑   ↑                  ↑
           0   ^                  $

Press 0:  cursor → column 0 (even if blank)
Press ^:  cursor → 'T' (first non-blank)
Press $:  cursor → 'x' (end of line)
```

### Practice Exercise 1.3 (5 min)

In your practice file:

```
    Line with leading spaces
```

**Exercise:**
1. Cursor anywhere on the line
2. Press `0` → cursor jumps to start (column 0)
3. Press `$` → cursor jumps to end
4. Press `^` → cursor jumps to 'L' (first character)
5. Repeat 10 times until muscle memory forms

**Pro Tip:** `^` is more useful than `0` because you usually want the first character, not blank space.

---

## Combining Motions with Counts

This is where power appears!

### Syntax: `{count}{motion}`

```
3w  = move forward 3 words
5j  = move down 5 lines
2b  = move back 2 words
4l  = move right 4 characters
```

### Visual Example: `3w`

```
Start:    The |quick brown fox jumps over
              ↑

Press 3w: The quick brown fox |jumps over
                              ↑
          (jumped 3 words in one command!)
```

### Visual Example: `5j` (With Relative Line Numbers)

Your config has relative line numbers. They look like this:

```
  5  Line above 5
  4  Line above 4
  3  Line above 3
  2  Line above 2
  1  Line above 1
 10  Current line (cursor here) ← absolute line number
  1  Line below 1
  2  Line below 2
  3  Line below 3
  4  Line below 4
  5  Line below 5
```

**To jump down 5 lines:** Just look at the number (5), type `5j`

```
Before:
  5  Line above 5
  4  Line above 4
  3  Line above 3
  2  Line above 2
  1  Line above 1
 10  Current line |← cursor
  1  Line below 1
  2  Line below 2
  3  Line below 3
  4  Line below 4
  5  Line below 5

Press 5j:

After:
 10  Line above 5
  9  Line above 4
  8  Line above 3
  7  Line above 2
  6  Line above 1
  5  Line that was "Current line"
  4  Line below 1
  3  Line below 2
  2  Line below 3
  1  Line below 4
 15  Line below 5 |← cursor here
```

### Practice Exercise 1.4 (5 min)

**Exercise: Word Jumps**

Add this text to your practice file:
```
The quick brown fox jumps over the lazy dog near the riverbank
```

1. Cursor at start
2. Press `3w` → jumped 3 words
3. Press `2w` → jumped 2 more words
4. Press `4b` → jumped back 4 words
5. Press `10w` → jumped to end

**Exercise: Line Jumps**

1. Cursor at line 1
2. Look at relative number of line 3 (should show "3")
3. Press `3j` → jumped to line 3
4. Press `2k` → jumped up 2 lines

---

## Paragraph Motions

### The Paragraph Family: `{` and `}`

```
{  = jump to previous empty line (paragraph up)
}  = jump to next empty line (paragraph down)
```

### Visual Example

```
┌─────────────────────────────────────┐
│ First paragraph                     │
│ with multiple lines                 │
│ of text here.                       │ ← Cursor here
├─────────────────────────────────────┤ ← Empty line
│ Second paragraph                    │
│ also has multiple                   │
│ lines of text.                      │
├─────────────────────────────────────┤ ← Empty line
│ Third paragraph                     │
│ is down here.                       │
└─────────────────────────────────────┘

Press }:  Cursor jumps to empty line between paragraphs
Press }:  Cursor jumps to next empty line
Press {:  Cursor jumps back up
```

### Practice Exercise 1.5 (5 min)

Create this in your practice file:

```
Paragraph one.
Multiple lines here.
Still part of paragraph one.

Paragraph two starts here.
After an empty line.
Multiple lines too.

Paragraph three.
At the bottom.
```

**Exercise:**
1. Cursor at top
2. Press `}` → jumps to first empty line
3. Press `}` → jumps to second empty line
4. Press `{` → jumps back up
5. Press `{` → jumps back to top

---

## Search Within Line: `f` and `t`

Super powerful for quick horizontal movement!

### The Find Family: `f`, `F`, `t`, `T`

```
f{char}  = find next {char} on line (forward)
F{char}  = find previous {char} on line (backward)
t{char}  = till next {char} (one before)
T{char}  = till previous {char} (one before)
;        = repeat last find
,        = repeat last find (opposite direction)
```

### Visual Example: `f`

```
Text:     The quick brown fox jumps

Cursor:   The |quick brown fox jumps
              ↑

Press fo: The quick brown f|ox jumps
                          ↑
          (found 'o' in "fox")

Press ;:  The quick brown fox jumps
                            ↑
          (found next 'o' - none exists, so end)
```

### Visual Example: `t` (Till)

```
Text:     const result = calculatePrice(100, 0.2);

Cursor:   const |result = calculatePrice(100, 0.2);
                ↑

Press t(: const result = calculatePrice|(100, 0.2);
                                       ↑
          (till the '(' - stopped one before)
```

### Visual Example: Repeating with `;` and `,`

```
Text:     The quick brown fox jumps over the lazy dog

Cursor:   The |quick brown fox jumps over the lazy dog
              ↑

Press fo: The quick br|own fox jumps over the lazy dog
                      ↑ (found 'o' in "brown")

Press ;:  The quick brown f|ox jumps over the lazy dog
                           ↑ (next 'o')

Press ;:  The quick brown fox jumps |over the lazy dog
                                    ↑ (next 'o')

Press ,:  The quick brown f|ox jumps over the lazy dog
                           ↑ (previous 'o' - reversed direction)
```

### Practice Exercise 1.6 (5 min)

Add this code to your practice file:

```javascript
const user = getUserData();
const token = user.token;
const profile = user.profile.name;
```

**Exercise: Find characters**
1. Line 1, cursor at start
2. Press `f=` → cursor on '='
3. Press `;` → cursor on next '('
4. Press `fe` → cursor on first 'e'
5. Press `;` → cursor on next 'e'

**Exercise: Till characters**
1. Line 2, cursor at start
2. Press `t=` → cursor one before '='
3. Line 3, press `t.` → cursor one before first '.'
4. Press `;` → cursor one before second '.'

---

## Jump to Top/Bottom

### File Navigation: `gg` and `G`

```
gg   = go to top of file
G    = go to bottom of file
{n}G = go to line {n}
```

### Visual Example

```
File content:
     1  Line 1
     2  Line 2
     3  Line 3          ← Cursor here
     ...
   100  Line 100

Press gg:  Cursor → Line 1 (top)
Press G:   Cursor → Line 100 (bottom)
Press 50G: Cursor → Line 50
```

### Practice Exercise 1.7 (5 min)

1. Cursor anywhere
2. Press `gg` → jump to top
3. Press `G` → jump to bottom
4. Press `gg` → back to top
5. Press `10G` → jump to line 10
6. Press `1G` → jump to line 1 (same as `gg`)

---

## Scrolling (Keep Cursor in View)

### Scroll Commands: `<C-d>`, `<C-u>`, `<C-f>`, `<C-b>`

```
<C-d>  = scroll down half page (cursor centered - your config!)
<C-u>  = scroll up half page (cursor centered)
<C-f>  = scroll down full page
<C-b>  = scroll back full page
zz     = center current line on screen
```

**Your config bonus:** `<C-d>` and `<C-u>` center the cursor - easier on eyes!

### Visual Example

```
Screen before <C-d>:
┌────────────────────┐
│ Line 1             │ ← Top of screen
│ Line 2             │
│ Line 3 |← cursor   │
│ Line 4             │
│ Line 5             │
└────────────────────┘

After <C-d> (scroll down):
┌────────────────────┐
│ Line 4             │
│ Line 5             │
│ Line 6 |← cursor   │ ← Centered!
│ Line 7             │
│ Line 8             │
└────────────────────┘
```

---

## Summary: Your Motion Toolkit

### Character Movement (Slow)
```
h j k l    ← Use sparingly
```

### Word Movement (Better)
```
w b e      ← Use these more
```

### Line Movement (Fast)
```
0 ^ $      ← Jump to start/end
```

### Paragraph Movement (Faster)
```
{ }        ← Jump between blocks
```

### Find on Line (Super Fast)
```
f{char}    ← Find character
t{char}    ← Till character
; ,        ← Repeat find
```

### File Navigation (Fastest)
```
gg G       ← Top/bottom
{n}G       ← Specific line
```

---

## Practice Drills (15 min)

### Drill 1: Word Navigation Speed Test

Text:
```
The quick brown fox jumps over the lazy dog
```

**Task:** Start at 'T', get to 'dog' using only `w`

1. Try with `w` (press it 8 times)
2. Now try with `8w` (one command!)

Which is faster? Counts!

### Drill 2: Line Mastery

Text:
```
    const result = calculatePrice(amount, discount);
```

**Task:**
1. Start anywhere
2. Press `^` → jump to 'c'
3. Press `$` → jump to ';'
4. Press `0` → jump to start (blank space)
5. Repeat 5 times

### Drill 3: Find Character Challenge

Text:
```
import { useState, useEffect } from 'react';
```

**Task:**
1. Cursor at start
2. Press `f{` → jump to '{'
3. Press `fe` → find first 'e'
4. Press `;` → find next 'e'
5. Press `;` → find next 'e'
6. Press `,` → go back one 'e'

### Drill 4: No Arrow Keys Challenge

**Task:** Edit your practice file for 10 minutes using ONLY:
- `hjkl` for small movements
- `w` `b` `e` for word jumps
- `0` `^` `$` for line jumps
- `f` `t` for finding characters

**NO ARROW KEYS ALLOWED!**

If you catch yourself reaching for arrows, start over.

---

## Visual Cheat Sheet

```
┌─────────────────────────────────────────────────────────┐
│  MOTION QUICK REFERENCE                                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Character:    h j k l                                  │
│  Word:         w (forward) b (back) e (end)             │
│  Line:         0 (start) ^ (first char) $ (end)         │
│  Paragraph:    { (up) } (down)                          │
│  Find:         f{char} t{char} ; (repeat) , (reverse)   │
│  File:         gg (top) G (bottom) {n}G (line n)        │
│  Scroll:       <C-d> (down) <C-u> (up)                  │
│                                                         │
│  With Counts:  3w (3 words) 5j (5 lines down)           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

Print this and keep it visible!

---

## Progress Check

Test yourself:

- [ ] Can you navigate with `hjkl` without looking?
- [ ] Can you jump words with `w` and `b`?
- [ ] Can you jump to line start/end with `^` and `$`?
- [ ] Can you find characters with `f` and `t`?
- [ ] Can you use counts like `3w` or `5j`?
- [ ] Have you disabled arrow keys (or can avoid them)?

If you checked 4+, you're ready for the next lesson!

---

## Tips for Success

1. **Disable arrow keys temporarily** - Force yourself to learn
   ```vim
   " Add to config (temporary)
   noremap <Up> <Nop>
   noremap <Down> <Nop>
   noremap <Left> <Nop>
   noremap <Right> <Nop>
   ```

2. **Think in movements, not characters** - Don't count characters, use motions

3. **Use relative line numbers** - You have these! Look, type number, press `j` or `k`

4. **Practice with real code** - Open your projects and navigate

5. **Speed comes with time** - You'll be slow for a week, fast forever after

---

## Next Steps

You can now move around! But we're still not editing efficiently.

**[Next: Editing Basics →](03-editing-basics.md)**

You'll learn:
- Deleting text with `d`
- Changing text with `c`
- Copying and pasting with `y` and `p`
- Combining motions with operators (the magic!)

**Estimated time:** 30 minutes

---

**[← Previous: Getting Started](01-getting-started.md) | [Next: Editing Basics →](03-editing-basics.md)**

---

## Homework

Before moving on:

1. **Practice motions for 20 minutes** - Use real code files
2. **Disable arrow keys** - Force yourself
3. **Master one motion** - Pick `w` or `f{char}`, use it all day
4. **Watch your efficiency improve** - You'll be slower at first, then faster than ever

Remember: Every Neovim expert struggled with `hjkl` at first. Push through! 💪
