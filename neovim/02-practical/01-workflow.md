# Real-World Workflow Patterns

How to actually use Neovim for production development work. These are patterns from developers who ship code in Neovim daily.

## Daily Development Workflow

### Opening a Project

```bash
# Good: Navigate to project root first
cd ~/projects/myapp
nvim .

# Better: Use session management (plugin)
nvim -S Session.vim

# Best: Use a project switcher (telescope + project.nvim)
# Leader key → fp → select project
```

**Inside Neovim:**
```vim
:e src/main.rs              " Open file
:find **/user_service.rs    " Fuzzy find file (if path is set)
<Leader>ff                  " Telescope find files (most common)
<Leader>fg                  " Telescope grep search
<Leader>fb                  " Telescope buffers
```

### File Navigation Pattern

Typical flow in a session:
1. Open project root: `nvim .`
2. Find main file: `<Leader>ff` → type partial name → `<CR>`
3. Jump to definition: cursor on symbol → `gd`
4. Return: `<C-o>`
5. Find all references: `gr`
6. Search across project: `<Leader>fg` → type pattern

### Buffer Management

```vim
" Cycle buffers (requires plugin or mapping)
:bn                    " Next buffer
:bp                    " Previous buffer
:bd                    " Delete buffer (close file)
<Leader>bd             " Common mapping for buffer delete

" Jump to specific buffer (with telescope)
<Leader>fb             " List buffers, select one

" Quick switch between two files
<C-^>                  " Toggle between current and alternate buffer

" Close all buffers except current
:%bd|e#|bd#           " Nuclear option
```

**Production Pattern**: Keep 5-10 buffers open max. Close what you're done with.

## Common Coding Scenarios

### Scenario 1: Implement a New Function

**Task**: Add `calculateDiscount(price, percentage)` to `pricing.ts`

```vim
" 1. Open file
<Leader>ff → pricing → <CR>

" 2. Find where to insert (after similar function)
/calculatePrice<CR>

" 3. Go to end of function
]m  (or %]})

" 4. Add new function below
o<CR>  → type function

" Or use LSP snippet if configured
function<Tab> → fill template
```

### Scenario 2: Refactor Variable Name

**Task**: Rename `userData` to `userProfile` across file

```vim
" Method 1: LSP rename (best for code)
cursor on userData → <Leader>rn → type userProfile → <CR>

" Method 2: Substitute in file
:%s/userData/userProfile/gc
" g=global on line, c=confirm each

" Method 3: Substitute in selection
V{  (select function)
:s/userData/userProfile/g
```

### Scenario 3: Fix Linting Errors

**Task**: File has 10 linting errors, fix them all

```vim
" Open file, see diagnostics
:e src/buggy.ts

" Jump to errors
]d         " Next diagnostic
[d         " Previous diagnostic

" View error under cursor
<Leader>e  " Show diagnostic float (common mapping)

" Apply quick fix
<Leader>ca " Code action (LSP will suggest fixes)

" Navigate and fix
]d → <Leader>ca → select fix → ]d → repeat
```

### Scenario 4: Review and Understand Code

**Task**: Understand `processPayment()` function you've never seen

```vim
" 1. Find and open
<Leader>fg → processPayment → <CR>

" 2. Jump to definition
gd

" 3. See function signature
K  (hover documentation)

" 4. Explore called functions
cursor on stripeAPI.charge → gd
<C-o>  (back to processPayment)

" 5. Find all usages
gr  (go to references)

" 6. See call hierarchy
:lua vim.lsp.buf.incoming_calls()
```

### Scenario 5: Git Workflow

**Task**: Make changes, stage, commit, push

```vim
" Make changes in file, save
:w

" See git status (with vim-fugitive or gitsigns)
:G  or  :Git status

" Stage current file
:G add %

" Or stage hunks (with gitsigns)
<Leader>hs  " Stage hunk under cursor

" Commit
:G commit
" Opens commit message buffer, write message, :wq

" Push
:G push

" View diff before committing
:G diff
:G diff --staged
```

**Alternative Flow (without fugitive)**:
```vim
:w
:!git add %
:!git commit -m "fix: update payment processing"
:!git push
```

### Scenario 6: Debug Stack Trace

