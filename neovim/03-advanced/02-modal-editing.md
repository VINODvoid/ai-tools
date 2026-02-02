# Modal Editing Mastery

Understanding modal editing is the foundation of Neovim proficiency. This is not about memorizing commands—it's about thinking in a different paradigm.

## The Four Modes That Matter

### Normal Mode (Command Mode)
**Default state. You spend 80% of time here.**

- Navigate, manipulate, compose commands
- Think of this as "command mode" not "navigation mode"
- Press `<Esc>` or `<C-[>` from any mode to return here

### Insert Mode
**Actually typing text. Get in, type, get out fast.**

- Enter: `i`, `a`, `o`, `O`, `c`, `s`, `I`, `A`
- Exit: `<Esc>`, `<C-[>`, or `<C-c>` (faster, but skips some autocmds)
- Minimal time here—make precise changes in normal mode

### Visual Mode
**Select text. Use sparingly.**

- `v` - character-wise
- `V` - line-wise
- `<C-v>` - block-wise
- **Antipattern**: Using visual mode for things text objects can do

### Command-Line Mode
**Execute commands, search, substitute.**

- Enter with `:`, `/`, `?`, or `!`
- Where `:w`, `:q`, `:%s/foo/bar/g` happen

## Motion Mastery

### Essential Motions (Learn These First)

```vim
" Horizontal
h, l          " Character left/right (use sparingly)
w             " Next word start
b             " Previous word start
e             " Next word end
0             " Start of line
^             " First non-blank character
$             " End of line
f{char}       " Find next char on line
F{char}       " Find previous char on line
t{char}       " Till next char (one before)
T{char}       " Till previous char
;             " Repeat last f/F/t/T
,             " Repeat last f/F/t/T reverse

" Vertical
j, k          " Line down/up (use sparingly)
{             " Previous empty line (paragraph up)
}             " Next empty line (paragraph down)
<C-d>         " Half page down
<C-u>         " Half page up
<C-f>         " Full page down
<C-b>         " Full page up
gg            " Top of file
G             " Bottom of file
{number}G     " Go to line number
%             " Matching bracket/paren

" Search-based
/{pattern}    " Search forward
?{pattern}    " Search backward
*             " Search word under cursor forward
#             " Search word under cursor backward
n             " Next search result
N             " Previous search result
```

### Real-World Motion Patterns

```vim
" Scenario: Fix function call argument 3 lines down
" Bad: jjjf(lli, argument
" Good: 3j/arg<CR>i,

" Scenario: Delete from cursor to end of sentence
" Bad: vllllllllllx
" Good: dt.

" Scenario: Jump to closing brace of current block
" Bad: }}}}}}
" Good: ]m  (or use % if on opening brace)

" Scenario: Navigate to error on line 247
" Bad: gggjjjjjj... (246 times)
" Good: :247<CR> or 247G

" Scenario: Delete everything in current function
" Bad: V{jjjjjjjjd
" Good: daf  (with treesitter text objects)
```

### Counts Make Motions Powerful

```vim
3w      " Move forward 3 words
5j      " Move down 5 lines
2f"     " Jump to 2nd " on line
d3w     " Delete 3 words
c2t,    " Change up to 2nd comma
```

**Pro Pattern**: Don't count characters. Count logical units (words, sentences, paragraphs).

## Operators

Operators act on motions or text objects.

### Core Operators

```vim
d       " Delete (cut)
c       " Change (delete and enter insert)
y       " Yank (copy)
>       " Indent right
<       " Indent left
=       " Auto-indent
gu      " Lowercase
gU      " Uppercase
g~      " Toggle case
!       " Filter through external command
gw      " Format text (respects textwidth)
```

### Operator Patterns

```vim
" Double to operate on current line
dd      " Delete line
yy      " Yank line
cc      " Change line
>>      " Indent line
==      " Auto-indent line
gUU     " Uppercase line

" Operator + motion
dw      " Delete word
ct,     " Change until comma
y$      " Yank to end of line
>%      " Indent until matching brace
gU3w    " Uppercase next 3 words

" Operator + count + motion
d3w     " Delete 3 words
c2t;    " Change until 2nd semicolon
y4j     " Yank current line + 4 down
```

## Text Objects (Game Changer)

Text objects define semantic units. This is where Neovim becomes superhuman.

### Built-in Text Objects

```vim
" Format: [operator][i/a][object]
" i = inside (excludes delimiters)
" a = around (includes delimiters)

iw, aw    " Word
iW, aW    " WORD (whitespace-delimited)
is, as    " Sentence
ip, ap    " Paragraph
i", a"    " Double-quoted string
i', a'    " Single-quoted string
i`, a`    " Backtick string
i(, a(    " Parentheses (also ib, ab)
i{, a{    " Braces (also iB, aB)
i[, a[    " Brackets
i<, a<    " Angle brackets
it, at    " Tag blocks (HTML/XML)
```

### Real-World Text Object Usage

```vim
" Change function name
cursor on function → ciw → type new name

" Delete string contents
cursor inside "hello" → di" → ""

" Change entire function argument
cursor inside foo(bar, baz) → ci( → foo()

" Copy entire paragraph
anywhere in paragraph → yap

" Delete HTML tag contents
cursor in <div>content</div> → dit → <div></div>

" Indent entire function
inside function → >aB

" Select entire JSON object
inside { } → vi{ → enters visual mode with object selected
```

