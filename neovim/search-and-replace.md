# Search and Replace Mastery

Master pattern matching and bulk editing for powerful refactoring capabilities.

## Search Patterns

### Basic Search

```vim
/{pattern}      " Search forward
?{pattern}      " Search backward
n               " Next match
N               " Previous match
*               " Search word under cursor forward
#               " Search word under cursor backward
```

**Your config:** `n` and `N` center the screen for better visibility.

### Search Flags

```vim
/pattern/        " Basic search
/pattern/i       " Case-insensitive
/pattern/I       " Case-sensitive
/\cpattern       " Case-insensitive (anywhere in pattern)
/\Cpattern       " Case-sensitive (anywhere in pattern)
```

### Special Characters (Regex)

```vim
.         " Any character (except newline)
^         " Start of line
$         " End of line
\<        " Start of word
\>        " End of word
\s        " Whitespace
\S        " Non-whitespace
\d        " Digit
\D        " Non-digit
\w        " Word character [a-zA-Z0-9_]
\W        " Non-word character
*         " 0 or more
\+        " 1 or more (note the backslash!)
\?        " 0 or 1 (optional)
\{n,m}    " n to m occurrences
[abc]     " Any of a, b, c
[^abc]    " Not a, b, or c
\|        " OR
\(  \)    " Grouping
```

**Note:** Vim uses "magic" mode by default. Use `\v` for "very magic" (more like Perl regex).

### Very Magic Mode

```vim
/\v           " Start very magic mode (less escaping)

" Examples:
/\v(foo|bar)  " Match foo or bar (no backslash on parentheses)
/\vfunction\s+\w+  " Match function declarations
```

**Production tip:** Always use `/\v` for complex patterns - it's more intuitive.

### Search Examples

```vim
" Find TODO comments
/TODO

" Find function declarations (JavaScript)
/\vfunction\s+\w+

" Find imports
/^import

" Find email addresses
/\v\w+@\w+\.\w+

" Find numbers
/\d\+

" Find URLs
/\vhttps?://\S+

" Find empty lines
/^$

" Find lines with trailing whitespace
/\s\+$

" Find word boundaries
/\<searchterm\>
```

---

## Substitute Command (`:s`)

The substitute command is the workhorse of bulk editing.

### Basic Syntax

```vim
:[range]s/pattern/replacement/[flags]
```

### Ranges

```vim
:s/old/new/           " Current line
:%s/old/new/          " Entire file
:.,+5s/old/new/       " Current line + next 5
:10,20s/old/new/      " Lines 10-20
:.,$s/old/new/        " Current line to end
:1,50s/old/new/       " Lines 1-50
:'<,'>s/old/new/      " Visual selection (auto-filled)
```

### Flags

```vim
g         " Global (all occurrences on line)
c         " Confirm each substitution
i         " Case-insensitive
I         " Case-sensitive
n         " Count matches, don't replace
```

### Common Patterns

```vim
" Replace first occurrence on each line
:%s/foo/bar/

" Replace all occurrences in file
:%s/foo/bar/g

" Replace with confirmation
:%s/foo/bar/gc

" Case-insensitive replace
:%s/foo/bar/gi

" Count matches without replacing
:%s/foo/bar/gn

" Delete pattern (replace with nothing)
:%s/pattern//g

" Delete trailing whitespace
:%s/\s\+$//g

" Replace in visual selection
V → select lines → :s/foo/bar/g
" (The '<,'> range is auto-filled)
```

---

## Advanced Substitution

### Capture Groups

```vim
" Syntax: \( \) to capture, \1 \2 etc. to reference

" Swap two words
:%s/\v(\w+) (\w+)/\2 \1/g
" "hello world" → "world hello"

" Extract filename from path
:%s/\v.*\/([^/]+)$/\1/
" "/path/to/file.txt" → "file.txt"

" Add quotes around words
:%s/\v(\w+)/"\1"/g
" hello → "hello"

" Uppercase first letter of each word
:%s/\v<(\w)(\w*)/\u\1\L\2/g
" hello world → Hello World
```

### Special Replacement Strings

```vim
&         " The whole matched pattern
\0        " The whole matched pattern (same as &)
\1-\9     " Captured groups
\u        " Uppercase next character
\U        " Uppercase until \e or \E
\l        " Lowercase next character
\L        " Lowercase until \e or \E
\e        " End \U or \L
\E        " End \U or \L
\r        " Newline
\t        " Tab
\n        " Null character (in pattern: newline)
```

### Production Examples