**Task**: Error says "TypeError at user_service.ts:247"

```vim
" Jump directly to line
:e src/user_service.ts
:247

" Or in one command
:e +247 src/user_service.ts

" Set mark for later return
mE  (mark as 'E' for error)

" Investigate, then jump back
'E  (return to mark E)

" View error context
<C-d> / <C-u>  (scroll to see surrounding code)
```

### Scenario 7: Multi-File Refactor

**Task**: Change API endpoint from `/v1/users` to `/v2/users` across codebase

```vim
" 1. Search across all files
<Leader>fg → /v1/users → <CR>

" 2. This opens telescope with all matches
" Navigate with <C-n>, <C-p>

" 3. Quick way: Use global substitute in quickfix
:cdo s/\/v1\/users/\/v2\/users/gc | update
" cdo = run command on each quickfix entry
" update = save if changed

" 4. Or manually navigate
:cn → edit → :cn → edit
" cn = next quickfix item
```

### Scenario 8: Split Screen Debugging

**Task**: Compare implementation in `old.ts` with `new.ts`

```vim
" Open first file
:e old.ts

" Split and open second
:vs new.ts
" or :sp new.ts (horizontal)

" Navigate between splits
<C-w>h  " Left
<C-w>l  " Right
<C-w>j  " Down
<C-w>k  " Up

" Or easier (with common mapping)
<C-h>, <C-l>, <C-j>, <C-k>

" Scroll in sync (optional)
:set scrollbind  " In both windows
```

### Scenario 9: Copy Code from Another File

**Task**: Copy function from `utils.ts` to `helpers.ts`

```vim
" Open target file
:e helpers.ts

" Open source in split
:vs utils.ts

" Navigate to function (in utils.ts)
/function parseDate<CR>

" Yank entire function (with treesitter text object)
yaf

" Or yank visually
V]m → y

" Switch to other split
<C-w>l

" Paste
p

" Close source split
<C-w>c
```

### Scenario 10: Work on Multiple Related Files

**Task**: Update component, tests, and types

```vim
" Open files in buffers
:e Component.tsx
:e Component.test.tsx
:e Component.types.ts

" Cycle through
:bn, :bn, :bn

" Or use buffer picker
<Leader>fb → select file

" Or use splits for simultaneous view
:vs Component.test.tsx
<C-w>l  (navigate to test)
<C-w>h  (back to component)
```

## Workflow Patterns by Language

### JavaScript/TypeScript

```vim
" Jump to import source
cursor on imported name → gd

" Auto-import (with LSP)
type function name → <Leader>ca → select import

" Organize imports
<Leader>oi  (if configured)

" Format file
<Leader>f  or  :lua vim.lsp.buf.format()

" Run single test (with vim-test or neotest)
<Leader>tn  " Test nearest
<Leader>tf  " Test file
<Leader>ta  " Test all
```

### Python

```vim
" Jump to definition (LSP)
gd

" Show function signature
<C-k>  or  K

" Format with black/ruff
:!black %
:e  " Reload file

" Or with LSP formatter
<Leader>f

" Run file
:!python %

" Run in terminal split
:sp | term python %
```

### Go

```vim
" Jump to definition
gd

" Find interface implementations
gi

" Format and organize imports (LSP auto-does this)
:w  " gopls formats on save

" Run current file
:!go run %

" Run tests
:!go test
<Leader>tn  " With vim-test plugin
```

### Rust

```vim
" Jump to definition
gd

" Expand macro
<Leader>em

" Show documentation
K

" Format (LSP)
:w  " rust-analyzer formats on save

" Build
:!cargo build

" Run
:!cargo run

" Test
:!cargo test
```

## Terminal Integration

### Built-in Terminal

```vim
" Open terminal
:term
:split | term     " In split
:vsplit | term    " In vertical split

" Exit terminal mode
<C-\><C-n>

" Run command without opening terminal
:!cargo build
:!npm test
:!pytest
```

### Terminal Workflow Pattern

```vim
" Open terminal in split at bottom
:botright split | term

" Resize to 15 lines
<C-w>_   (maximize height)
15<C-w>_  (set to 15 lines)

" Run long-running process (dev server)
npm run dev

" Switch back to code
<C-\><C-n>  (exit terminal mode)
<C-w>k      (move to code window)

" Kill process when done
<C-w>j  (back to terminal)
<C-c>   (kill process)
:q      (close terminal)
```

