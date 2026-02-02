# Navigation Mastery

Efficient navigation is the difference between a slow and fast Neovim experience. Master these patterns to move at thought speed.

## File-Level Navigation

### Within a File

#### Line Jumps

```vim
gg        " Top of file
G         " Bottom of file
50G       " Go to line 50
:50       " Also go to line 50 (command mode)
50%       " Go to 50% through file
```

#### Paragraph/Block Jumps

```vim
{         " Previous empty line (paragraph up)
}         " Next empty line (paragraph down)
[[        " Previous section/function
]]        " Next section/function
[{        " Jump to start of current block
]}        " Jump to end of current block
[m        " Previous method start
]m        " Next method start
```

#### Relative Jumps

With relative line numbers enabled (you have this):

```vim
5j        " Down 5 lines
12k       " Up 12 lines
```

**Pro Tip:** Look at the relative number, type it, then `j` or `k`. Don't count manually.

### Marks (Bookmarks)

Set marks to jump back to specific locations.

```vim
m{a-z}    " Set local mark (a-z) in current file
m{A-Z}    " Set global mark (A-Z) across files
'{mark}   " Jump to mark's line (start of line)
`{mark}   " Jump to mark's exact position
''        " Jump back to last jump
``        " Jump back to exact position before jump
`.        " Jump to last change position
`^        " Jump to last insert position
```

**Production Patterns:**

```vim
" Mark error location, explore, return
cursor on error line → mE → explore code → 'E → back to error

" Mark multiple locations in file
line 50 → mA → line 150 → mB → line 300 → mC
→ 'A → jump to line 50
→ 'B → jump to line 150
→ 'C → jump to line 300

" Return to last edit
make change → navigate elsewhere → `. → back to change

" Return to where you left insert mode
<Esc> from insert → navigate → `^ → back to insert location
```

**View all marks:**
```vim
:marks
```

### Jumplist (Browser-like Navigation)

Neovim tracks your jump history.

```vim
<C-o>     " Jump to older position (back)
<C-i>     " Jump to newer position (forward)
:jumps    " View jump list
```

**Usage Pattern:**

```vim
" You're at line 50
gd → jumps to line 200 (definition)
<C-o> → back to line 50
<C-i> → forward to line 200
```

**Pro Tip:** `gd` followed by `<C-o>` is your most common pattern with LSP.

### Changelist

Neovim tracks where you made changes.

```vim
g;        " Jump to previous change location
g,        " Jump to next change location
:changes  " View change list
```

**Usage:**

```vim
" Made change at line 10, then 50, then 100
g; → jump to line 50
g; → jump to line 10
g, → jump to line 50
```

---

## Search-Based Navigation

### Basic Search

```vim
/{pattern}      " Search forward
?{pattern}      " Search backward
n               " Next occurrence
N               " Previous occurrence
*               " Search word under cursor forward
#               " Search word under cursor backward
g*              " Like *, but partial matches
g#              " Like #, but partial matches
```

**Your Config:** `n` and `N` center the screen (better visibility)

**Production Patterns:**

```vim
" Jump to next function call
/functionName<CR>

" Find all TODO comments
/TODO<CR> → n → n → n

" Search word under cursor
cursor on variable → * → n → n

" Navigate to import statement
?import<CR>
```

### Search Current Line

```vim
f{char}   " Find next char on line
F{char}   " Find previous char on line
t{char}   " Till next char (one before)
T{char}   " Till previous char
;         " Repeat last f/F/t/T
,         " Repeat last f/F/t/T reverse
```

**Usage:**

```vim
" Line: const result = calculatePrice(100, 0.2);
cursor at start → f( → cursor on (
→ ; → cursor on ,
→ f) → cursor on )

