# Tmux Cheatsheet

Quick reference for tmux commands and key bindings.

**Prefix:** `Ctrl-a`

---

## Command Line

```bash
# Sessions
tmux                          # Start new session
tmux new -s name              # Start named session
tmux ls                       # List sessions
tmux attach                   # Attach to last session
tmux attach -t name           # Attach to named session
tmux kill-session -t name     # Kill session
tmux kill-server              # Kill all sessions

# Windows
tmux list-windows             # List windows
tmux select-window -t :0-9    # Select window by number

# Panes
tmux split-window -h          # Split horizontally
tmux split-window -v          # Split vertically
```

---

## Sessions

| Key | Action |
|-----|--------|
| `Ctrl-a d` | Detach session |
| `Ctrl-a $` | Rename session |
| `Ctrl-a s` | List sessions |
| `Ctrl-a (` | Previous session |
| `Ctrl-a )` | Next session |

---

## Windows

| Key | Action |
|-----|--------|
| `Ctrl-a c` | Create window |
| `Ctrl-a ,` | Rename window |
| `Ctrl-a w` | List windows |
| `Ctrl-a n` | Next window |
| `Ctrl-a p` | Previous window |
| `Ctrl-a 0-9` | Jump to window # |
| `Ctrl-a &` | Kill window |
| `Ctrl-a f` | Find window |
| `Ctrl-a .` | Move window |

---

## Panes

| Key | Action |
|-----|--------|
| `Ctrl-a \|` | Split vertical |
| `Ctrl-a -` | Split horizontal |
| `Ctrl-a h` | Go to left pane |
| `Ctrl-a j` | Go to bottom pane |
| `Ctrl-a k` | Go to top pane |
| `Ctrl-a l` | Go to right pane |
| `Ctrl-a H` | Resize left |
| `Ctrl-a J` | Resize down |
| `Ctrl-a K` | Resize up |
| `Ctrl-a L` | Resize right |
| `Ctrl-a x` | Kill pane |
| `Ctrl-a z` | Toggle zoom |
| `Ctrl-a {` | Move pane left |
| `Ctrl-a }` | Move pane right |
| `Ctrl-a space` | Cycle layouts |
| `Ctrl-a q` | Show pane numbers |
| `Ctrl-a o` | Next pane |
| `Ctrl-a ;` | Last pane |
| `Ctrl-a !` | Break pane to window |

---

## Copy Mode

| Key | Action |
|-----|--------|
| `Ctrl-a Escape` | Enter copy mode |
| `Ctrl-a p` | Paste buffer |
| `q` | Quit copy mode |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `v` | Begin selection |
| `y` | Copy selection |
| `Ctrl-v` | Rectangle selection |
| `Space` | Start selection |
| `Enter` | Copy selection |

---

## Misc

| Key | Action |
|-----|--------|
| `Ctrl-a ?` | List all bindings |
| `Ctrl-a :` | Command prompt |
| `Ctrl-a r` | Reload config |
| `Ctrl-a t` | Show time |
| `Ctrl-a i` | Display info |

---

## Command Mode

Press `Ctrl-a :` then:

```bash
# Window management
rename-window name              # Rename window
swap-window -s 2 -t 1          # Swap windows
move-window -t 0               # Move to position 0

# Pane management
resize-pane -D 10              # Resize down 10 lines
resize-pane -U 10              # Resize up 10 lines
resize-pane -L 10              # Resize left 10 columns
resize-pane -R 10              # Resize right 10 columns
swap-pane -U                   # Swap with previous pane
swap-pane -D                   # Swap with next pane

# Layout
select-layout even-horizontal   # Evenly space horizontal
select-layout even-vertical     # Evenly space vertical
select-layout main-horizontal   # Large pane on top
select-layout main-vertical     # Large pane on left
select-layout tiled            # Grid layout

# Session
detach-client                  # Detach current client
```

---

## Mouse Support

Mouse is **enabled** by default in this config:

- Click pane to select
- Click window name to switch
- Drag pane border to resize
- Scroll to navigate history
- Right-click for menu (in some terminals)

Disable temporarily:
```bash
tmux set -g mouse off
```

---

## Scripting Examples

```bash
# Create session with windows
tmux new-session -d -s dev
tmux rename-window -t dev:0 'editor'
tmux new-window -t dev:1 -n 'server'
tmux new-window -t dev:2 -n 'logs'
tmux attach -t dev

# Create session with panes
tmux new-session -d -s work
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux attach -t work

# Send commands to pane
tmux send-keys -t dev:1 'npm start' C-m
tmux send-keys -t dev:2 'tail -f app.log' C-m
```

---

## Quick Layouts

```bash
# Three pane layout
Ctrl-a "                # Split horizontal
Ctrl-a %                # Split vertical (on new pane)

# Four pane grid
Ctrl-a "                # Split horizontal
Ctrl-a : select-layout tiled

# Main + sidebar
Ctrl-a %                # Split vertical
Ctrl-a : select-layout main-vertical
```

---

## Pro Tips

1. **Prefix twice:** `Ctrl-a Ctrl-a` sends prefix to nested tmux
2. **Quick commands:** Type commands without prefix in command mode
3. **Session workflows:** One session per project
4. **Pane synchronization:** `Ctrl-a : setw synchronize-panes` - send input to all panes
5. **Clock:** `Ctrl-a t` - full screen clock (exit with any key)

---

**Print this cheatsheet and keep it handy until muscle memory kicks in!**
