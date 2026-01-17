# Advanced Techniques

Power-user patterns for maximum efficiency. These techniques separate proficient users from masters.

## Macros

Macros record a sequence of commands for replay. Essential for repetitive refactoring.

### Basic Macro Usage

```vim
q{register}   " Start recording to register (a-z)
... commands ...
q             " Stop recording
@{register}   " Replay macro
@@            " Replay last macro
{count}@{register}  " Replay macro count times
```

### Production Patterns

#### Pattern 1: Add Semicolons to Multiple Lines

```vim
" Before:
const a = 1
const b = 2
const c = 3

" Record:
qa          " Start recording to register 'a'
A;          " Append semicolon
<Esc>       " Back to normal
j           " Move down
q           " Stop recording

" Replay:
@@          " Repeat once (or @a)
@@          " Repeat again
" Or: 2@a  " Repeat 2 times
```

#### Pattern 2: Format Object Properties

```vim
" Before:
name: "John"
age: 30
city: "NYC"

" Task: Add quotes around keys
" Record:
qa
^           " Start of line
i"<Esc>     " Insert quote
f:          " Find colon
i"<Esc>     " Insert quote
j           " Next line
q

" Replay:
2@a

" After:
"name": "John"
"age": 30
"city": "NYC"
```

#### Pattern 3: Convert Array Items to Object

```vim
" Before:
users
posts
comments

" Task: Convert to: const USERS = 'users';
" Record:
qa
Iconst <Esc>    " Insert 'const '
gUiw            " Uppercase word
A = '<Esc>      " Add = '
ea';<Esc>       " Add ';
j
q

" Replay: 2@a
```

#### Pattern 4: Refactor Function Calls

```vim
" Before:
getData(param1, param2)
setData(param1, param2)
updateData(param1, param2)

" Task: Add 'await' and chain .then()
" Record:
qa
^               " Start of line
iawait <Esc>    " Add await
A.then(res => res.json())<Esc>
j
q

" Replay: 2@a
```

### Complex Macro Example

```vim
" Convert CSV to JSON
" Before:
John,30,Developer
Jane,25,Designer
Bob,35,Manager

" Task: Convert to:
{"name": "John", "age": 30, "role": "Developer"}

" Record:
qa
I{"name": "<Esc>    " Start object
f,              " Find first comma
r"              " Replace comma with quote
a, "age": <Esc> " Add age field
f,
r,              " Fix comma
a"role": "<Esc>
A"}<Esc>        " End object
j
q

" Replay: 2@a
```

### Macro Tips

1. **Keep macros simple** - Break complex edits into multiple macros
2. **Use relative motions** - `j` not `5j`, `w` not `3w` (works on different data)
3. **Start clean** - Begin recording from a consistent state
4. **Include navigation** - End macro positioned for next replay
5. **Test first** - Record, replay once to verify, then `@@` or `100@a`
6. **Save macros** - Add to vimrc: `let @a = 'your macro'`
7. **Edit macros** - Paste register to file: `"ap`, edit, yank back: `"ay$`

### Recursive Macros

```vim
" Run macro until it fails (end of file, no match, etc.)
qa
... commands ...
@a          " Call itself (recursive)
q

" Start:
@a
" Will run until motion fails (e.g., j at last line)
```

---

## Registers

Registers are storage locations for text (clipboard system).

### Types of Registers

```vim
"a - "z       " Named registers (your storage)
"A - "Z       " Append to named registers (uppercase)
"0            " Last yank
"1 - "9       " Delete/change history (1=most recent)
""            " Default register (unnamed)
"+            " System clipboard (primary)
"*            " System selection (X11)
"-            " Small delete register (< 1 line)
"/            " Last search pattern
":            " Last command
".            " Last inserted text
"%            " Current filename
"#            " Alternate filename
"=            " Expression register
"_            " Black hole register (delete without saving)
```

### Basic Usage

```vim
"{register}y{motion}  " Yank to register
"{register}d{motion}  " Delete to register
"{register}p          " Paste from register

" Examples:
"ayy        " Yank line to register 'a'
"bde        " Delete word to register 'b'
"ap         " Paste from register 'a'
"Ayy        " Append line to register 'a' (uppercase)
```

### View Registers

```vim
:registers      " View all registers
:registers abc  " View specific registers (a, b, c)
```

### Production Patterns

#### Pattern 1: Multiple Copy/Paste

```vim
" Copy several things, paste each where needed
cursor on import → "ayy     (copy to 'a')
cursor on function → "byy   (copy to 'b')
cursor on const → "cyy      (copy to 'c')

" Later:
"ap   " Paste import
"bp   " Paste function
"cp   " Paste const
```