" Line: const value = data.user.profile.name;
cursor at start → t; → cursor before ;
```

### Clear Search Highlighting

**Your keybinding:** `<Space>nh`

---

## Window Navigation

### Your Configured Keybindings

```vim
<C-h>     " Go to left window
<C-j>     " Go to lower window
<C-k>     " Go to upper window
<C-l>     " Go to right window
```

These work seamlessly with tmux (vim-tmux-navigator plugin).

### Window Commands (Alternative)

```vim
<C-w>h    " Left
<C-w>j    " Down
<C-w>k    " Up
<C-w>l    " Right
<C-w>w    " Cycle through windows
<C-w>p    " Previous window
<C-w>o    " Close all other windows (only current)
```

### Window Resizing

**Your keybindings:**

```vim
<C-Up>      " Increase height
<C-Down>    " Decrease height
<C-Left>    " Decrease width
<C-Right>   " Increase width
```

**Alternative commands:**

```vim
<C-w>=      " Equal size all windows
<C-w>_      " Maximize height
<C-w>|      " Maximize width
10<C-w>+    " Increase height by 10
10<C-w>-    " Decrease height by 10
```

---

## Buffer Navigation

Buffers are open files in memory.

### Native Commands

```vim
:bnext       " Next buffer (or :bn)
:bprevious   " Previous buffer (or :bp)
:bfirst      " First buffer
:blast       " Last buffer
:buffer {n}  " Go to buffer number n
:buffer {name} " Go to buffer by name (partial match)
:bd          " Delete buffer (close file)
:buffers     " List all buffers (or :ls)
```

### With Your Setup (Telescope)

**Your keybinding:** `<Space>fb` (Find buffers)

This is much faster than native commands.

**Usage:**

```vim
<Space>fb → type partial filename → <CR>
```

### Quick Switch Between Two Files

```vim
<C-^>     " Toggle between current and alternate buffer
```

**Most underused command!**

**Usage:**

```vim
Editing file1.ts
:e file2.ts
Working in file2.ts
<C-^> → back to file1.ts
<C-^> → back to file2.ts
```

---

## Tab Navigation

Tabs are collections of windows.

### Your Configured Keybindings

```vim
<Space>to   " Open new tab
<Space>tx   " Close current tab
<Space>tn   " Next tab
<Space>tp   " Previous tab
<Space>tf   " Open current buffer in new tab
```

### Native Commands

```vim
gt          " Next tab
gT          " Previous tab
{n}gt       " Go to tab number n (1gt, 2gt, etc.)
:tabnew     " New tab
:tabclose   " Close tab
:tabonly    " Close all other tabs
:tabs       " List tabs
```

**Production Pattern:**

```vim
" Separate workspace per feature
:tabnew src/feature1/  → work on feature 1
:tabnew src/feature2/  → work on feature 2
1gt → switch to feature 1 tab
2gt → switch to feature 2 tab
```

---

## Project-Wide Navigation (with Telescope)

### Your Configured Keybindings

```vim
<Space>ff   " Find files (fuzzy)
<Space>fr   " Recent files
<Space>fb   " Find buffers
<Space>fs   " Live grep (search in files)
<Space>fc   " Grep word under cursor
```

### Finding Files

**Pattern:**

```vim
<Space>ff → type partial name → <C-j>/<C-k> to navigate → <CR> to open
```

**Examples:**

```vim
" Find user_service.ts
<Space>ff → user_ser → <CR>

" Find any component
<Space>ff → component → navigate to desired → <CR>
```

### Searching Content

**Live grep:**

```vim
<Space>fs → type search term → see results → <CR> to open
```

**Grep word under cursor:**

```vim
cursor on function name → <Space>fc → see all usages
```

---

## LSP Navigation

### Your Configured Keybindings

```vim
gd          " Go to definition
gD          " Go to declaration
gR          " Show references (all usages)
gi          " Go to implementations
gt          " Go to type definition
K           " Hover documentation
```

### Production Workflow

```vim
" Understand function
cursor on function call → gd → read implementation → <C-o> → back

" Find all usages
cursor on variable → gR → see all references → select one

" Find interface implementations
cursor on interface → gi → see implementations

" Quick docs
cursor on function → K → read signature
```

### Diagnostics Navigation

**Your keybindings:**

```vim
]d          " Next diagnostic (error/warning)
[d          " Previous diagnostic
<Space>d    " Show diagnostic under cursor
<Space>D    " Show all diagnostics in buffer
```

**Workflow:**

```vim
Open file with errors
]d → jump to first error
<Space>d → read error message
<Space>ca → apply code action to fix
]d → next error
```

---

## File Explorer Navigation (nvim-tree)

### Your Keybindings

```vim
<Space>ee   " Toggle file explorer
<Space>ef   " Toggle on current file
<Space>ec   " Collapse all folders
<Space>er   " Refresh
```

### Inside nvim-tree

```vim
j/k         " Move down/up
<CR>        " Open file or toggle folder
o           " Open file
a           " Create file/folder (end with / for folder)
r           " Rename
d           " Delete
x           " Cut
c           " Copy
p           " Paste
y           " Copy filename
Y           " Copy relative path
gy          " Copy absolute path
/           " Search
?           " Show help
q           " Close explorer
```

**Production Pattern:**

```vim
<Space>ee → navigate to folder → <CR> → open file → <Space>ee → close
```

---

## Advanced Navigation Patterns

### Pattern 1: Quick File Switch (Two Files)

```vim
" Toggle between implementation and test
:e src/feature.ts
:e test/feature.test.ts
<C-^> → back to src/feature.ts
<C-^> → back to test/feature.test.ts
```

### Pattern 2: Mark-Based Workflow

```vim
" Working on feature across multiple files
file1.ts line 50 → mA
file2.ts line 100 → mB
file3.ts line 200 → mC

