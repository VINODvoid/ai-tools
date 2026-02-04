# Tmux Customization Guide

Advanced configuration options and customization techniques.

---

## Configuration Structure

The main config file is `~/.tmux.conf`. Changes take effect after:

```bash
# Inside tmux
Ctrl-a r

# Or from command line
tmux source-file ~/.tmux.conf
```

---

## Prefix Key Options

The prefix is the most important binding. Common alternatives:

```bash
# Default (Ctrl-b)
set -g prefix C-b

# Screen-style (Ctrl-a) - CURRENT
set -g prefix C-a

# Ctrl-Space (no conflict with terminal)
set -g prefix C-Space

# Backtick (`)
set -g prefix `

# Multiple prefixes (advanced)
set -g prefix C-a
set -g prefix2 C-b
```

**Recommendation:** `Ctrl-a` balances accessibility and avoiding conflicts.

---

## Color Schemes

### Minimal Dark Theme

```bash
# Status bar
set -g status-style 'bg=#1e1e1e fg=#d4d4d4'
set -g status-left ''
set -g status-right '%H:%M '
set -g status-right-length 50

# Window status
setw -g window-status-current-style 'bg=#007acc fg=#ffffff bold'
setw -g window-status-style 'bg=#1e1e1e fg=#d4d4d4'

# Panes
set -g pane-border-style 'fg=#444444'
set -g pane-active-border-style 'fg=#007acc'
```

### Gruvbox Theme

```bash
# Status bar
set -g status-style 'bg=#3c3836 fg=#ebdbb2'

# Window status
setw -g window-status-current-style 'bg=#fb4934 fg=#282828 bold'
setw -g window-status-style 'bg=#3c3836 fg=#ebdbb2'

# Panes
set -g pane-border-style 'fg=#504945'
set -g pane-active-border-style 'fg=#fe8019'
```

### Nord Theme

```bash
# Status bar
set -g status-style 'bg=#2e3440 fg=#d8dee9'

# Window status
setw -g window-status-current-style 'bg=#88c0d0 fg=#2e3440 bold'
setw -g window-status-style 'bg=#2e3440 fg=#d8dee9'

# Panes
set -g pane-border-style 'fg=#3b4252'
set -g pane-active-border-style 'fg=#88c0d0'
```

### Dracula Theme

```bash
# Status bar
set -g status-style 'bg=#282a36 fg=#f8f8f2'

# Window status
setw -g window-status-current-style 'bg=#bd93f9 fg=#282a36 bold'
setw -g window-status-style 'bg=#282a36 fg=#f8f8f2'

# Panes
set -g pane-border-style 'fg=#44475a'
set -g pane-active-border-style 'fg=#bd93f9'
```

---

## Status Bar Customization

### Information Display

```bash
# Left side
set -g status-left-length 50
set -g status-left '#[fg=green]#H #[fg=yellow]#S #[default]'

# Right side
set -g status-right-length 80
set -g status-right '#[fg=cyan]#(whoami)@#H #[fg=yellow]%Y-%m-%d %H:%M'
```

### Dynamic Information

```bash
# CPU usage
set -g status-right '#(cat /proc/loadavg | cut -d " " -f 1-3) %H:%M'

# Battery (for laptops)
set -g status-right 'Battery: #(acpi | cut -d, -f2) %H:%M'

# Git branch (in current pane's directory)
set -g status-right '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD 2>/dev/null)'

# Memory usage
set -g status-right 'MEM: #(free | grep Mem | awk "{printf \\"%.0f%%\\", \$3/\$2 * 100.0}")'
```

### Conditional Formatting

```bash
# Show prefix indicator
set -g status-right '#{?client_prefix,#[bg=red]PREFIX,} %H:%M'

# Highlight when pane is synchronized
set -g status-right '#{?pane_synchronized,#[bg=blue]SYNC,} %H:%M'
```

---

## Key Binding Customization

### Vim-Style Copy Mode (Enhanced)

```bash
# Use v to trigger selection
bind -T copy-mode-vi v send-keys -X begin-selection

# Use y to yank current selection
bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

# Use r for rectangle selection
bind -T copy-mode-vi r send-keys -X rectangle-toggle

# Use V for line selection
bind -T copy-mode-vi V send-keys -X select-line

# Use Ctrl-v for block selection
bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
```

### Custom Split Bindings

```bash
# Split with current path
bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

# Split full window
bind _ split-window -fv -c "#{pane_current_path}"
bind | split-window -fh -c "#{pane_current_path}"
```

### Window Management

```bash
# Quick window switching (Alt+number, no prefix)
bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4

# Shift arrow to switch windows
bind -n S-Left previous-window
bind -n S-Right next-window
```

### Session Management

```bash
# Switch sessions with Alt+arrow (no prefix)
bind -n M-Up switch-client -p
bind -n M-Down switch-client -n

# Quick session switcher
bind S choose-session
```

---

## Plugin Configuration

### Using TPM (Tmux Plugin Manager)

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add to ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize (keep at bottom)
run '~/.tmux/plugins/tpm/tpm'

# Inside tmux, install plugins
Ctrl-a I  # Install
Ctrl-a U  # Update
Ctrl-a alt-u  # Uninstall
```

### Essential Plugins

```bash
# Better defaults
set -g @plugin 'tmux-plugins/tmux-sensible'

# Save/restore sessions
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'

# Better copy/paste
set -g @plugin 'tmux-plugins/tmux-yank'

