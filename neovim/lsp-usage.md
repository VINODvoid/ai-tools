# LSP Usage Mastery

The Language Server Protocol (LSP) transforms Neovim into a modern IDE. Master these patterns for professional development.

## Your LSP Configuration

Your setup uses `nvim-lspconfig` with Mason for LSP server management.

**Configured keybindings (when LSP is active):**

| Key | Action |
|-----|--------|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to declaration |
| `gR` | References (Telescope) |
| `gi` | Implementations (Telescope) |
| `gt` | Type definition (Telescope) |
| `K` | Hover documentation |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename symbol |
| `<Space>d` | Line diagnostics |
| `<Space>D` | Buffer diagnostics (Telescope) |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<Space>rs` | Restart LSP |

---

## Core LSP Workflows

### 1. Understanding Code (Navigate & Read)

#### Go to Definition (`gd`)

**Most used LSP command.**

```vim
" Cursor on function call → gd → jump to definition
cursor on: calculatePrice(100, 0.2)
→ gd
→ jumps to function definition
→ <C-o> to return
```

**With Telescope:** Opens in Telescope picker if multiple definitions found.

#### Hover Documentation (`K`)

```vim
" View function signature, parameter types, docs
cursor on: Array.map
→ K
→ see documentation popup
```

**Press `K` twice:** Jump into hover window (can scroll, copy text).

#### Find References (`gR`)

```vim
" Find all usages of symbol
cursor on variable: userId
→ gR
→ Telescope shows all references
→ <CR> to jump to selected reference
```

**Use case:** Before renaming, check all usages.

#### Go to Implementation (`gi`)

```vim
" Find concrete implementations of interface/abstract
cursor on interface: UserService
→ gi
→ see all classes implementing UserService
```

**Languages:** Works best with TypeScript, Java, Rust, Go.

#### Go to Type Definition (`gt`)

```vim
" Jump to type/interface definition
cursor on: const user: User = ...
→ gt
→ jumps to User type definition
```

---

### 2. Code Actions (`<Space>ca`)

LSP suggests fixes and refactorings.

#### Auto-Import Missing Symbols

```vim
" You type function not imported
function: formatDate(...)
→ <Space>ca
→ select "Import from..."
→ import added automatically
```

#### Quick Fixes

```vim
" LSP shows error
[Error] Property 'name' does not exist on type 'User'
→ <Space>ca
→ select "Add property 'name' to User"
```

#### Refactoring Suggestions

```vim
" Extract variable, inline, etc.
select code → <Space>ca
→ see available refactorings:
  - Extract to function
  - Inline variable
  - Convert to template string
```

#### Organize Imports

```vim
" Remove unused imports, sort imports
<Space>ca
→ "Organize imports"
```

**Some LSPs:** Auto-organize on save (like `gopls` for Go).

---

### 3. Rename Refactoring (`<Space>rn`)

**Smart rename across entire project.**

```vim
cursor on variable: oldName
→ <Space>rn
→ type: newName
→ <CR>
→ all references renamed (even in other files!)
```

**Why better than regex:**
- Scope-aware (doesn't rename unrelated symbols with same name)
- Type-aware (renames in correct contexts)
- Handles imports/exports
- Preview changes before applying

**Production workflow:**
1. `gR` → view all references
2. Verify scope is correct
3. `<Space>rn` → rename
4. Review changes (`:Telescope lsp_document_symbols`)

---

### 4. Diagnostics (Errors & Warnings)

#### Navigate Diagnostics

```vim
]d        " Jump to next diagnostic
[d        " Jump to previous diagnostic
```

**Workflow:**
```vim
Open file with errors
]d → jump to first error
<Space>d → view error details
<Space>ca → apply fix
]d → next error
```

#### View Diagnostics

```vim
<Space>d    " Float window with error under cursor
<Space>D    " Telescope: all diagnostics in buffer
```

**Telescope diagnostics:**
```vim
<Space>D → see all errors/warnings
→ <C-j>/<C-k> navigate
→ <CR> jump to error
```

#### Filter Diagnostics

```vim
:lua vim.diagnostic.disable()    " Hide all diagnostics
:lua vim.diagnostic.enable()     " Show diagnostics
```

**Temporary peace:** Disable while prototyping, re-enable to fix.

---

### 5. Formatting

**Format current buffer:**

```vim
:lua vim.lsp.buf.format()
```

**Common mapping (check your config):**
```vim
<Leader>f → format buffer
```

**Format on save (configure in LSP setup):**
```lua
-- In lspconfig.lua
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})
```

**Per-language formatters:**
- JavaScript/TypeScript: Prettier, ESLint
- Python: Black, autopep8
- Go: `gopls` (auto-formats on save)
- Rust: `rustfmt` (via rust-analyzer)
- Lua: stylua

---

## LSP by Language

### JavaScript/TypeScript (tsserver, vtsls)

```vim
" Auto-import
<Space>ca → "Add import from..."

