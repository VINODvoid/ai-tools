# Tmux Customization Guide

Advanced configuration and personalization for your tmux setup.

**Config File:** `~/.tmux.conf`

---

## PowerKit Theme System

Your tmux uses the **PowerKit framework** (via `tmux-tokyo-night` plugin) for beautiful, modular status bars.

### Available Themes

Switch themes by editing line 77 in `~/.tmux.conf`:

```bash
# Arctic & Minimal
set -g @powerkit_theme "nord"              # Cool blues (CURRENT)

# Pastel & Modern
set -g @powerkit_theme "catppuccin"        # Soothing pastels
set -g @powerkit_theme_variant "mocha"     # Dark variant

# Dark & Vibrant
set -g @powerkit_theme "tokyo-night"       # Night coding theme
set -g @powerkit_theme "dracula"           # Purple-heavy dark
set -g @powerkit_theme "monokai"           # Classic dark

# Elegant & Subtle
set -g @powerkit_theme "rose-pine"         # Subtle, elegant
set -g @powerkit_theme "vesper"            # Calm, dark
set -g @powerkit_theme "osaka-jade"        # Japanese aesthetic

# Retro & Warm
set -g @powerkit_theme "gruvbox"           # Warm, retro
set -g @powerkit_theme "everforest"        # Natural, calm

# Light Themes
set -g @powerkit_theme "github"            # GitHub light
set -g @powerkit_theme_variant "light"
```

**Full theme list:** `ls ~/.tmux/plugins/tmux-tokyo-night/src/themes/`

After changing, reload: `Ctrl-a r`

---

## Status Bar Customization

### Plugin Selection

Edit line 86 in `~/.tmux.conf`:

```bash
# Current plugins
set -g @powerkit_plugins "git,cpu,memory,battery,datetime"

# All available plugins:
set -g @powerkit_plugins "git,cpu,memory,battery,datetime,hostname,network,weather"
```

**Plugin Details:**

| Plugin | Description | Useful For |
|--------|-------------|------------|
| `git` | Git branch and status | Developers |
| `cpu` | CPU usage % | Monitoring performance |
| `memory` | RAM usage | System resource tracking |
| `battery` | Battery level | Laptops |
| `datetime` | Current time/date | Always useful |
| `hostname` | Machine name | Multi-server work |
| `network` | Network status | Connection monitoring |
| `weather` | Current weather | Nice-to-have |

### Status Bar Position

```bash
# Bottom (CURRENT)
set -g @powerkit_status_position "bottom"

# Top
set -g @powerkit_status_position "top"
```

### Status Bar Layout

```bash
# Single line (CURRENT)
set -g @powerkit_bar_layout "single"

# Double line (more space)
set -g @powerkit_bar_layout "double"
```

---

## Visual Customization

### Separator Styles

```bash
# Rounded (CURRENT - modern look)
set -g @powerkit_separator_style "rounded"
set -g @powerkit_edge_separator_style "rounded"

# Normal (clean, minimal)
set -g @powerkit_separator_style "normal"
set -g @powerkit_edge_separator_style "normal"

# Powerline (classic powerline arrows)
set -g @powerkit_separator_style "powerline"
set -g @powerkit_edge_separator_style "powerline"
```

### Spacing & Padding

```bash
# Element spacing (CURRENT - breathing room)
set -g @powerkit_elements_spacing "true"

# Tight spacing
set -g @powerkit_elements_spacing "false"

# Icon padding
set -g @powerkit_icon_padding "1"    # CURRENT (balanced)
set -g @powerkit_icon_padding "0"    # Compact
set -g @powerkit_icon_padding "2"    # Spacious
```

### Window Indicators

```bash
# Icon-based (CURRENT - visual)
set -g @powerkit_window_index_style "icon"

# Text-based (simple)
set -g @powerkit_window_index_style "text"

# Number-based (minimal)
set -g @powerkit_window_index_style "number"
```

---

## Pane Border Customization

### Border Lines

