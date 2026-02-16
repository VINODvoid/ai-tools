# Tmux Cheatsheet

Quick reference for tmux commands and key bindings.

**Prefix:** `Ctrl-a`

---

## Command Line

```bash
# Sessions
tmux                            # Start new session
tmux new -s name                # Start named session
tmux ls                         # List all sessions
tmux attach                     # Attach to last session
tmux attach -t name             # Attach to named session
tmux kill-session -t name       # Kill specific session
tmux kill-server                # Kill all sessions

# Windows
tmux list-windows               # List windows in session
tmux select-window -t :0-9      # Select window by number

# Panes
tmux split-window -h            # Split horizontally (side-by-side)
tmux split-window -v            # Split vertically (top-bottom)
```

---

## Sessions

| Binding | Action |
|---------|--------|
| `Ctrl-a d` | Detach from session |
| `Ctrl-a $` | Rename current session |
| `Ctrl-a s` | List sessions (interactive) |
| `Ctrl-a (` | Switch to previous session |
| `Ctrl-a )` | Switch to next session |

---

## Windows

| Binding | Action |
|---------|--------|
| `Ctrl-a c` | Create new window |
| `Ctrl-a ,` | Rename current window |
| `Ctrl-a w` | List all windows |
| `Ctrl-a n` | Next window |
| `Ctrl-a p` | Previous window |
| `Ctrl-a 0-9` | Jump to window # |
| `Ctrl-a &` | Kill current window |
| `Ctrl-a f` | Find window by name |
| `Ctrl-a .` | Move window to index |

---

## Panes

| Binding | Action |
|---------|--------|
| `Ctrl-a \|` | Split vertically |
| `Ctrl-a -` | Split horizontally |
| `Ctrl-a h` | Go to left pane |
| `Ctrl-a j` | Go to bottom pane |
| `Ctrl-a k` | Go to top pane |
| `Ctrl-a l` | Go to right pane |
| `Ctrl-a H` | Resize pane left (5 cells) |
| `Ctrl-a J` | Resize pane down (5 cells) |
| `Ctrl-a K` | Resize pane up (5 cells) |
| `Ctrl-a L` | Resize pane right (5 cells) |
| `Ctrl-a x` | Kill current pane |
| `Ctrl-a m` | Toggle pane zoom (maximize) |
| `Ctrl-a {` | Move pane left |
| `Ctrl-a }` | Move pane right |
| `Ctrl-a space` | Cycle through layouts |
| `Ctrl-a q` | Show pane numbers |
| `Ctrl-a o` | Next pane |
| `Ctrl-a ;` | Last active pane |
| `Ctrl-a !` | Break pane into new window |

---

## Copy Mode (Vim-style)

| Binding | Action |
|---------|--------|
| `Ctrl-a Escape` or `Ctrl-a [` | Enter copy mode |
| `Ctrl-a p` | Paste from buffer |
| `q` | Quit copy mode |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `v` | Begin selection |
| `y` | Copy selection and exit |
| `Ctrl-v` | Rectangle selection |
| `Space` | Begin selection (alternate) |
| `Enter` | Copy and exit (alternate) |

---

## Plugin Commands (TPM)

| Binding | Action |
|---------|--------|
| `Ctrl-a I` | Install plugins (capital I) |
| `Ctrl-a U` | Update plugins (capital U) |
| `Ctrl-a alt-u` | Uninstall removed plugins |

### Session Persistence (Resurrect)

| Binding | Action |
|---------|--------|
| `Ctrl-a Ctrl-s` | Save session manually |
| `Ctrl-a Ctrl-r` | Restore session |

**Note:** Sessions auto-save every 15 minutes with continuum!

---

## System Commands

| Binding | Action |
|---------|--------|
| `Ctrl-a r` | Reload configuration |
| `Ctrl-a ?` | List all key bindings |
| `Ctrl-a :` | Command prompt |
| `Ctrl-a t` | Show clock (full screen) |

---

## Command Mode

Press `Ctrl-a :` then type:

