# Neovim Production Cheatsheet

Quick reference for real-world development. Keep this open while coding.

---

## Essential Motions

### Horizontal

```
h, l         left, right (use sparingly)
w            next word start
b            previous word start
e            next word end
0            start of line
^            first non-blank
$            end of line
f{char}      find next char
F{char}      find prev char
t{char}      till next char
T{char}      till prev char
;            repeat f/F/t/T
,            repeat reverse
```

### Vertical

```
j, k         down, up (use sparingly)
{            prev paragraph
}            next paragraph
gg           top of file
G            bottom of file
{n}G         line n
<C-d>        half page down (centered in your config)
<C-u>        half page up (centered in your config)
<C-f>        full page down
<C-b>        full page up
%            matching bracket
```

### Search

```
/{pattern}   search forward
?{pattern}   search backward
*            search word under cursor
#            search word backward
n            next match (centered in your config)
N            prev match (centered in your config)
<Space>nh    clear highlights (your binding)
```

---

## Operators

```
d            delete
c            change (delete + insert)
y            yank (copy)
>            indent right
<            indent left
=            auto-indent
gu           lowercase
gU           uppercase
g~           toggle case
```

### Operator + Motion

```
dw           delete word
d$           delete to end of line
dd           delete line
cw           change word
cc           change line
yy           yank line
>>           indent line
==           auto-indent line
```

---

## Text Objects

**Format:** `[operator][i/a][object]`

```
iw, aw       word
iW, aW       WORD
is, as       sentence
ip, ap       paragraph
i", a"       double quotes
i', a'       single quotes
i`, a`       backticks
i(, a(       parentheses (also ib, ab)
i{, a{       braces (also iB, aB)
i[, a[       brackets
i<, a<       angle brackets
it, at       HTML/XML tags
```

### With Treesitter (if configured)

```
af, if       function
ac, ic       class
aa, ia       argument
ab, ib       block
```

### Examples

```
ciw          change word
di"          delete inside quotes
da(          delete parentheses and contents
yap          yank paragraph
>i{          indent inside braces
=aB          auto-indent block
```

---

## Your Essential Keybindings

### Insert Mode

```
jk           exit insert mode (your binding)
<C-w>        delete word backward
<C-u>        delete to line start
<C-o>        one normal command
<C-r>"       paste from register
```

### Normal Mode Essentials

```
<C-s>        save file (your binding)
<Space>q     quit
<Space>Q     quit all without saving
<C-a>        select all (your binding)
<Space>+     increment number (your binding)
<Space>-     decrement number (your binding)
<Space>nh    clear search highlights
```

### File Navigation (Telescope)

```
<Space>ff    find files ⭐
<Space>fr    recent files
<Space>fs    live grep (search in files) ⭐
<Space>fc    grep word under cursor
<Space>fb    find buffers
<Space>fh    help tags
```

### File Explorer (nvim-tree)

```
<Space>ee    toggle file explorer ⭐
<Space>ef    toggle on current file
<Space>ec    collapse explorer
<Space>er    refresh explorer
```

### Window Management

```
<Space>sv    split vertically
<Space>sh    split horizontally
<Space>se    equal splits
<Space>sx    close split

<C-h>        left window ⭐
<C-j>        down window ⭐
<C-k>        up window ⭐
<C-l>        right window ⭐

<C-Up>       increase height
<C-Down>     decrease height
<C-Left>     decrease width
<C-Right>    increase width
```

### Tab Management

```
<Space>to    new tab
<Space>tx    close tab
<Space>tn    next tab
<Space>tp    previous tab
<Space>tf    current buffer in new tab
```

### LSP

```
gd           go to definition ⭐
gD           go to declaration
gR           show references ⭐
gi           implementations
gt           type definition
K            hover docs ⭐
<Space>ca    code actions ⭐
<Space>rn    rename ⭐
<Space>d     line diagnostic
<Space>D     buffer diagnostics
]d           next diagnostic ⭐
[d           prev diagnostic ⭐
<Space>rs    restart LSP
```

### Visual Mode

```
<            indent left (reselects)
>            indent right (reselects)
J            move text down (your binding)
K            move text up (your binding)
<Space>p     paste without yanking
```

### Registers/Clipboard

```
<Space>d     delete to void (doesn't affect clipboard)
<Space>p     paste without yanking (visual mode)
```

---

## Core Commands

### Files

```
:w           write (save)
:x           write if changed, quit (better than :wq)
:q           quit
:q!          quit without saving
:wa          write all buffers
:qa          quit all
:e {file}    edit file
:saveas {f}  save as
```

### Buffers

```
:bn          next buffer
:bp          previous buffer
:bd          delete buffer
:buffers     list buffers
<C-^>        alternate buffer (toggle two files)
```

### Windows

```
<C-w>s       split horizontal
<C-w>v       split vertical
<C-w>c       close window
<C-w>o       close all other windows
<C-w>=       equal size
```

### Search/Replace

```
:%s/old/new/g        replace all in file
:%s/old/new/gc       replace with confirm
:'<,'>s/old/new/g    replace in visual selection
:g/pattern/d         delete lines matching
:g!/pattern/d        delete lines NOT matching
:v/pattern/d         delete lines NOT matching
```

---

## Advanced Techniques

### Macros

```
q{a-z}       start recording
q            stop recording
@{a-z}       replay macro
@@           replay last macro
{n}@{a-z}    replay n times
```