```bash
# Rounded (CURRENT - modern aesthetic)
set -g @powerkit_pane_border_lines "rounded"

# Single line (classic)
set -g @powerkit_pane_border_lines "single"

# Double line (heavy)
set -g @powerkit_pane_border_lines "double"

# Heavy line
set -g @powerkit_pane_border_lines "heavy"
```

### Border Colors

```bash
# Unified (CURRENT - clean, consistent)
set -g @powerkit_pane_border_unified "true"

# Different colors for active/inactive
set -g @powerkit_pane_border_unified "false"
set -g @powerkit_active_pane_border_color "pane-border-active"
set -g @powerkit_inactive_pane_border_color "pane-border-inactive"
```

---

## Prefix Key Alternatives

Change the prefix key (currently `Ctrl-a`):

```bash
# Screen-style (CURRENT)
set -g prefix C-a
unbind C-b
bind-key C-a send-prefix

# Ctrl-Space (no conflicts)
set -g prefix C-Space
unbind C-b
bind-key C-Space send-prefix

# Backtick (`)
set -g prefix `
unbind C-b
bind-key ` send-prefix

# Multiple prefixes
set -g prefix C-a
set -g prefix2 C-b
unbind C-b
bind-key C-a send-prefix
bind-key C-b send-prefix -2
```

**Recommendation:** Stick with `Ctrl-a` (screen-compatible, ergonomic)

---

## Key Binding Customization

### Enhanced Vim Copy Mode

Add to `~/.tmux.conf`:

```bash
# Line selection
bind -T copy-mode-vi V send-keys -X select-line

# Word selection
bind -T copy-mode-vi W send-keys -X next-word-end

# Incremental search
bind -T copy-mode-vi / command-prompt -p "search down" "send -X search-forward \"%%%\""
```

### Quick Window Switching (No Prefix)

```bash
# Alt+number switches windows
bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4
bind -n M-5 select-window -t 5

# Shift+arrow switches windows
bind -n S-Left previous-window
bind -n S-Right next-window
```

### Full-Width Splits

```bash
# Split entire window (not just pane)
bind _ split-window -fv -c "#{pane_current_path}"
bind | split-window -fh -c "#{pane_current_path}"
```

---

## Performance Tuning

### Status Bar Refresh Rate

```bash
# 2 seconds (CURRENT - balanced)
set -g @powerkit_status_interval "2"

# 1 second (real-time, higher CPU)
set -g @powerkit_status_interval "1"

# 5 seconds (lower CPU, slower updates)
set -g @powerkit_status_interval "5"
```

### Scrollback History

```bash
# 50,000 lines (CURRENT)
set -g history-limit 50000

# 100,000 lines (heavy usage)
set -g history-limit 100000

# 10,000 lines (minimal memory)
set -g history-limit 10000
```

### Escape Time

```bash
# 10ms (CURRENT - optimal for Neovim/Vim)
set -sg escape-time 10

# 0ms (instant, may cause issues)
set -sg escape-time 0

# 50ms (default tmux)
set -sg escape-time 50
```

---

## Mouse Customization

### Disable Mouse

```bash
# Enable (CURRENT)
set -g mouse on

# Disable
set -g mouse off
```

### Mouse Wheel Behavior

```bash
# Don't exit copy mode on mouse drag
unbind -T copy-mode-vi MouseDragEnd1Pane

# Enter copy mode on scroll up
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" \
  "send-keys -M" \
  "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
```

---

## Session Management

### Auto-Restore on Start

```bash
# Enabled (CURRENT)
set -g @continuum-restore 'on'

# Disabled (manual restore only)
set -g @continuum-restore 'off'
```

### Auto-Save Interval

```bash
# 15 minutes (default)
set -g @continuum-save-interval '15'

# 5 minutes (frequent saves)
set -g @continuum-save-interval '5'

# 30 minutes (less frequent)
set -g @continuum-save-interval '30'
```

### Resurrect Options

```bash
# Save pane contents (CURRENT)
set -g @resurrect-capture-pane-contents 'on'

# Don't save pane contents
set -g @resurrect-capture-pane-contents 'off'