```bash
# Window management
rename-window name                # Rename current window
swap-window -s 2 -t 1             # Swap window 2 with 1
move-window -t 0                  # Move window to position 0

# Pane management
resize-pane -D 10                 # Resize down 10 lines
resize-pane -U 10                 # Resize up 10 lines
resize-pane -L 10                 # Resize left 10 columns
resize-pane -R 10                 # Resize right 10 columns
swap-pane -U                      # Swap with previous pane
swap-pane -D                      # Swap with next pane

# Layouts
select-layout even-horizontal     # Equal width, horizontal
select-layout even-vertical       # Equal height, vertical
select-layout main-horizontal     # Large pane on top
select-layout main-vertical       # Large pane on left
select-layout tiled               # Grid layout (equal)

# Session management
detach-client                     # Detach current client
rename-session name               # Rename current session

# Pane synchronization
setw synchronize-panes on         # Type in all panes at once
setw synchronize-panes off        # Disable synchronization
```

---

## Mouse Support

Mouse is **enabled** by default:

- **Click pane** to select it
- **Click window** name to switch
- **Drag border** to resize panes
- **Scroll** to navigate history
- **Right-click** for context menu (terminal-dependent)

Temporarily disable:
```bash
Ctrl-a : set -g mouse off
```

---

## Scripting Examples

### Create Session with Windows

```bash
tmux new-session -d -s dev
tmux rename-window -t dev:0 'editor'
tmux new-window -t dev:1 -n 'server'
tmux new-window -t dev:2 -n 'logs'
tmux attach -t dev
```

### Create Session with Panes

```bash
tmux new-session -d -s work
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux attach -t work
```

### Send Commands to Panes

```bash
# Send to specific window:pane
tmux send-keys -t dev:1 'npm start' C-m
tmux send-keys -t dev:2 'tail -f app.log' C-m
```

---

## Quick Layouts

### Three Pane Layout (Editor + 2 Shells)

```
┌─────────────────┬─────────────┐
│                 │             │
│     Editor      │   Shell 1   │
│                 ├─────────────┤
│                 │   Shell 2   │
└─────────────────┴─────────────┘
```

```bash
Ctrl-a |              # Split vertical
Ctrl-a l              # Move right
Ctrl-a -              # Split horizontal
```

### Four Pane Grid

```
┌─────────────┬─────────────┐
│             │             │
│   Pane 1    │   Pane 2    │
├─────────────┼─────────────┤
│   Pane 3    │   Pane 4    │
└─────────────┴─────────────┘
```

```bash
Ctrl-a -              # Split horizontal
Ctrl-a |              # Split right pane vertical
Ctrl-a k              # Go to top pane
Ctrl-a |              # Split top pane vertical
```

### Main + Sidebar

```
┌──────────────────┬──────┐
│                  │      │
│      Main        │ Side │
│                  │      │
└──────────────────┴──────┘
```

```bash
Ctrl-a |              # Split vertical
Ctrl-a : select-layout main-vertical
```

---

## Pro Tips

1. **Nested tmux:** `Ctrl-a Ctrl-a` sends prefix to remote tmux session
2. **Quick switch:** Use `Ctrl-a s` for interactive session list
3. **One session per project:** Maintain separate contexts
4. **Pane sync:** `Ctrl-a : setw synchronize-panes` to type in all panes
5. **Copy mode:** Use `/` and `?` to search scrollback efficiently
6. **Clock mode:** `Ctrl-a t` for full-screen clock (any key to exit)
7. **Muscle memory:** Practice daily - becomes second nature in a week

---

## Configuration Reload

After editing `~/.tmux.conf`:

```bash
# Inside tmux
Ctrl-a r

# From terminal
tmux source-file ~/.tmux.conf
```

---

## PowerKit Theme Quick Reference

Switch themes by editing `~/.tmux.conf`:

```bash
set -g @powerkit_theme "nord"         # Current (cool, minimal)
set -g @powerkit_theme "catppuccin"   # Pastel, modern
set -g @powerkit_theme "tokyo-night"  # Dark, vibrant
set -g @powerkit_theme "dracula"      # Dark, colorful
set -g @powerkit_theme "gruvbox"      # Warm, retro
```

Then reload: `Ctrl-a r`

---

**Print this cheatsheet and keep it visible until muscle memory develops!**

**Most Used Commands:**
- `tmux new -s <name>` - Start named session
- `Ctrl-a d` - Detach
- `tmux attach -t <name>` - Reattach
- `Ctrl-a |` and `Ctrl-a -` - Split panes
- `Ctrl-a h/j/k/l` - Navigate panes
- `Ctrl-a r` - Reload config