### Registers

```
"{a-z}y      yank to named register
"{a-z}p      paste from named register
"{A-Z}y      append to register
"0p          paste last yank
"1p          paste last delete
"+y          yank to system clipboard
"+p          paste from system clipboard
"_d          delete to black hole
:registers   view all registers
```

### Marks

```
m{a-z}       set local mark
m{A-Z}       set global mark
'{mark}      jump to mark line
`{mark}      jump to mark position
''           jump back
`.           last change
`^           last insert
:marks       view marks
```

### Folds

```
zf{motion}   create fold
zd           delete fold
zo           open fold
zc           close fold
za           toggle fold
zR           open all folds
zM           close all folds
```

### Visual Block

```
<C-v>        enter block visual
I            insert before block
A            append after block
c            change block
d            delete block
g<C-a>       increment numbers in sequence
```

---

## Scenario-Based Quick Reference

### Opening Project

```
cd ~/project
nvim .
<Space>ff → find main file
```

### Find & Edit

```
<Space>ff → file name → <CR>
or
<Space>fs → search term → <CR>
```

### Jump to Definition & Back

```
cursor on symbol → gd → <C-o>
```

### Rename Variable

```
cursor on variable → <Space>rn → new name → <CR>
```

### Fix Errors

```
]d → <Space>d → <Space>ca → select fix → ]d → repeat
```

### Multi-file Search & Replace

```
<Space>fs → pattern → <C-q> → :cfdo %s/old/new/g | update
```

### Refactor with Macro

```
qa → refactor steps → q
→ @a on next item
→ @@ to repeat
```

### Compare Two Files

```
<Space>sv → <Space>ff → select file → <C-h>/<C-l> to switch
```

### Delete Lines Matching Pattern

```
:g/pattern/d
```

### Format File

```
gg=G
or
:lua vim.lsp.buf.format()
```

---

## Quick Wins

### Top 10 Commands (Memorize)

```
1.  <Space>ff      find files
2.  <Space>fs      search in files
3.  gd             go to definition
4.  <C-o>          jump back
5.  <Space>ca      code actions
6.  ciw            change word
7.  di"            delete inside quotes
8.  .              repeat last change
9.  <C-d>/<C-u>    scroll (centered)
10. *              search word under cursor
```

### Top 10 Combos

```
1.  daw            delete word with space
2.  ci"            change inside quotes
3.  yap            yank paragraph
4.  >ap            indent paragraph
5.  =i{            auto-indent block
6.  dt,            delete until comma
7.  gUiw           uppercase word
8.  f( → ci(       find paren, change inside
9.  3w → ciw       3 words, change word
10. /search → cw   search, change word
```

### Common Patterns

```
# Duplicate line
yyp

# Swap lines
ddp (down) or ddkP (up)

# Move to end of line and append
A

# Insert at start of line
I

# Open line below/above
o / O

# Change from cursor to end
C

# Delete from cursor to end
D

# Center screen on cursor
zz
```

---

## Regex Cheatsheet

### Basics

```
.          any character
^          start of line
$          end of line
\<  \>     word boundaries
\s  \S     whitespace / non-whitespace
\d  \D     digit / non-digit
\w  \W     word char / non-word
*          0 or more
\+         1 or more
\?         0 or 1
\{n,m}     n to m times
[abc]      any of a, b, c
[^abc]     not a, b, c
\|         OR
\( \)      group (capture with \1, \2)
```

### Very Magic Mode (`\v`)

```
/\v(foo|bar)              match foo or bar
/\vfunction\s+\w+         function declarations
/\v\w+@\w+\.\w+           email addresses
/\vhttps?://\S+           URLs
:%s/\v(\w+) (\w+)/\2 \1/  swap words
```

---

## LSP Quick Commands

```
:LspInfo          check LSP status
:LspRestart       restart LSP
:Mason            manage language servers
:checkhealth lsp  diagnose issues
```

---

## Emergency Commands

```
u               undo
<C-r>           redo
:e!             reload file (discard changes)
:earlier 5m     undo last 5 minutes
:qa!            quit all without saving
:recover        recover crashed file
```

---

## Performance Tips

```
:syntax off                  disable syntax (large files)
:set noswapfile              disable swap
:set lazyredraw              faster macros
:Lazy profile                check plugin load times
```

---

## Help System

```
:help {topic}            search help
:help motion.txt         motion help
:help operator           operator help
:help text-objects       text objects
:help lsp                LSP help
:help :substitute        substitute help
:Telescope keymaps       view all keymaps
```

---

## Print This Section

**The Absolute Essentials (if you only remember 20 things):**

```
1.  <Space>ff         find files
2.  <Space>fs         search content
3.  gd                go to definition
4.  <C-o>             jump back
5.  ciw               change word
6.  di"               delete in quotes
7.  <Space>ca         code actions
8.  <Space>rn         rename
9.  ]d / [d           next/prev error
10. .                 repeat change
11. jk                exit insert
12. <C-s>             save
13. f{char}           find char
14. *                 search word
15. %                 matching bracket
16. yap               yank paragraph
17. >ap               indent paragraph
18. <C-h/j/k/l>       navigate windows
19. <C-^>             toggle files
20. :x                save and quit
```

---

**Keep this file open in a split while coding!**

```
<Space>sv → open cheatsheet in split → <C-h>/<C-l> to reference
```