### Treesitter Text Objects (Modern Neovim)

With `nvim-treesitter/nvim-treesitter-textobjects`:

```vim
af, if    " Function
ac, ic    " Class
aa, ia    " Argument
ab, ib    " Block
```

Examples:
```vim
daf       " Delete entire function
vac       " Select entire class
cia       " Change function argument
>ab       " Indent code block
```

## Composability: The Real Power

The magic is combining operators, counts, and text objects:

```vim
d3w       " Delete 3 words
c2t;      " Change until 2nd semicolon
3>ap      " Indent paragraph 3 levels
gUiw      " Uppercase current word
=a{       " Auto-indent entire brace block
y4j       " Yank current + 4 lines down
dt_       " Delete until underscore
```

**Mental Model**: `[count][operator][count][motion/text-object]`

## Repetition with `.` (Dot Command)

The `.` command repeats your last change. This is criminally underused.

### Dot Command Patterns

```vim
" Scenario: Delete word, repeat on next 3 words
dw → w → . → w → . → w → .

" Scenario: Change "foo" to "bar" multiple times
/foo<CR> → cw → bar<Esc> → n → . → n → .

" Scenario: Indent multiple paragraphs
>ap → } → . → } → .

" Scenario: Add semicolon to end of multiple lines
A;<Esc> → j → . → j → .

" Scenario: Comment out lines
gcc (with plugin) → j → . → j → .
```

**Pro Tip**: Before repeating a task 10 times, set it up to be repeatable with `.`

## Insert Mode Minimalism

Get in, make the change, get out. Insert mode has useful commands:

```vim
<C-w>     " Delete word backward
<C-u>     " Delete to start of line
<C-o>     " Execute one normal mode command
<C-r>"    " Paste from default register
<C-r>=    " Paste from expression register (do math, etc.)
<C-n>     " Next autocomplete suggestion
<C-p>     " Previous autocomplete suggestion
<C-x><C-l>" Line completion
<C-x><C-f>" File path completion
```

### Common Insert Mode Patterns

```vim
" Fix typo without leaving insert mode
typing "functino" → <C-w> → function

" Insert result of calculation
typing price: → <C-r>=100*1.08<CR> → 108.0

" Paste while typing
<C-r>" → pastes last yank/delete

" Execute normal command mid-insert
<C-o>w → jump forward word, stay in insert
<C-o>diw → delete word under cursor, stay in insert
```

## Visual Mode (Use Sparingly)

Visual mode is seductive but often inefficient.

### When Visual Mode Makes Sense

```vim
" Irregular selections
v/end<CR> → select from cursor to "end"

" Block operations (column editing)
<C-v> → select column → I → type → <Esc>

" Visual search
v → select text → y → /<C-r>"<CR>
```

### When to Avoid Visual Mode

```vim
" Bad: Select word → delete
viwx

" Good: Delete word
diw

" Bad: Select inside quotes → change
vi"c

" Good: Change inside quotes
ci"

" Bad: Select 3 words → yank
vwwwy

" Good: Yank 3 words
y3w
```

**Rule of Thumb**: If a text object can do it, don't use visual mode.

## Command-Line Mode Tricks

```vim
:w          " Write
:q          " Quit
:wq         " Write and quit
:q!         " Quit without saving
:x          " Write if changed, then quit (better than :wq)

" Ranges
:10,20d     " Delete lines 10-20
:.,$s/foo/bar/g  " Substitute from current line to end
:%y         " Yank entire file
:g/pattern/d     " Delete all lines matching pattern

" External commands
:!ls        " Run shell command
:%!jq .     " Filter buffer through jq
:r !date    " Insert output of date command
```

## Practice Drills

### Drill 1: Pure Motions
Navigate a large file using only `w`, `b`, `{`, `}`, `%`, `*`, `f`, `t`. No `hjkl`.

### Drill 2: Operator + Text Object
Open a code file. For every edit:
- Must use format: `[operator][text-object]`
- No visual mode
- Examples: `daw`, `ci"`, `>ap`, `gUiw`

### Drill 3: Dot Command
Find a repetitive task (add semicolons, change variable names, etc.). Complete using:
1. Make change once
2. Navigate to next occurrence
3. Press `.`
4. Repeat

### Drill 4: Zero `hjkl`
Disable: `nnoremap h <Nop>` (do for all four). Navigate for 1 hour. Forces you to learn real motions.

## Measuring Progress

**Beginner**: Think "move cursor to X", then execute
**Intermediate**: Think "delete to X", execute `dt.`
**Advanced**: Fingers move before brain finishes thought
**Expert**: You think in text objects and operators, not cursor positions

## Common Mistakes

1. **Holding `j` to move down** → Use `{`, `}`, `<C-d>`, `/pattern`, or `{number}G`
2. **Using visual mode for simple changes** → Use text objects: `ci"` not `vi"c`
3. **Repeating commands manually** → Use `.` or macros
4. **Not using counts** → `d3w` is faster than `dwdwdw`
5. **Staying in insert mode too long** → Make atomic changes, return to normal
6. **Not using `f` and `t`** → Fastest horizontal navigation on a line

---

**Next**: Practice these patterns in real code, then move to [Text Manipulation](text-manipulation.md) for deeper operator knowledge.