#### Pattern 2: Build Up Content

```vim
" Collect lines from different places
"ayy         " Yank to 'a'
... navigate ...
"Ayy         " Append to 'a' (uppercase)
... navigate ...
"Ayy         " Append again
"ap          " Paste all collected lines
```

#### Pattern 3: Delete Without Affecting Clipboard

**Your keybinding:** `<Space>d` (delete to void register)

```vim
" You yanked important text
yiw

" Now delete other text without losing clipboard
<Space>d  → deletes to "_ (void register)

" Or manually:
"_dd      " Delete line to void (doesn't affect default register)

" Paste your original yank
p         " Still has the word you yanked
```

#### Pattern 4: System Clipboard Integration

**Your config:** System clipboard is default (enabled)

```vim
" Yank to system clipboard
"+yy      " Yank line to system

" Paste from system clipboard
"+p       " Paste from system

" Your config: This is automatic!
y         " Already goes to system clipboard
p         " Already pastes from system clipboard
```

#### Pattern 5: Expression Register (Math/Code)

```vim
" Insert result of calculation
<C-r>=100*1.08<CR>
" Types: 108.0

" In command mode:
:let @a = system('date')
" Register 'a' now contains current date

" In insert mode, insert date:
<C-r>a
```

#### Pattern 6: Last Search to Register

```vim
/searchterm<CR>
" Search pattern now in "/" register

" Use in substitute:
:%s/<C-r>///replacement/g
" Pastes search pattern
```

### Register Tricks

```vim
" View current filename
<C-r>%      " In insert/command mode

" View alternate filename
<C-r>#

" Repeat last inserted text
<C-r>.      " In insert mode

" Access yank history
"0p         " Last yank (before any deletes)
"1p         " 1 delete ago
"2p         " 2 deletes ago

" Paste last search
/<C-r>/     " Pastes last search in new search
:s/<C-r>/// " Use last search in substitute
```

---

## Marks (Covered in Navigation, but advanced usage here)

### Mark Patterns

#### Global Marks for Projects

```vim
" Mark important files across project
:e src/main.ts → gg → mM  (Mark 'M' for Main)
:e src/utils.ts → gg → mU (Mark 'U' for Utils)
:e test/main.test.ts → gg → mT (Mark 'T' for Test)

" Jump between files:
'M  → jump to main
'U  → jump to utils
'T  → jump to test
```

#### Mark Workflow States

```vim
mB        " Mark 'B' for Bug location
mF        " Mark 'F' for Feature work
mR        " Mark 'R' for Review comment
mT        " Mark 'T' for TODO

" Jump between workflow points:
'B → 'F → 'R → 'T
```

### Mark Commands

```vim
:marks          " View all marks
:delmarks a-z   " Delete local marks
:delmarks A-Z   " Delete global marks
:delmarks!      " Delete all marks
```

---

## Visual Block Mode (Column Editing)

### Enter Block Visual

```vim
<C-v>     " Start block visual mode
```

### Production Patterns

#### Pattern 1: Add Comments to Multiple Lines

```vim
" Before:
const a = 1;
const b = 2;
const c = 3;

" Move to first column
<C-v>     " Block visual
jjj       " Select down
I//       " Insert at start
<Esc>     " Apply to all lines

" After:
//const a = 1;
//const b = 2;
//const c = 3;
```

#### Pattern 2: Delete Column

```vim
" Before:
const| a = 1;
const| b = 2;
const| c = 3;
     ^
     delete these pipes

cursor on | → <C-v> → jj → d

" After:
const a = 1;
const b = 2;
const c = 3;
```

#### Pattern 3: Align Assignments

```vim
" Before:
const a = 1;
const veryLongName = 2;
const b = 3;

" Select block after '='
<C-v> → select column → c → adjust spacing
" (Better: use alignment plugin like vim-easy-align)
```

#### Pattern 4: Increment Numbers in Column

```vim
" Before:
1. Item
1. Item
1. Item

<C-v> → select numbers → g<C-a>

" After:
1. Item
2. Item
3. Item
```

#### Pattern 5: Append to Multiple Lines

```vim
" Before:
name
age
city

" Add comma to end
<C-v> → jj → $ → A, → <Esc>

" After:
name,
age,
city,
```

---

## Folds

Collapse sections of code for better overview.

### Manual Folds

```vim
zf{motion}    " Create fold
zf%           " Fold to matching bracket
zfap          " Fold paragraph
zf5j          " Fold 5 lines down

zd            " Delete fold
zD            " Delete folds recursively
zE            " Eliminate all folds

zo            " Open fold
zO            " Open folds recursively
zc            " Close fold
zC            " Close folds recursively
za            " Toggle fold
zA            " Toggle folds recursively
zr            " Open one fold level (reduce)
zR            " Open all folds
zm            " Close one fold level (more)
zM            " Close all folds
```