## Testing Workflow

### Pattern 1: Run Tests in Terminal

```vim
:vs | term npm test

" Or bottom split
:sp | term pytest

" Or dedicated test runner plugin (neotest)
<Leader>tn  " Run nearest test
<Leader>tf  " Run file
<Leader>to  " Show test output
```

### Pattern 2: Test-Driven Development

```vim
" 1. Write test first
:e feature.test.ts
" Write failing test

" 2. Run test (see it fail)
<Leader>tn

" 3. Switch to implementation
<C-^>  or  :e feature.ts

" 4. Implement
" Code...

" 5. Re-run test
<Leader>tn

" 6. Iterate until green
" Repeat 3-5
```

## Debugging Workflow

### Pattern 1: Print Debugging

```vim
" Add console.log/print statement
ologger.debug(f"{variable=}")
" Or in JavaScript
oconsole.log({ variable });

" Run and see output
:!npm run test

" Remove debug statement when done
dd
```

### Pattern 2: DAP (Debug Adapter Protocol)

With `nvim-dap` configured:

```vim
" Set breakpoint
<Leader>db

" Start debugging
<Leader>dc

" Step over
<Leader>dso

" Step into
<Leader>dsi

" Continue
<Leader>dcont
```

## Code Review Workflow

### Reviewing Pull Request

```vim
" Check out branch
:!git fetch origin pull/123/head:pr-123
:!git checkout pr-123

" View changed files
:!git diff main --name-only

" Open changed file
:e path/to/changed/file.ts

" See diff with main
:G diff main

" Navigate changes
]c  " Next change
[c  " Previous change

" Leave comments (external tool)
:!gh pr review 123 --comment
```

### Comparing Branches

```vim
" Open file from current branch
:e src/feature.ts

" Open same file from main in split
:vs
:r!git show main:src/feature.ts

" Or with fugitive
:Gdiffsplit main
```

## Session Management

### Manual Session

```vim
" Save session
:mksession! ~/sessions/project.vim

" Load session
:source ~/sessions/project.vim
" Or from shell
nvim -S ~/sessions/project.vim
```

### Auto-Session (Plugin)

Automatic session management saves you time:

```vim
" With auto-session plugin, sessions save automatically
" Restore last session
:RestoreSession

" Switch projects (with telescope integration)
<Leader>fp
```

## Productivity Patterns

### Pattern 1: Tmux + Neovim

```bash
# Split terminal horizontally (tmux)
tmux split-window -v

# Top pane: Neovim
nvim .

# Bottom pane: dev server / tests / git
npm run dev
```

Navigate between Neovim and tmux with keybindings.

### Pattern 2: Multiple Neovim Instances

```bash
# Terminal 1: Main code
nvim .

# Terminal 2: Tests
nvim test/

# Terminal 3: Documentation
nvim docs/
```

Switch between terminals with tmux/terminal emulator.

### Pattern 3: Single Neovim, Multiple Tabs

```vim
:tabnew src/
:tabnew test/

" Switch tabs
gt   " Next tab
gT   " Previous tab
3gt  " Go to tab 3

" Or with leader
<Leader>1 → tab 1
<Leader>2 → tab 2
```

## Quick Wins for Speed

```vim
" Write and quit
:x  (instead of :wq, only writes if changed)

" Write all buffers
:wa

" Quick file switch (alternate file)
<C-^>

" Format and save
<Leader>f → :w

" Search symbol across project
<Leader>fs  (with telescope LSP symbols)

" Jump to last edit location
`.

" Open file under cursor
gf

" Create file under cursor (if doesn't exist)
:e <cfile>
```

## Mistake Recovery

```vim
" Undo
u

" Redo
<C-r>

" Undo tree navigation (with undotree plugin)
<Leader>u → see visual history

" Recover file after crash
:recover

" Reload file (discard local changes)
:e!

" Restore deleted line
:earlier 1m  " Go back 1 minute
```

---

**Next**: Dive deeper into [Text Manipulation](text-manipulation.md) or see [LSP Usage](lsp-usage.md) for IDE-like features.
