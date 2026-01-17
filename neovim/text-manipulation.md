# Text Manipulation Mastery

Deep dive into editing text efficiently. This is where Neovim's composability shines.

## Operators in Detail

### Delete (`d`)

```vim
dw        " Delete word
dW        " Delete WORD (whitespace-delimited)
d$        " Delete to end of line
d^        " Delete to first non-blank character
dd        " Delete entire line
dG        " Delete from cursor to end of file
dgg       " Delete from cursor to start of file
d}        " Delete to next paragraph
d%        " Delete to matching bracket/paren
dt;       " Delete until semicolon (exclusive)
df;       " Delete until and including semicolon (inclusive)
d/foo     " Delete until next occurrence of "foo"
```

**Production Patterns:**
```vim
" Delete function arguments
cursor in foo(bar, baz) → di( → foo()

" Delete HTML tag contents
cursor in <div>content</div> → dit → <div></div>

" Delete line but keep indent
cursor anywhere → S (technically c_)

" Delete to end of sentence
dt.

" Delete everything in current block
daB  or  da{
```

### Change (`c`)

Change is delete + insert mode. Same motions as delete.

```vim
cw        " Change word (enter insert mode)
ci"       " Change inside quotes
ca(       " Change around parentheses
ct:       " Change until colon
cc        " Change entire line (keeps indent)
C         " Change from cursor to end of line (same as c$)
c3w       " Change next 3 words
c/foo     " Change until next "foo"
```

**Production Patterns:**
```vim
" Rename variable
cursor on variable → ciw → type new name

" Change function name
cursor on function → cw → type new name

" Replace string contents
cursor inside "hello" → ci" → type new string

" Fix parameter
cursor in function(oldParam) → ciw → newParam

" Change HTML tag
cursor in <div> → cit → new content

" Rewrite from here to end of line
C → type new text

" Change case
cursor on camelCase → gUiw → CAMELCASE
cursor on CONSTANT → guiw → constant
cursor on Test → g~iw → tEST (toggle)
```

### Yank (`y`)

Copy operation.

```vim
yw        " Yank word
yy        " Yank line (same as Y)
y$        " Yank to end of line
yi"       " Yank inside quotes
ya{       " Yank around braces (includes braces)
y3j       " Yank current line + 3 down
y}        " Yank to next paragraph
y%        " Yank to matching bracket
```

**Production Patterns:**
```vim
" Copy entire function
anywhere in function → yaf (with treesitter)
or → V]m → y (visual select to end of function)

" Copy URL
cursor in "https://..." → yi" → clipboard has URL

" Copy function call with args
cursor on function(...) → ya) → clipboard has entire call

" Duplicate line
yy → p  (or use yyp)

" Copy paragraph
yap

" Copy to system clipboard (if configured with "+ register)
"+yy  → line to system clipboard
"+yiw → word to system clipboard
```

### Indent (`<` and `>`)

```vim
>>        " Indent line right
<<        " Indent line left
>%        " Indent to matching bracket
>ap       " Indent paragraph
3>>       " Indent current + next 2 lines
>G        " Indent to end of file
```

**Production Patterns:**
```vim
" Indent entire function
cursor in function → >aB

" Indent visual selection
V → select lines → >  (then . to repeat)

" Fix indentation of entire file
gg=G  (go to top, auto-indent to bottom)

" Indent code block
cursor in { } → >i{

" Indent selected lines precisely
:.,+5>  (indent current line + 5 lines down)
```

### Auto-Indent (`=`)

Intelligently re-indent code based on syntax.

```vim
==        " Auto-indent current line
=ap       " Auto-indent paragraph
=%        " Auto-indent to matching bracket
gg=G      " Auto-indent entire file
=i{       " Auto-indent inside braces
```

**Production Patterns:**
```vim
" Fix indentation after paste
p → =ap  (paste, then auto-indent)

" Fix entire file indentation
gg=G

" Fix function indentation
=af  (with treesitter)

" Fix selected lines
V → select → =
```

### Visual Mode Operators

Visual mode for irregular selections.

```vim
v         " Character-wise visual
V         " Line-wise visual
<C-v>     " Block-wise visual (column mode)

" Then apply operator
d, c, y, >, <, =, gU, gu, g~
```

**Production Patterns:**

**Block Visual (Column Editing):**
```vim
" Add comment to multiple lines
<C-v> → select column → I// → <Esc>

" Delete column
<C-v> → select → d

" Change column
<C-v> → select → c → type → <Esc>

" Example: Add semicolons to end of multiple lines
<C-v> → select end of lines → $ → A; → <Esc>
```