### Fold Methods

```vim
:set foldmethod=manual    " Manual (default)
:set foldmethod=indent    " By indentation
:set foldmethod=syntax    " By syntax
:set foldmethod=expr      " By expression
```

**Production tip:** Most users use syntax or indent foldmethod with plugins.

---

## Undo Tree (With undotree plugin)

Your config may have this - check with `:Lazy`.

### Native Undo

```vim
u           " Undo
<C-r>       " Redo
```

### Time Travel

```vim
:earlier 5m   " Go back 5 minutes
:earlier 10s  " Go back 10 seconds
:earlier 1h   " Go back 1 hour
:later 5m     " Go forward 5 minutes

:earlier 5    " Undo 5 changes
:later 5      " Redo 5 changes
```

**Use case:** Undo experimental changes from last 10 minutes:
```vim
:earlier 10m
```

---

## Command-Line Window

Edit commands like text before executing.

```vim
q:        " Open command history in editable window
q/        " Open search history

" Inside command window:
j/k       " Navigate history
<CR>      " Execute command under cursor
<C-c>     " Close window
```

**Use case:** Edit complex `:substitute` command before running.

---

## External Commands

### Filter Text Through Command

```vim
:{range}!{command}

" Examples:
:%!jq .                  " Format JSON with jq
:.,+5!sort               " Sort 5 lines
:'<,'>!column -t         " Align columns in selection
:%!prettier --parser typescript  " Format with prettier
```

### Insert Command Output

```vim
:r !{command}            " Read command output into buffer

" Examples:
:r !date                 " Insert current date
:r !ls                   " Insert directory listing
:r !git log --oneline -5 " Insert recent commits
```

### Run Shell Command

```vim
:!{command}              " Execute command, show output

" Examples:
:!npm test               " Run tests
:!git status             " Show git status
:!cargo build            " Build Rust project
```

---

## Arglist (Batch File Operations)

```vim
:args **/*.ts            " Load all .ts files into arglist
:args                    " View arglist

:argdo %s/old/new/ge | update  " Run command on all files
:n                       " Next file in arglist
:prev                    " Previous file in arglist
```

**Use case:** Refactor across specific files
```vim
:args src/**/*.ts
:argdo %s/oldAPI/newAPI/ge | update
```

---

## Diff Mode

```vim
:vs other.ts             " Open file in split
:windo diffthis          " Enable diff in both windows
:diffoff                 " Disable diff

" Navigate differences:
]c                       " Next change
[c                       " Previous change

" Merge changes:
do                       " Diff obtain (pull from other)
dp                       " Diff put (push to other)
:diffupdate              " Update diff
```

---

## Sessions

### Manual Session Management

```vim
:mksession! ~/session.vim     " Save session
:source ~/session.vim          " Load session

" Or from shell:
nvim -S ~/session.vim
```

### What's Saved

- Window layout
- Buffers
- Current directory
- Marks
- Registers
- Options

**Your setup:** You have `auto-session` plugin (check config).

---

## Advanced Search Patterns

### Lookahead/Lookbehind

```vim
" Positive lookahead: match 'foo' only if followed by 'bar'
/\v foo \ze bar
" \ze = end match here (zero-width)

" Positive lookbehind: match 'bar' only if preceded by 'foo'
/\v foo \zs bar
" \zs = start match here

" Example: Match number in "price: 100"
/\v price: \zs\d+
" Matches only '100', not 'price: '
```

### Multiline Patterns

```vim
" Match across lines (use \n)
/function.\{-}end
" .\{-} = non-greedy any character

" Match function definition spanning multiple lines
/\vfunction\s+\w+\_s*\(
" \_s = whitespace including newlines
```

---

## Pro Tips

1. **Record macros to registers a-z** - Don't overwrite useful ones
2. **Use `@@` to repeat** - Faster than `@a`
3. **Named registers for collecting** - Use `"A` (uppercase) to append
4. **Black hole register** - `"_` for delete without affecting clipboard
5. **Expression register** - `<C-r>=` for calculations
6. **Block visual for columns** - `<C-v>` is underused but powerful
7. **Time travel with `:earlier`** - Undo changes from last session
8. **Filter through external tools** - `:%!jq`, `:%!prettier`
9. **Global marks (A-Z)** - Jump between files instantly
10. **Command-line window `q:`** - Edit complex commands before running

---

**Next**: Master [LSP Usage](lsp-usage.md) for IDE-like features, or see [Mistakes to Avoid](mistakes-to-avoid.md) for common pitfalls.