'A → jump to file1.ts line 50
'B → jump to file2.ts line 100
'C → jump to file3.ts line 200
```

### Pattern 3: Jump to Error, Fix, Repeat

```vim
]d → <Space>d → read error → <Space>ca → fix → ]d → repeat
```

### Pattern 4: Definition Deep Dive

```vim
cursor on function → gd → cursor on called function → gd → <C-o> → <C-o>
" Jump through call stack, then back out
```

### Pattern 5: Cross-File Refactor

```vim
<Space>fs → search for old pattern
<C-q> → send to quickfix
:cdo s/old/new/gc | update
" Replace across all matches
```

### Pattern 6: Navigate to Specific Line from Error

```vim
" Error says "line 247"
:247<CR> → jump directly
```

### Pattern 7: Search and Replace Across Results

```vim
<Space>fs → search term → <C-q> → send to quickfix list
:cfdo %s/old/new/g | w
```

---

## Quickfix and Location Lists

### Quickfix List (Project-Wide)

```vim
:copen      " Open quickfix window
:cclose     " Close quickfix window
:cn         " Next quickfix item
:cp         " Previous quickfix item
:cfirst     " First item
:clast      " Last item
:cdo {cmd}  " Run command on each item
```

**Populated by:**
- Telescope search results (use `<C-q>`)
- LSP diagnostics
- Grep results
- Compiler errors

### Location List (Window-Specific)

```vim
:lopen      " Open location list
:lclose     " Close location list
:ln         " Next item
:lp         " Previous item
:lfirst     " First item
:llast      " Last item
```

**Usage with Telescope:**

```vim
<Space>fs → search → <C-q> → sends to quickfix
:copen → see all matches
:cn → navigate through them
```

---

## File Path Commands

```vim
gf          " Go to file under cursor
<C-w>gf     " Go to file in new tab
<C-w>f      " Go to file in split
```

**Usage:**

```vim
" In import statement:
import { foo } from './utils/helper';
                     ^^^^^^^^^^^^^^
cursor on path → gf → opens file
```

---

## Navigation Efficiency Tips

1. **Use relative line numbers** (you have this) - Jump with `{count}j/k`
2. **Use `*` and `#`** - Search word under cursor instead of typing
3. **Use marks for long sessions** - Mark important locations
4. **Use `<C-o>` religiously** - After `gd`, always `<C-o>` back
5. **Telescope for everything** - `<Space>ff` is faster than manual navigation
6. **Use `<C-^>`** - Toggle between two files
7. **Use `{` and `}`** - Navigate by paragraphs, not lines
8. **Use `%`** - Jump between matching brackets
9. **Use `f` and `;`** - Navigate within line instead of `llll`
10. **Center on search** (you have this) - `n` centers screen automatically

---

## Common Navigation Mistakes

1. **Using `hjkl` for long distances** → Use `{`, `}`, `/`, `*`, `{count}j/k`
2. **Not using marks** → Set marks for important locations
3. **Not using jumplist** → `<C-o>` is your friend
4. **Manual file navigation** → Use Telescope `<Space>ff`
5. **Not using `<C-^>`** → Fastest way to toggle files
6. **Scrolling to find line** → Use `:{number}` or `{number}G`
7. **Not using Telescope grep** → `<Space>fs` is faster than manual search
8. **Ignoring quickfix list** → Use `<C-q>` in Telescope, then `:cn`/`:cp`

---

**Next**: Master [Search and Replace](search-and-replace.md) or practice these patterns in real code with [Your Keybindings](your-keybindings.md) reference open.