# Pane navigation
set -g @plugin 'christoomey/vim-tmux-navigator'

# Sidebar file tree
set -g @plugin 'tmux-plugins/tmux-sidebar'

# Prefix highlight
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'

# CPU/RAM monitor
set -g @plugin 'tmux-plugins/tmux-cpu'

# Battery status
set -g @plugin 'tmux-plugins/tmux-battery'
```

### Plugin Customization

```bash
# tmux-resurrect: Save vim/nvim sessions
set -g @resurrect-strategy-nvim 'session'

# tmux-continuum: Auto-save interval
set -g @continuum-save-interval '15'

# tmux-yank: Copy to system clipboard
set -g @yank_selection 'clipboard'
set -g @yank_selection_mouse 'clipboard'

# tmux-prefix-highlight: Show in status
set -g status-right '#{prefix_highlight} %a %Y-%m-%d %H:%M'
```

---

## Advanced Features

### Popup Windows

```bash
# Toggle popup terminal
bind g display-popup -E "tmux new-session -A -s scratch"

# Popup with specific command
bind h display-popup -E "htop"

# Popup file browser
bind f display-popup -w 80% -h 80% -E "ranger"
```

### Conditional Settings

```bash
# Different settings for local vs SSH
if-shell '[ -n "$SSH_CLIENT" ]' \
  'set -g status-position top' \
  'set -g status-position bottom'

# Version-specific features
if-shell "tmux -V | awk '{exit !($2 >= 3.2)}'" \
  'set -g extended-keys on'
```

### Window/Pane Options

```bash
# Rename window to running program
setw -g automatic-rename on
set -g automatic-rename-format '#{b:pane_current_path}'

# Word separators for double-click
setw -g word-separators ' @"=()[]{}:,.'

# Allow programs to change window name
set -g allow-rename on

# Pane border format
set -g pane-border-format "#[fg=colour238]#{pane_index} #{pane_current_command}"
```

---

## Mouse Customization

```bash
# Enable mouse
set -g mouse on

# Don't copy on mouse drag end
unbind -T copy-mode-vi MouseDragEnd1Pane

# Middle click to paste
bind -n MouseDown2Pane run "tmux set-buffer \"$(xclip -o -sel primary)\"; tmux paste-buffer"

# Scroll up to enter copy mode
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
```

---

## Session Hooks

Automate actions on events:

```bash
# Auto-rename window based on current directory
set-hook -g after-select-pane 'run-shell "tmux set-window-option -t #{session_name}:#{window_index} window-status-format \"#{b:pane_current_path}\""'

# Save session on exit
set-hook -g session-closed 'run-shell "~/.tmux/plugins/tmux-resurrect/scripts/save.sh"'

# Alert when pane exits
set-hook -g pane-exited 'run-shell "notify-send \"Pane exited\" \"#{pane_current_command} in #{session_name}:#{window_index}\""'
```

---

## Environment Variables

```bash
# Pass through environment variables
set -ga update-environment ' MY_VAR'

# Set default shell
set -g default-shell /bin/zsh

# Set default command
set -g default-command /bin/zsh
```

---

## Performance Optimization

```bash
# Faster command sequences
set -sg escape-time 0

# Increase repeat time for repeatable commands
set -g repeat-time 1000

# Increase history limit
set -g history-limit 100000

# Aggressive resize
setw -g aggressive-resize on

# Update status bar less frequently
set -g status-interval 10
```

---

## Multi-Monitor Support

```bash
# Constrain window size to smallest client actively viewing
setw -g aggressive-resize on

# Per-session window sizing
set -g window-size largest
```

---

## Nested Tmux Configuration

For working on remote servers:

```bash
# Local tmux
bind -n C-a send-prefix

# Remote tmux (toggle between local/remote)
bind -n C-q if-shell "$is_vim" "send-keys C-q" "set -g prefix C-q; set -g status-style bg=red"
bind C-q send-prefix \; set -g prefix C-a \; set -g status-style bg=black
```

---

## Testing Configuration

```bash
# Check syntax without applying
tmux -f ~/.tmux.conf.test list-keys

# Show current settings
tmux show-options -g
tmux show-window-options -g

# List all key bindings
tmux list-keys

# Show specific option
tmux show-options -g status-style
```

---

## Configuration Organization

For complex configs, split into multiple files:

```bash
# ~/.tmux.conf
source-file ~/.tmux/base.conf
source-file ~/.tmux/bindings.conf
source-file ~/.tmux/theme.conf
source-file ~/.tmux/plugins.conf

# Load local overrides if they exist
if-shell '[ -f ~/.tmux.local.conf ]' \
  'source-file ~/.tmux.local.conf'
```

---

## Backup Your Configuration

```bash
# Backup
cp ~/.tmux.conf ~/.tmux.conf.backup

# Version control (recommended)
cd ~
git init
git add .tmux.conf
git commit -m "Tmux configuration"

# Or use dotfiles repo
```

---

## Resources

- **Man page:** `man tmux` - Complete reference
- **GitHub:** https://github.com/tmux/tmux
- **Wiki:** https://github.com/tmux/tmux/wiki
- **Awesome Tmux:** https://github.com/rothgar/awesome-tmux
- **My config examples:** https://github.com/search?q=tmux.conf

---

**Tip:** Start with the provided config and gradually add customizations as you discover your workflow preferences. Too many changes at once can be overwhelming!