**Line Visual:**
```vim
" Delete multiple lines
V → select lines → d

" Move lines (with visual-move plugin or native)
V → select → :m'>+1 → <CR>

" Sort lines
V → select → :sort

" Comment out block
V → select → gc (with commentary plugin)
```

## Text Objects Deep Dive

### Word Objects

```vim
iw        " Inside word (word characters only)
aw        " Around word (includes trailing space)
iW        " Inside WORD (includes punctuation)
aW        " Around WORD
```

**Examples:**
```vim
" cursor on 'hello' in: 'hello world'
diw → ' world'     (delete word, keep quotes)
daw → 'world'      (delete word and space)

" cursor on 'foo-bar' in: 'foo-bar baz'
diw → 'foo-bar baz'  (iw stops at -)
diW → ' baz'         (iW treats foo-bar as one WORD)
```

### Quote Objects

```vim
i"        " Inside double quotes
a"        " Around double quotes (includes quotes)
i'        " Inside single quotes
a'        " Around single quotes
i`        " Inside backticks
a`        " Around backticks
```

**Production Patterns:**
```vim
" Change string contents
cursor in "hello" → ci" → world → "world"

" Delete string completely
cursor in "hello" → da" → (nothing)

" Copy string without quotes
cursor in "hello" → yi" → clipboard: hello

" Copy string with quotes
cursor in "hello" → ya" → clipboard: "hello"

" Change single to double quotes
cursor in 'hello' → di' → <Esc> → hda' → i"<C-r>0" → <Esc>
" (or use surround plugin: cs'")
```

### Bracket/Paren Objects

```vim
i(        " Inside parentheses (also ib)
a(        " Around parentheses (also ab)
i{        " Inside braces (also iB)
a{        " Around braces (also aB)
i[        " Inside brackets
a[        " Around brackets
i<        " Inside angle brackets
a<        " Around angle brackets
```

**Production Patterns:**
```vim
" Delete function arguments
cursor in foo(bar, baz) → di( → foo()

" Change entire function call
cursor in foo(bar) → ca( → foo(newArg)

" Yank function body
cursor in function { code } → yi{ → clipboard: code

" Delete entire code block
cursor in if { block } → da{ → (block removed)

" Indent function body
cursor in function { } → >i{

" Navigate to matching brace
%  (jump between opening and closing)
```

### Sentence and Paragraph Objects

```vim
is        " Inside sentence
as        " Around sentence
ip        " Inside paragraph
ap        " Around paragraph
```

**Production Patterns:**
```vim
" Delete paragraph
dap

" Yank paragraph
yap

" Indent paragraph
>ap

" Select paragraph for editing
vip → edit

" Change sentence
cas
```

### Tag Objects (HTML/XML)

```vim
it        " Inside tag
at        " Around tag (includes tags)
```

**Production Patterns:**
```vim
" cursor in <div>content</div>
dit → <div></div>
dat → (tag removed completely)
cit → change content → <div>new</div>
yat → clipboard: <div>content</div>

" Works with nested tags
<div><span>text</span></div>
cursor on 'text' → dit → <span></span>
cursor on 'text' → dat → <div></div> (removes span entirely)
```

### Treesitter Text Objects (Modern)

With `nvim-treesitter-textobjects`:

```vim
af        " Around function
if        " Inside function
ac        " Around class
ic        " Inside class
aa        " Around argument/parameter
ia        " Inside argument/parameter
ab        " Around block
ib        " Inside block
```

**Production Patterns:**
```vim
" Delete entire function
daf

" Yank function body
yif

" Change function argument
cursor on argument → cia

" Indent entire class
>ac

" Select next function argument
via → n (select first arg, next arg)
```

## Multi-Line Editing

### Join Lines (`J`)

```vim
J         " Join current line with next (adds space)
gJ        " Join without adding space
3J        " Join current + next 2 lines
```

**Production Patterns:**
```vim
" Collapse multi-line to single line
const foo = {
  bar: 1,
  baz: 2
}

cursor on first { → vi{ → J
→ const foo = { bar: 1, baz: 2 }

" Remove line breaks in text
V → select lines → J
```

### Line Operations

```vim
o         " Open new line below, enter insert
O         " Open new line above, enter insert
dd        " Delete line
yy        " Yank line
cc        " Change line
>>        " Indent line
<<        " Unindent line
==        " Auto-indent line
```

