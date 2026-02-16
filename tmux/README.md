# Tmux - Terminal Multiplexer Mastery

## Overview

Tmux is a powerful terminal multiplexer that enables professional-grade terminal workflows:

- **Session Persistence** - Sessions survive disconnections and system reboots
- **Window & Pane Management** - Multiple terminals in a single window
- **Remote Collaboration** - Share sessions for pair programming
- **Productivity Boost** - Keyboard-driven, distraction-free workflows
- **Beautiful Interface** - Modern Nord theme with PowerKit status bar

**Version:** 3.6a+
**Config:** `~/.tmux.conf`
**Theme:** Nord (PowerKit framework)

---

## Quick Start

### Essential Commands

```bash
# Start new session
tmux

# Named session (recommended)
tmux new -s mysession

# List all sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Detach from session (inside tmux)
Ctrl-a d

# Kill session
tmux kill-session -t mysession

# Kill all sessions
tmux kill-server
```

---

## Key Bindings Reference

**Prefix Key:** `Ctrl-a` (easier to reach than default `Ctrl-b`)

### Session Management
| Binding | Action |
|---------|--------|
| `Ctrl-a d` | Detach from current session |
| `Ctrl-a $` | Rename current session |
| `Ctrl-a s` | List and switch sessions |
| `Ctrl-a (` | Switch to previous session |
| `Ctrl-a )` | Switch to next session |

### Window Management
| Binding | Action |
|---------|--------|
| `Ctrl-a c` | Create new window (in current path) |
| `Ctrl-a ,` | Rename current window |
| `Ctrl-a w` | List all windows |
| `Ctrl-a n` | Next window |
| `Ctrl-a p` | Previous window |
| `Ctrl-a 0-9` | Jump to window by number |
| `Ctrl-a &` | Kill current window |
| `Ctrl-a f` | Find window by name |

### Pane Management
| Binding | Action |
|---------|--------|
| `Ctrl-a \|` | Split pane vertically |
| `Ctrl-a -` | Split pane horizontally |
| `Ctrl-a h/j/k/l` | Navigate between panes (Vim-style) |
| `Ctrl-a H/J/K/L` | Resize panes (5 cells at a time) |
| `Ctrl-a m` | Toggle pane zoom (maximize/restore) |
| `Ctrl-a x` | Kill current pane |
| `Ctrl-a {` | Move pane left |
| `Ctrl-a }` | Move pane right |
| `Ctrl-a space` | Cycle through layouts |
| `Ctrl-a q` | Show pane numbers |

### Copy Mode (Vim-style)
| Binding | Action |
|---------|--------|
| `Ctrl-a Escape` or `Ctrl-a [` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection and exit |
| `Ctrl-v` | Rectangle selection |
| `q` | Quit copy mode |
| `Ctrl-a p` | Paste buffer |

### System Commands
| Binding | Action |
|---------|--------|
| `Ctrl-a r` | Reload configuration (shows notification) |
| `Ctrl-a ?` | List all key bindings |
| `Ctrl-a :` | Enter command mode |
| `Ctrl-a t` | Show time/clock |

---

## Configuration Highlights

### 🎨 Visual Features

- **Nord Theme** - Cool arctic color palette with excellent contrast
- **PowerKit Status Bar** - Modular plugins showing git, CPU, memory, battery, time
- **Rounded Separators** - Modern aesthetic with smooth edges
- **Unified Pane Borders** - Clean, cohesive look with rounded corners
- **Icon-based Windows** - Visual indicators for window state
- **True Color Support** - 24-bit color for modern terminals

### ⌨️ Productivity Features

- **Intuitive Prefix** - `Ctrl-a` instead of default `Ctrl-b`
- **Vim Navigation** - `h/j/k/l` for pane movement and resizing
- **Smart Pane Splitting** - Always opens in current working directory
- **Mouse Support** - Click to select panes, drag to resize borders
- **50,000 Line Scrollback** - Extensive command history
- **Zero Escape Delay** - Instant response for Neovim/Vim users
- **Visual Feedback** - Status messages for config reloads

### 🔌 Plugin Ecosystem (TPM)

- **vim-tmux-navigator** - Seamless navigation between Vim/Neovim and tmux panes
- **tmux-resurrect** - Save and restore sessions (survives reboots!)
- **tmux-continuum** - Auto-save sessions every 15 minutes
- **tmux-tokyo-night** - PowerKit framework for beautiful status bars

### ⚡ Performance Optimizations

- **2-Second Status Refresh** - Balance between real-time and performance
- **Lazy Loading** - Stale-while-revalidate pattern for plugins
- **Focus Events** - Better integration with modern editors
- **50,000 Line History** - Comprehensive scrollback buffer

---

## Common Workflows

### Development Setup

Create a productive development environment:

```bash
# Start development session
tmux new -s dev

# Layout: Editor | Code/Git
#                | Server/Logs
Ctrl-a |    # Split vertically
Ctrl-a l    # Move to right pane
Ctrl-a -    # Split horizontally

# Now you have:
# - Left: Full-height editor (Neovim/Vim)
# - Top right: Git commands and shell
# - Bottom right: Development server or logs
```

### Multiple Projects

Separate context for each project:

```bash
# Create sessions
tmux new -s project1
# Detach with Ctrl-a d

tmux new -s project2
# Detach with Ctrl-a d

# Switch between them
Ctrl-a s              # Interactive session list
# OR
tmux attach -t project1
```

### Remote Work

Work survives disconnections:

