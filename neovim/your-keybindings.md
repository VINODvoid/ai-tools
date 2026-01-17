# Your Neovim Keybindings Reference

This is a reference for **your specific configuration** at `~/.config/nvim/`.

## Leader Key

**Leader:** `<Space>`

Press space, then the key combination. Example: `<leader>ff` = `Space` then `f` then `f`

---

## Essential Keybindings

### Insert Mode

| Key | Action | Usage |
|-----|--------|-------|
| `jk` | Exit insert mode | Faster than reaching for `<Esc>` |

### Normal Mode Essentials

| Key | Action | Notes |
|-----|--------|-------|
| `<Space>nh` | Clear search highlights | After using `/` search |
| `<Space>+` | Increment number | Cursor on number |
| `<Space>-` | Decrement number | Cursor on number |
| `<C-s>` | Save file | Quick save |
| `<Space>q` | Quit current window | |
| `<Space>Q` | Quit all without saving | Force quit |
| `<C-a>` | Select all | `gg<S-v>G` |

---

## File Navigation & Management

### Telescope (Fuzzy Finder)

| Key | Action | Use Case |
|-----|--------|----------|
| `<Space>ff` | Find files | **Most used** - Open any file in project |
| `<Space>fr` | Recent files | Quick access to recently opened |
| `<Space>fs` | Live grep | Search text across all files |
| `<Space>fc` | Grep word under cursor | Find all occurrences of current word |
| `<Space>fb` | Find buffers | Switch between open files |
| `<Space>fh` | Help tags | Search Neovim documentation |

**Telescope Navigation (in picker):**
- `<C-j>` / `<C-k>` - Move down/up
- `<C-q>` - Send to quickfix list
- `<Esc>` or `q` - Close

### File Explorer (nvim-tree)

| Key | Action | Use Case |
|-----|--------|----------|
| `<Space>ee` | Toggle file explorer | Open/close file tree |
| `<Space>ef` | Toggle on current file | Open tree focused on current file |
| `<Space>ec` | Collapse file explorer | Collapse all folders |
| `<Space>er` | Refresh file explorer | Reload directory |

**Inside nvim-tree:**
- `<CR>` - Open file/folder
- `a` - Create file/folder
- `r` - Rename
- `d` - Delete
- `x` - Cut
- `c` - Copy
- `p` - Paste
- `y` - Copy filename
- `Y` - Copy relative path
- `gy` - Copy absolute path
- `?` - Show help

---

## Window Management

### Splits

| Key | Action | Usage |
|-----|--------|-------|
| `<Space>sv` | Split vertically | Side-by-side windows |
| `<Space>sh` | Split horizontally | Stacked windows |
| `<Space>se` | Make splits equal size | Balance window sizes |
| `<Space>sx` | Close current split | Remove window |

### Window Navigation

| Key | Action | Notes |
|-----|--------|-------|
| `<C-h>` | Go to left window | **Fast navigation** |
| `<C-j>` | Go to lower window | |
| `<C-k>` | Go to upper window | |
| `<C-l>` | Go to right window | |

**Pro Tip:** With vim-tmux-navigator, these work across tmux panes too!

### Window Resizing

| Key | Action |
|-----|--------|
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

---

## Tab Management

| Key | Action | Usage |
|-----|--------|-------|
| `<Space>to` | Open new tab | Fresh workspace |
| `<Space>tx` | Close current tab | |
| `<Space>tn` | Go to next tab | Cycle forward |
| `<Space>tp` | Go to previous tab | Cycle backward |
| `<Space>tf` | Open current buffer in new tab | Clone current file to new tab |

---

## LSP (Language Server) Keybindings

### Navigation

| Key | Action | Use Case |
|-----|--------|----------|
| `gd` | Go to definition | **Most used** - Jump to where something is defined |
| `gD` | Go to declaration | Jump to declaration (C/C++) |
| `gR` | Show references | Find all usages of symbol |
| `gi` | Go to implementations | Find interface implementations |
| `gt` | Go to type definition | Jump to type definition |
| `K` | Show hover documentation | View function signature, docs |

**Return from jump:** `<C-o>` (jump back), `<C-i>` (jump forward)

### Code Actions

| Key | Action | Use Case |
|-----|--------|----------|
| `<Space>ca` | Code actions | Auto-import, quick fixes, refactor suggestions |
| `<Space>rn` | Rename symbol | Rename variable/function across project |

### Diagnostics (Errors/Warnings)

| Key | Action | Use Case |
|-----|--------|----------|
| `<Space>d` | Show line diagnostic | View error message under cursor |
| `<Space>D` | Show buffer diagnostics | List all errors in file |
| `]d` | Next diagnostic | Jump to next error |
| `[d` | Previous diagnostic | Jump to previous error |
| `<Space>rs` | Restart LSP | Fix if LSP stops working |

---

## Scrolling & Search

### Smart Scrolling (Centered)

| Key | Action | Notes |
|-----|--------|-------|
| `<C-d>` | Scroll down (centered) | Half page down, cursor centered |
| `<C-u>` | Scroll up (centered) | Half page up, cursor centered |
| `n` | Next search result (centered) | Better visibility |
| `N` | Previous search result (centered) | |

### Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `<Space>nh` | Clear search highlights |

---