" Organize imports
<Space>ca → "Organize imports"

" Convert to arrow function
select function → <Space>ca → "Convert to arrow function"

" Extract to function
select code → <Space>ca → "Extract to function"

" Inline variable
cursor on variable → <Space>ca → "Inline variable"

" Add missing type annotation
cursor on parameter → <Space>ca → "Infer type from usage"
```

### Python (pylsp, pyright)

```vim
" Add import
cursor on undefined name → <Space>ca → "Import from..."

" Extract variable
select expression → <Space>ca → "Extract variable"

" Type stub generation (pyright)
<Space>ca → "Create type stub"
```

### Go (gopls)

```vim
" Add import
cursor on function → <Space>ca → "Import package"

" Fill struct
cursor in struct{} → <Space>ca → "Fill struct"

" Extract function
select code → <Space>ca → "Extract function"

" Format + organize on save (automatic with gopls)
:w → auto-formats and organizes imports
```

### Rust (rust-analyzer)

```vim
" Auto-import
cursor on unresolved item → <Space>ca → "Import..."

" Expand macro
cursor on macro → <Space>ca → "Expand macro recursively"

" Add missing impl
cursor on trait → <Space>ca → "Implement missing members"

" Extract function
select code → <Space>ca → "Extract into function"

" Inline function
cursor on function call → <Space>ca → "Inline into callers"
```

---

## Advanced LSP Patterns

### Pattern 1: Explore Unknown Codebase

```vim
" 1. Find entry point
<Space>ff → main.ts

" 2. Jump through code
cursor on function → gd → read → gd deeper → <C-o> <C-o> back

" 3. Find all usages
cursor on key function → gR → understand callers

" 4. Check type definitions
cursor on interface → gt → see structure
```

### Pattern 2: Refactor API Endpoint

```vim
" 1. Find all usages
cursor on /api/users → gR

" 2. Check impact
review all references in Telescope

" 3. Rename
<Space>rn → /api/v2/users

" 4. Update types
cursor on response type → gd → update
```

### Pattern 3: Fix Type Errors

```vim
" 1. Jump to first error
]d

" 2. View error
<Space>d

" 3. Quick fix
<Space>ca → select fix

" 4. Next error
]d → repeat
```

### Pattern 4: Add Feature with Auto-Import

```vim
" 1. Type code using new library
import { useState }  " cursor on useState
→ <Space>ca → auto-import from 'react'

" 2. Continue coding
use other functions → <Space>ca → auto-import each

" 3. Organize
<Space>ca → "Organize imports" → clean up
```

### Pattern 5: Understand Function Chain

```vim
" Code: user.profile.settings.theme
cursor on theme → gd → see type definition
cursor on settings → gd → see interface
cursor on profile → gd → see structure
<C-o> <C-o> <C-o> → back to original
```

---

## LSP Management

### Check LSP Status

```vim
:LspInfo           " See attached LSP servers
:checkhealth lsp   " Diagnose LSP issues
```

### Restart LSP

**Your keybinding:** `<Space>rs`

**Manual:**
```vim
:LspRestart
```

**When to restart:**
- After changing LSP config
- After installing new language server
- When completions/diagnostics stop working

### Install Language Servers (Mason)

```vim
:Mason