```vim
" Convert snake_case to camelCase
:%s/\v_(\w)/\u\1/g
" user_name → userName

" Convert camelCase to snake_case
:%s/\v([a-z])([A-Z])/\1_\l\2/g
" userName → user_name

" Add semicolons to end of lines (missing ones)
:%s/\v([^;])$/\1;/

" Remove console.log statements
:%s/\v^\s*console\.log\(.*\);\n//g

" Convert single quotes to double quotes
:%s/'/"/g

" Wrap URLs in markdown links
:%s/\v(https?:\/\/\S+)/[\1](\1)/g

" Convert tabs to 2 spaces
:%s/\t/  /g

" Remove extra whitespace (multiple spaces → single)
:%s/\s\+/ /g

" Comment out lines (JavaScript/TypeScript)
:%s/^/\/\/ /
" (or use gcc with commentary plugin)

" Add comma to end of lines
:%s/$/,/
```

---

## Global Command (`:g`)

The global command runs a command on lines matching a pattern.

### Syntax

```vim
:[range]g/pattern/command
:[range]g!/pattern/command  " Inverse (lines NOT matching)
:[range]v/pattern/command   " Same as g! (inverse)
```

### Common Uses

```vim
" Delete all lines containing pattern
:g/TODO/d

" Delete all empty lines
:g/^$/d

" Delete all lines NOT containing pattern
:g!/important/d
" or
:v/important/d

" Copy all matching lines to end of file
:g/pattern/t$

" Move all matching lines to end of file
:g/pattern/m$

" Yank all matching lines to register a
:g/pattern/y A

" Print all matching lines
:g/pattern/p
" (or just :g/pattern)

" Execute normal mode command on matching lines
:g/pattern/normal A;
" (append semicolon to end of matching lines)
```

### Production Examples

```vim
" Delete all console.log statements
:g/console\.log/d

" Delete all commented lines
:g/^\/\//d

" Delete all import statements
:g/^import/d

" Keep only lines with errors
:v/error/d

" Add 'export' to all function declarations
:g/^function/normal Iexport

" Delete all trailing whitespace lines
:g/^\s\+$/d

" Fold all functions
:g/function/normal zf%
```

---

## Multi-File Search and Replace

### With Telescope (Your Setup)

#### Step 1: Search Across Files

```vim
<Space>fs       " Live grep
" Type search pattern
<C-q>           " Send results to quickfix list
```

#### Step 2: Replace Across Results

```vim
:cfdo %s/old/new/g | update
" cfdo = run command on each file in quickfix
" update = save if changed
```

**Complete workflow:**

```vim
<Space>fs → type "oldFunction" → <C-q>
:cfdo %s/oldFunction/newFunction/g | update
```

### Alternative: cdo vs cfdo

```vim
:cdo s/old/new/g | update    " Run on each MATCH in quickfix
:cfdo %s/old/new/g | update  " Run on each FILE in quickfix
```

**Use `cfdo` for file-wide changes, `cdo` for match-specific changes.**

### With Location List

```vim
:ldo s/old/new/g | update
:lfdo %s/old/new/g | update
```

---

## Grep Integration

### Internal Grep

```vim
:grep pattern **/*.ts       " Search all .ts files recursively
:grep -r pattern .          " Recursive search
:cn                         " Next result
:cp                         " Previous result
:copen                      " Open quickfix list
```

### With ripgrep (Faster)

If ripgrep (`rg`) is installed:

```vim
:set grepprg=rg\ --vimgrep
:grep pattern
```

**Your setup uses Telescope, which is better.**

---

## Search and Replace Workflows

### Workflow 1: Find and Replace Single File

```vim
/oldName<CR>              " Find first occurrence
→ verify it's correct
:%s//newName/gc           " Replace (empty pattern = last search)
" Answer y/n for each match
```

### Workflow 2: Replace in Selection

```vim
V → select lines
:s/old/new/g              " Range auto-filled as '<,'>
```

### Workflow 3: Multi-File Replace

```vim
<Space>fs → search term → <C-q>
:cfdo %s/old/new/gc | update
" Answer y/n for each file's matches
```

### Workflow 4: Refactor Function Name

```vim
cursor on function name → *  (search word)
:%s//newName/gc              (replace with confirm)
```

**Better with LSP:** Use `<Space>rn` (LSP rename) - it's scope-aware!

### Workflow 5: Delete All Matching Lines

```vim
:g/pattern/d
```

### Workflow 6: Complex Refactor