## Visual Mode Enhancements

### Indentation (Visual Mode)

| Key | Action | Benefit |
|-----|--------|---------|
| `<` | Indent left | Stays in visual mode (reselects) |
| `>` | Indent right | Can repeat with `.` |

Press `<` or `>` multiple times to continue indenting the same selection.

### Move Text (Visual Mode)

| Key | Action | Use Case |
|-----|--------|----------|
| `J` | Move selected lines down | Reorder code blocks |
| `K` | Move selected lines up | |

Auto-indents after moving.

---

## Register & Clipboard Tricks

### Paste/Delete Without Yanking

| Key | Action | Why |
|-----|--------|-----|
| `<Space>p` (visual) | Paste without yanking | Replace text without losing clipboard |
| `<Space>d` | Delete to void register | Delete without affecting clipboard |

**Example workflow:**
1. Yank some text: `yiw`
2. Delete other text: `<Space>d` (doesn't overwrite clipboard)
3. Paste original text: `p`

---

## Your Configuration Settings

### Options Configured

- **Relative line numbers:** Enabled (jump with `5j`, `10k`, etc.)
- **Tab width:** 2 spaces
- **System clipboard:** Enabled (`y` copies to system, `p` pastes from system)
- **Cursor line:** Highlighted
- **Smart case search:** Case-insensitive unless you type uppercase
- **No swap files:** Disabled
- **Persistent undo:** Enabled
- **Scroll offset:** 8 lines above/below cursor
- **Auto-save:** Not automatic (use `<C-s>`)

---

## Workflow Patterns with Your Setup

### Pattern 1: Find and Edit File

```
<Space>ff → type filename → <CR> → make edits → <C-s>
```

### Pattern 2: Search Across Project

```
<Space>fs → type search term → <CR> → navigate with <C-j>/<C-k> → <CR> to open
```

### Pattern 3: Jump to Definition and Back

```
cursor on function → gd → read code → <C-o> (back)
```

### Pattern 4: Fix Error

```
]d (jump to error) → <Space>d (view diagnostic) → <Space>ca (code action) → select fix
```

### Pattern 5: Rename Variable

```
cursor on variable → <Space>rn → type new name → <CR>
```

### Pattern 6: Multi-file Editing

```
<Space>ff → open file1 → <Space>ff → open file2 → <Space>fb → switch between buffers
```

### Pattern 7: Split Screen Compare

```
<Space>sv → <Space>ff → open file2 → <C-h>/<C-l> to switch
```

### Pattern 8: File Tree Workflow

```
<Space>ee → navigate with j/k → <CR> to open → <Space>ee to close tree
```

---

## Quick Reference Card

### Top 10 Most Used (Memorize These)

1. `<Space>ff` - Find files
2. `<Space>fs` - Search in files
3. `gd` - Go to definition
4. `<C-o>` - Jump back
5. `<Space>ca` - Code actions
6. `<C-s>` - Save
7. `<C-h/j/k/l>` - Navigate windows
8. `]d` / `[d` - Next/prev error
9. `<Space>rn` - Rename
10. `jk` - Exit insert mode

### Second Tier (Very Useful)

11. `<Space>fb` - Switch buffers
12. `<Space>ee` - Toggle file explorer
13. `K` - Hover documentation
14. `<Space>d` - Show diagnostic
15. `<Space>sv/sh` - Split windows
16. `gR` - Find references
17. `<Space>fr` - Recent files
18. `*` - Search word under cursor
19. `<C-d>/<C-u>` - Scroll (centered)
20. `<Space>p` - Paste without yank (visual)

---

## Customization Tips

Your config is at: `~/.config/nvim/lua/kalki/core/keybinds.lua`

To add new keybindings:
```lua
keymap.set("n", "<leader>KEY", "COMMAND", { desc = "Description" })
```

To see all keybindings:
```vim
:Telescope keymaps
```

Or with which-key (if configured):
```vim
<Space>  (then wait - popup shows all leader bindings)
```

---

## Plugin-Specific Commands

### Commands to Run

```vim
:Mason                  " Manage LSP servers
:Lazy                   " Manage plugins
:checkhealth            " Diagnose issues
:LspInfo                " Check LSP status
:LspRestart             " Restart LSP (or <Space>rs)
```

---

## Tips for Your Setup

1. **Use `jk` religiously** - It's faster than `<Esc>` and your hands stay on home row
2. **`<Space>ff` for everything** - Don't navigate manually, use fuzzy find
3. **`gd` then `<C-o>`** - Jump to definition and back is your bread and butter
4. **`<Space>fs`** - Project-wide search is faster than grep
5. **System clipboard is enabled** - `y` to copy, `p` to paste works with system
6. **Centered scrolling** - Your `<C-d>/<C-u>` keep cursor centered, less eye strain
7. **Relative numbers** - Use `10j` to jump 10 lines down, `5k` for 5 up
8. **`<Space>d` delete** - Use this instead of `d` to avoid clobbering clipboard
9. **Window navigation** - `<C-h/j/k/l>` works with tmux too (vim-tmux-navigator)
10. **LSP is your IDE** - `<Space>ca` for imports, `<Space>rn` for renames

---

**Next:** Practice these bindings in real code, refer back to this file when stuck. Print this out or keep it open in a split!