" Inside Mason:
i → install server
u → update server
X → uninstall server
/ → search
```

**Common servers:**
- `typescript-language-server` (TypeScript/JavaScript)
- `lua-language-server` (Lua)
- `pyright` (Python)
- `rust-analyzer` (Rust)
- `gopls` (Go)
- `clangd` (C/C++)
- `jdtls` (Java)

### Configure LSP Server

Edit: `~/.config/nvim/lua/kalki/plugins/lsp/lspconfig.lua`

Example:
```lua
require('lspconfig').tsserver.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
      },
    },
  },
})
```

---

## Completions (nvim-cmp)

Your setup includes `nvim-cmp` for completions.

### Completion Sources

- LSP (primary)
- Buffer words
- File paths
- Snippets (if configured)

### Navigate Completions

```vim
<C-n>     " Next completion
<C-p>     " Previous completion
<C-y>     " Confirm selection (default: <CR>)
<C-e>     " Close completion menu
```

**Check your nvim-cmp config** for exact keybindings.

---

## Signature Help

See function parameters as you type.

```vim
" Inside function call
calculatePrice(|cursor here)
→ LSP shows: calculatePrice(amount: number, discount: number)
```

**Trigger manually:**
```vim
:lua vim.lsp.buf.signature_help()
```

---

## Inlay Hints (Modern Feature)

Show type hints inline (like in VSCode).

```vim
:lua vim.lsp.inlay_hint.enable(true)

" Toggle
:lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
```

**Supported languages:** Rust, TypeScript, Go (with recent LSP versions).

**Example:**
```typescript
// Before
const result = calculatePrice(100, 0.2)

// With inlay hints
const result: number = calculatePrice(amount: 100, discount: 0.2)
```

---

## Workspace Symbols

Search symbols across entire workspace.

```vim
:Telescope lsp_workspace_symbols
→ type symbol name
→ jump to definition
```

**Use case:** Find function definition without knowing which file.

---

## Call Hierarchy

See call chain (who calls this, what does this call).

```vim
:lua vim.lsp.buf.incoming_calls()   " Who calls this function
:lua vim.lsp.buf.outgoing_calls()   " What does this function call
```

**Use case:** Understand function impact before modifying.

---

## LSP Troubleshooting

### LSP Not Working

1. Check LSP is running:
   ```vim
   :LspInfo
   ```

2. Check health:
   ```vim
   :checkhealth lsp
   ```

3. Restart LSP:
   ```vim
   <Space>rs
   ```

4. Check server is installed:
   ```vim
   :Mason
   ```

5. View LSP logs:
   ```vim
   :lua vim.cmd('e ' .. vim.lsp.get_log_path())
   ```

### Completions Not Showing

- Check `nvim-cmp` is configured
- Verify LSP attached: `:LspInfo`
- Check completion sources in cmp config

### Diagnostics Not Showing

- Check `vim.diagnostic` is enabled
- Verify diagnostic signs configured
- Try `:lua vim.diagnostic.enable()`

### Slow LSP

- Large project? Exclude `node_modules`, `dist`, `build`
- Configure LSP to ignore large directories
- Use project-specific LSP config

---

## Pro LSP Tips

1. **`gd` + `<C-o>` pattern** - Jump and return constantly
2. **Use `gR` before renaming** - Verify scope
3. **`<Space>ca` for everything** - Check code actions often
4. **Learn your language's LSP** - Each has unique features
5. **Telescope integration** - Definitions/references in picker
6. **Format on save** - Set it up, forget it
7. **Inlay hints for learning** - Enable when exploring new codebase
8. **Workspace symbols** - Faster than file search for known symbol
9. **Restart LSP liberally** - Cheap operation, fixes many issues
10. **Check `:LspInfo` often** - Know what servers are active

---

## Comparison: LSP vs. Traditional Vim

| Task | Traditional Vim | LSP Way |
|------|-----------------|---------|
| Find definition | `grep`, `tags` | `gd` |
| Find usages | `:grep`, manual search | `gR` |
| Rename symbol | `:%s`, multi-file risky | `<Space>rn` (safe, scope-aware) |
| Auto-import | Manual typing | `<Space>ca` |
| View docs | Google, `man` | `K` |
| Type info | Guess, read code | Hover, inlay hints |
| Refactor | Manual, error-prone | Code actions |

**LSP is the reason Neovim competes with full IDEs.**

---

**Next**: See [Mistakes to Avoid](mistakes-to-avoid.md) for common pitfalls, or use [Cheatsheet](cheatsheet.md) as quick reference.