```vim
" Example: Convert React class to function component
" 1. Record macro
qq                        " Start recording to register q
" ... perform refactor steps ...
q                         " Stop recording

" 2. Apply to all similar files
:args **/*.tsx            " Load all .tsx files into arglist
:argdo normal @q | update " Run macro on each file
```

---

## Regular Expression Patterns Library

### JavaScript/TypeScript

```vim
" Function declarations
/\vfunction\s+\w+\s*\(

" Arrow functions
/\v\w+\s*=\s*\([^)]*\)\s*=>

" Import statements
/\v^import\s+.+\s+from

" console.log
/\vconsole\.log\(

" Const declarations
/\vconst\s+\w+

" Class declarations
/\vclass\s+\w+
```

### Python

```vim
" Function definitions
/\vdef\s+\w+\s*\(

" Class definitions
/\vclass\s+\w+

" Import statements
/\v^(from|import)\s+

" Decorators
/\v^\s*@\w+
```

### HTML/JSX

```vim
" Opening tags
/\v\<\w+[^>]*\>

" Closing tags
/\v\</\w+\>

" Self-closing tags
/\v\<\w+[^>]*/\>

" Class attributes
/\vclass(Name)?="[^"]+"
```

### URLs and Emails

```vim
" URLs
/\vhttps?:\/\/[^\s]+

" Emails
/\v\w+@\w+\.\w+
```

---

## Substitute Tricks

### Increment Numbers

```vim
" Change version 1.0.1 to 1.0.2, 1.0.3, etc.
:%s/\d\+/\=submatch(0)+1/g

" Only increment specific numbers
:%s/version \zs\d\+/\=submatch(0)+1/g
" \zs = start match here (only number is replaced)
```

### Execute Expression

```vim
" Replace with result of expression
:%s/\d\+/\=submatch(0)*2/g
" Doubles all numbers

" Convert to uppercase
:%s/\w\+/\=toupper(submatch(0))/g
```

### Conditional Replace

```vim
" Replace only if line contains another pattern
:g/class/s/var/let/g
" Replace 'var' with 'let' only in lines containing 'class'
```

---

## Clear Search Highlighting

**Your keybinding:** `<Space>nh`

**Native:**
```vim
:nohl       " Short for :nohlsearch
```

---

## Search Tips

1. **Use `*` instead of typing** - Cursor on word, press `*`
2. **Use `\v` for complex regex** - Less escaping needed
3. **Test pattern with `/` before `:s`** - Verify matches first
4. **Use `gc` flag initially** - Confirm before mass replace
5. **Empty pattern in substitute** - Reuses last search: `:%s//replacement/g`
6. **Use `<Space>fs` for project search** - Telescope is faster than `:grep`
7. **Send Telescope to quickfix** - Use `<C-q>`, then `:cfdo`
8. **Use LSP rename for code** - `<Space>rn` is smarter than regex
9. **Learn capture groups** - `\(\)` and `\1` for complex transforms
10. **Global commands are powerful** - `:g/pattern/d` is faster than manual

---

## Common Mistakes

1. **Forgetting `/g` flag** - Only replaces first match per line
2. **Not escaping special chars** - Use `\v` or escape `.` `*` `[` etc.
3. **Not testing pattern first** - Use `/pattern` to verify before `:s`
4. **Using regex for code refactoring** - Use LSP rename instead
5. **Forgetting `c` flag** - Mass replace without review can break things
6. **Not using Telescope** - Faster than `:grep` or manual search
7. **Ignoring quickfix list** - `<C-q>` + `:cfdo` is powerful
8. **Complex regex without `\v`** - Very magic mode is easier

---

## Practice Exercises

### Exercise 1: Clean Up Code

```javascript
// Before:
const  foo  =  "bar" ;
const   baz   =   "qux"  ;

// Task: Remove extra spaces
:%s/\s\+/ /g
```

### Exercise 2: Refactor Naming

```javascript
// Before:
const userData = getUserData();
const userToken = userData.token;

// Task: Rename userData to userInfo
:%s/userData/userInfo/g
```

### Exercise 3: Multi-File Import Fix

```typescript
// Replace old import path across project
<Space>fs → "@/old-path" → <C-q>
:cfdo %s/@\/old-path/@\/new-path/g | update
```

### Exercise 4: Format JSON Keys

```
// Before: {name: "test", age: 25}
// After: {"name": "test", "age": 25}

:%s/\v(\w+):/"\1":/g
```

---

**Next**: Master [Advanced Techniques](advanced-techniques.md) for macros and registers, or practice with [LSP Usage](lsp-usage.md) for modern code editing.