**Production Patterns:**
```vim
" Duplicate line
yyp

" Move line down (native)
ddp

" Move line up (native)
ddkP

" Swap lines
ddp (down) or ddkP (up)

" Delete 5 lines
5dd

" Copy 3 lines
3yy
```

## Advanced Editing Patterns

### Changing Case

```vim
gU{motion}  " Uppercase
gu{motion}  " Lowercase
g~{motion}  " Toggle case

gUw         " Uppercase word
guu         " Lowercase line
gUU         " Uppercase line
g~iw        " Toggle case of word
```

**Production Patterns:**
```vim
" Uppercase constant
cursor on variable → gUiw → VARIABLE

" Lowercase screaming variable
cursor on SCREAMING → guiw → screaming

" Fix camelCase to snake_case (with plugin or manual)
cursor on camelCase → manual edit or macro
```

### Incrementing/Decrementing Numbers

```vim
<C-a>     " Increment number under cursor
<C-x>     " Decrement number under cursor
```

**Production Patterns:**
```vim
" Change port 3000 to 3001
cursor on 3000 → <C-a> → 3001

" Create sequence
1
yy 9p (yank, paste 9 times)
→
1
1
1
...
V → select all → g<C-a> (increment in sequence)
→
1
2
3
...

" Bulk update version numbers
:%s/v1.0.\zs\d\+/\=submatch(0)+1/g
" (regex way to increment all version numbers)
```

### Swap Characters/Words

```vim
xp        " Swap two characters
dwwP      " Swap two words
ddp       " Swap two lines
```

### Repeat Last Change (`.`)

```vim
.         " Repeat last change
```

**Production Patterns:**
```vim
" Add semicolons to multiple lines
A;<Esc> → j → . → j → .

" Delete word multiple times
dw → w → . → w → .

" Comment multiple lines (with commentary plugin)
gcc → j → . → j → .

" Chain with search
/pattern<CR> → cw new <Esc> → n → . → n → .
```

## Formatting and Whitespace

### Trim Trailing Whitespace

```vim
:%s/\s\+$//e
" % = entire file
" \s\+ = one or more whitespace
" $ = end of line
" e = suppress errors
```

### Convert Tabs to Spaces

```vim
:set expandtab
:retab
```

### Fix Mixed Line Endings

```vim
:e ++ff=unix
:w
```

### Format Text to Width

```vim
gq{motion}  " Format text to textwidth
gqap        " Format paragraph
gqG         " Format to end of file
```

## Real-World Refactoring Patterns

### Pattern 1: Wrap in Function

```vim
" Before:
const x = 1;
const y = 2;
const z = x + y;

" Select lines
Vjj

" Indent
>

" Add function wrapper
O function calculate() { <Esc>
}o} <Esc>

" After:
function calculate() {
  const x = 1;
  const y = 2;
  const z = x + y;
}
```

### Pattern 2: Extract Variable

```vim
" Before:
return user.profile.settings.theme;

" Yank expression
cursor on user → yt;

" Insert variable above
O const theme = <C-r>0; <Esc>

" Replace with variable
cursor on user → ct; theme <Esc>

" After:
const theme = user.profile.settings.theme;
return theme;
```

### Pattern 3: Inline Variable

```vim
" Before:
const name = user.name;
return name;

" Yank value
cursor on user → y$

" Delete variable line
dd

" Paste value
cursor on name → ciw <C-r>0 <Esc>

" After:
return user.name;
```

### Pattern 4: Convert Array to Object

```vim
" Before:
['a', 'b', 'c']

" Select contents
vi[

" Substitute
:s/'\(\w\+\)'/\1: '\1'/g

" After:
[a: 'a', b: 'b', c: 'c']
```

## Common Editing Mistakes

1. **Using `x` repeatedly instead of `dw`**
   - Bad: `xxxxx`
   - Good: `dw`

2. **Visual mode for simple changes**
   - Bad: `viwc`
   - Good: `ciw`

3. **Not using `.` for repetition**
   - Bad: `dw w dw w dw`
   - Good: `dw w . w .`

4. **Staying in insert mode to delete**
   - Bad: `backspace backspace backspace...`
   - Good: `<Esc> db`

5. **Not using text objects**
   - Bad: `f(lllllllld`
   - Good: `di(`

---

**Next**: Learn [Navigation](navigation.md) for moving around projects, or [Search and Replace](search-and-replace.md) for bulk changes.
