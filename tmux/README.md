# Tmux - Terminal Multiplexer Mastery

## Overview

Tmux is a powerful terminal multiplexer that allows you to:
- Run multiple terminal sessions in a single window
- Detach and reattach sessions (persistent sessions)
- Split windows into panes for multitasking
- Share sessions across multiple connections
- Boost productivity with keyboard-driven workflows

**Version Installed:** 3.6a
**Config Location:** `~/.tmux.conf`

---

## Quick Start

### Essential Commands

```bash
# Start new session
tmux

# Start named session
tmux new -s mysession

# List sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Detach from session (inside tmux)
Ctrl-a d

# Kill session
tmux kill-session -t mysession
```

---

## Key Bindings Reference

**Prefix Key:** `Ctrl-a` (customized from default `Ctrl-b`)

### Session Management
- `Ctrl-a d` - Detach from session
- `Ctrl-a $` - Rename session
- `Ctrl-a s` - List and switch sessions

### Window Management
- `Ctrl-a c` - Create new window
- `Ctrl-a ,` - Rename window
- `Ctrl-a w` - List windows
- `Ctrl-a n` - Next window
- `Ctrl-a p` - Previous window
- `Ctrl-a 0-9` - Switch to window by number
- `Ctrl-a &` - Kill window
- `Ctrl-a Ctrl-h` - Previous window (quick)
- `Ctrl-a Ctrl-l` - Next window (quick)

### Pane Management
- `Ctrl-a |` - Split vertically
- `Ctrl-a -` - Split horizontally
- `Ctrl-a h/j/k/l` - Navigate panes (Vim-style)
- `Ctrl-a H/J/K/L` - Resize panes
- `Ctrl-a x` - Kill pane
- `Ctrl-a z` - Zoom/unzoom pane
- `Ctrl-a {` - Move pane left
- `Ctrl-a }` - Move pane right
- `Ctrl-a space` - Cycle through layouts
- `Ctrl-a q` - Show pane numbers

### Copy Mode (Vim-style)
- `Ctrl-a Escape` - Enter copy mode
- `v` - Begin selection
- `y` - Copy selection
- `Ctrl-v` - Rectangle selection
- `Ctrl-a p` - Paste

### Modern Features
- `Ctrl-a g` - Git status popup window
- `Ctrl-a G` - Generic popup terminal
- `Ctrl-a S` - Toggle status bar
- `Ctrl-a s` - Synchronize panes (type in all at once)
- `Ctrl-a C-c` - Create new session
- `Ctrl-a C-f` - Find and switch session
- `Ctrl-a X` - Kill current session
- `Ctrl-a f` - Tmux-fzf fuzzy finder

### Misc
- `Ctrl-a r` - Reload config
- `Ctrl-a ?` - List all key bindings
- `Ctrl-a :` - Enter command mode
- `Ctrl-a t` - Show time

---

## Configuration Highlights

### 🎨 Visual Features
- **True color support** for modern terminals
- **Catppuccin Mocha theme** - Beautiful soothing pastel colors (2.8k+ stars)
- **Informative status bar** with session, directory, and time
- **Clean, modern window indicators**
- **Multiple theme variants** available (Mocha, Frappé, Macchiato, Latte)

### ⌨️ Productivity Features
- **Prefix changed to Ctrl-a** - easier to reach than Ctrl-b
- **Vim-style navigation** - h/j/k/l for pane movement
- **Mouse support enabled** - click to select panes/windows
- **Smart pane splitting** - opens in current directory
- **50,000 line scrollback** - extensive history
- **No escape delay** - instant response
- **Auto-renumbering** - windows stay sequential

### 🔧 Advanced Features
- **Aggressive resize** - optimized for multi-client usage
- **Activity monitoring** - track changes in background windows
- **Focus events** - better integration with editors
- **Terminal title setting** - clear window titles

---

## Common Workflows

### Development Setup
```bash
# Create development session
tmux new -s dev

# Split into 3 panes:
Ctrl-a |    # Split vertically
Ctrl-a -    # Split horizontally on right side

# Now you have:
# - Left: Editor (vim/nvim)
# - Top right: Git/commands
# - Bottom right: Server/logs
```

### Multiple Projects
```bash
# Project 1
tmux new -s project1

# Project 2
tmux new -s project2

# Switch between them
Ctrl-a s    # List and select
# or from terminal
tmux attach -t project1
```

### Pair Programming
```bash
# Person 1 creates session
tmux new -s pair

# Person 2 attaches (via SSH)
tmux attach -t pair

# Both see and control the same session
```

---

## Advanced Tips

### Session Persistence
Sessions survive disconnections! SSH drops? No problem:
```bash
# Later, reconnect and
tmux attach
```

### Nested Tmux
Working on remote server with tmux? Prefix twice:
```bash
Ctrl-a Ctrl-a <command>  # Sends to inner tmux
```

### Custom Layouts
Save and restore pane layouts:
```bash
# Save layout
Ctrl-a : select-layout main-vertical
```

### Scrollback Search
```bash
Ctrl-a [         # Enter copy mode
Ctrl-s or /      # Search forward
Ctrl-r or ?      # Search backward
n                # Next match
N                # Previous match
```

---

## Plugin System (TPM)

Tmux Plugin Manager is **ENABLED** with essential plugins installed:

### Installed Plugins

1. **tmux-sensible** - Better defaults out of the box
2. **tmux-resurrect** - Save/restore sessions (survives reboots!)
   - Save: `Ctrl-a Ctrl-s`
   - Restore: `Ctrl-a Ctrl-r`
3. **tmux-continuum** - Auto-saves every 15 minutes
4. **tmux-yank** - Superior clipboard integration
5. **vim-tmux-navigator** - Seamless Vim/Neovim navigation
6. **tmux-fzf** - Fuzzy finder for sessions, windows, panes
7. **catppuccin/tmux** - Beautiful Catppuccin theme

### Plugin Management

```bash
# Inside tmux:
Ctrl-a I         # Install new plugins
Ctrl-a U         # Update all plugins
Ctrl-a alt-u     # Uninstall removed plugins
```

### First Time Setup

✅ TPM is already installed!

Just start tmux and press `Ctrl-a I` to install all plugins:

```bash
tmux
# Then press: Ctrl-a I (capital I)
# Wait 10-30 seconds for installation
```

---

## Troubleshooting

### Colors not working?
```bash
# Check terminal
echo $TERM  # Should show *-256color

# Test tmux colors
tmux info | grep Tc
```

### Mouse not working?
- Ensure `set -g mouse on` in config
- Some terminals need special settings

### Copy/paste issues?
- Use tmux's copy mode (Ctrl-a Escape)
- Or install tmux-yank plugin

---

## Resources

- **Official Website:** https://github.com/tmux/tmux
- **Man Page:** `man tmux`
- **Config Reference:** `man tmux` (CONFIGURATION FILES section)
- **Community:** r/tmux on Reddit

---

## Next Steps

1. **Practice the basics** - Get comfortable with sessions and panes
2. **Customize your config** - Edit `~/.tmux.conf` to your preferences
3. **Learn advanced features** - Explore scripting and automation
4. **Try plugins** - Install TPM and popular plugins
5. **Create your workflow** - Design layouts for your daily tasks

---

**Pro Tip:** The best way to learn tmux is to use it daily. Start with one session, add panes as needed, and gradually incorporate more features into your workflow.