```bash
# SSH to remote server
ssh user@server

# Create or attach to session
tmux new -s work

# Your connection drops...
# ... Later, SSH back in
tmux attach -t work
# Everything is exactly as you left it!
```

---

## PowerKit Theme Customization

### Available Themes

Switch to different aesthetic by editing `~/.tmux.conf`:

```bash
# Current: Nord (cool, minimal)
set -g @powerkit_theme "nord"

# Alternatives:
set -g @powerkit_theme "catppuccin"      # Pastel, modern
set -g @powerkit_theme "tokyo-night"     # Dark, vibrant
set -g @powerkit_theme "rose-pine"       # Subtle, elegant
set -g @powerkit_theme "dracula"         # Dark, colorful
set -g @powerkit_theme "gruvbox"         # Warm, retro
set -g @powerkit_theme "kanagawa"        # Japanese aesthetic
set -g @powerkit_theme "everforest"      # Natural, calm
```

### Status Bar Plugins

Customize what appears in your status bar (`~/.tmux.conf` line 86):

```bash
# Current plugins
set -g @powerkit_plugins "git,cpu,memory,battery,datetime"

# Available plugins:
# - git: Git branch and status
# - cpu: CPU usage percentage
# - memory: RAM usage
# - battery: Battery level (laptops)
# - datetime: Current time/date
# - hostname: Machine name
# - weather: Current weather
# - network: Network status
```

### Visual Customization

Already configured for modern aesthetics:

```bash
# Separator style
set -g @powerkit_separator_style "rounded"       # or "normal", "powerline"
set -g @powerkit_edge_separator_style "rounded"  # or "normal", "powerline"

# Spacing and padding
set -g @powerkit_elements_spacing "true"         # Breathing room between elements
set -g @powerkit_icon_padding "1"                # Icon padding

# Window indicators
set -g @powerkit_window_index_style "icon"       # or "text", "number"
```

---

## Plugin System (TPM)

### Installed Plugins

1. **tpm** - Tmux Plugin Manager
2. **vim-tmux-navigator** - Navigate between Vim/Neovim and tmux seamlessly
3. **tmux-tokyo-night** - PowerKit framework (provides Nord and other themes)
4. **tmux-resurrect** - Save/restore sessions manually
5. **tmux-continuum** - Auto-save sessions every 15 minutes

### Plugin Management

```bash
# Inside tmux:
Ctrl-a I         # Install new plugins (capital I)
Ctrl-a U         # Update all plugins (capital U)
Ctrl-a alt-u     # Uninstall removed plugins
```

### Session Persistence

**Auto-save** is enabled! Your sessions save every 15 minutes automatically.

```bash
# Manual save
Ctrl-a Ctrl-s

# Manual restore (after reboot)
Ctrl-a Ctrl-r

# Current settings
set -g @resurrect-capture-pane-contents 'on'  # Save pane contents
set -g @continuum-restore 'on'                # Auto-restore on tmux start
```

---

## Troubleshooting

### Colors Not Displaying Correctly?

```bash
# Check your terminal supports 256 colors
echo $TERM
# Should output: tmux-256color (when in tmux)
# or: xterm-256color, alacritty, etc. (outside tmux)

# Test true color support
tmux info | grep RGB
# Should show: RGB flag
```

**Fix:** Set your terminal emulator to support true color (24-bit).

### Status Bar Not at Bottom?

```bash
# Verify setting in ~/.tmux.conf
set -g @powerkit_status_position "bottom"

# Reload config
Ctrl-a r
```

### Mouse Not Working?

```bash
# Verify setting
set -g mouse on

# Some terminals require additional configuration
# Check your terminal emulator's mouse support settings
```

### Plugins Not Loading?

```bash
# Ensure TPM is installed
ls ~/.tmux/plugins/tpm

# Install TPM if missing
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux, install plugins
Ctrl-a I
```

---

## Advanced Tips

### Session Persistence Across Reboots

Sessions now **auto-restore** when you start tmux after a reboot:

```bash
# After system reboot
tmux
# Your sessions automatically restore!
```

### Nested Tmux Sessions

Working on a remote server that also runs tmux:

```bash
# Local tmux command: Ctrl-a <key>
# Remote tmux command: Ctrl-a Ctrl-a <key>

# Example: Create window on remote tmux
Ctrl-a Ctrl-a c
```

### Scrollback Search

```bash
Ctrl-a [         # Enter copy mode
/                # Search forward
?                # Search backward
n                # Next match
N                # Previous match
```

### Custom Layouts

```bash
# Apply preset layouts
Ctrl-a : select-layout main-vertical
Ctrl-a : select-layout main-horizontal
Ctrl-a : select-layout even-vertical
Ctrl-a : select-layout even-horizontal
Ctrl-a : select-layout tiled
```

---

## Resources

- **Official Repository:** https://github.com/tmux/tmux
- **PowerKit Docs:** https://github.com/fabioluciano/tmux-powerkit
- **Man Page:** `man tmux`
- **Community:** r/tmux on Reddit
- **Awesome Tmux:** https://github.com/rothgar/awesome-tmux

---

## Next Steps

1. **Practice Basics** - Start with `tmux new -s test` and experiment
2. **Learn Key Bindings** - Print the cheatsheet and keep it visible
3. **Customize Theme** - Try different PowerKit themes (see CUSTOMIZATION.md)
4. **Create Workflows** - Design layouts for your daily tasks (see WORKFLOWS.md)
5. **Write Scripts** - Automate session creation for common projects

---

**Pro Tip:** Start using tmux for ALL terminal work. The muscle memory will develop within a week, and you'll never want to work without it again. The productivity gains are substantial once you're fluent with the basics.