# Restore Neovim sessions
set -g @resurrect-strategy-nvim 'session'

# Restore Vim sessions
set -g @resurrect-strategy-vim 'session'
```

---

## Advanced Customization

### Conditional Settings

```bash
# Different settings for SSH
if-shell '[ -n "$SSH_CLIENT" ]' \
  'set -g status-position top' \
  'set -g status-position bottom'

# Version-specific features
if-shell "tmux -V | awk '{exit !($2 >= 3.2)}'" \
  'set -g extended-keys on'
```

### Custom Status Bar Format

Override PowerKit (advanced):

```bash
# Left status
set -g status-left '#[fg=green]#H #[fg=yellow]#S #[default]'
set -g status-left-length 50

# Right status
set -g status-right '#[fg=cyan]%Y-%m-%d %H:%M'
set -g status-right-length 80

# Window status
setw -g window-status-current-format '#[bg=blue,fg=white] #I:#W '
setw -g window-status-format ' #I:#W '
```

### Hooks

Automate actions on events:

```bash
# Auto-rename window based on current command
set-hook -g after-select-pane 'run-shell "tmux rename-window #{pane_current_command}"'

# Save session on exit
set-hook -g session-closed 'run-shell "~/.tmux/plugins/tmux-resurrect/scripts/save.sh"'
```

---

## Plugin Management

### Add New Plugins

Edit `~/.tmux.conf` and add before the TPM initialization:

```bash
# Add plugin
set -g @plugin 'author/plugin-name'

# Then install
Ctrl-a I
```

### Recommended Plugins

```bash
# File tree sidebar
set -g @plugin 'tmux-plugins/tmux-sidebar'

# Enhanced prefix indicator
set -g @plugin 'tmux-plugins/tmux-prefix-highlight'

# CPU/GPU monitor
set -g @plugin 'tmux-plugins/tmux-cpu'

# Better session manager
set -g @plugin 'tmux-plugins/tmux-sessionist'

# Open URLs/files from tmux
set -g @plugin 'tmux-plugins/tmux-open'
```

### Remove Plugins

```bash
# Comment out in ~/.tmux.conf
# set -g @plugin 'author/plugin-name'

# Reload and clean
Ctrl-a r
Ctrl-a alt-u
```

---

## Configuration Organization

For complex setups, split into files:

```bash
# ~/.tmux.conf
source-file ~/.tmux/base.conf
source-file ~/.tmux/bindings.conf
source-file ~/.tmux/theme.conf
source-file ~/.tmux/plugins.conf

# Local overrides
if-shell '[ -f ~/.tmux.local.conf ]' \
  'source-file ~/.tmux.local.conf'
```

Create `~/.tmux/` directory and move sections accordingly.

---

## Testing Changes

```bash
# Check syntax (doesn't apply changes)
tmux -f ~/.tmux.conf.test list-keys

# Show current options
tmux show-options -g
tmux show-window-options -g

# List all key bindings
tmux list-keys

# Show specific option value
tmux show-options -g status-style
```

---

## Backup & Version Control

```bash
# Backup
cp ~/.tmux.conf ~/.tmux.conf.backup.$(date +%Y%m%d)

# Git tracking (recommended)
cd ~
git init
git add .tmux.conf
git commit -m "Tmux configuration"

# Or use dotfiles repo
```

---

## Resources

- **PowerKit Docs:** https://github.com/fabioluciano/tmux-powerkit/wiki
- **PowerKit Themes:** `ls ~/.tmux/plugins/tmux-tokyo-night/src/themes/`
- **PowerKit Plugins:** https://github.com/fabioluciano/tmux-powerkit/wiki/Plugins
- **Tmux Man Page:** `man tmux`
- **Awesome Tmux:** https://github.com/rothgar/awesome-tmux
- **TPM:** https://github.com/tmux-plugins/tpm

---

**Pro Tip:** Make incremental changes and test each one. Keep a backup before major modifications. The current configuration is already optimized for aesthetics and productivity - only customize what doesn't fit your workflow.
