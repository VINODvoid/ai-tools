# Tmux Workflows & Use Cases

Practical workflows and real-world scenarios for maximizing tmux productivity.

**Prefix:** `Ctrl-a`

---

## Development Workflows

### 1. Full Stack Development

**Goal:** Edit code, run frontend, run backend, monitor git - all in one view.

**Layout:**
```
┌──────────────┬──────────────┐
│              │  Git/Shell   │
│   Editor     ├──────────────┤
│  (Neovim)    │   Backend    │
│              ├──────────────┤
│              │   Frontend   │
└──────────────┴──────────────┘
```

**Setup:**
```bash
tmux new -s fullstack
# Split vertical: Ctrl-a |
# Move right: Ctrl-a l
# Split horizontal: Ctrl-a -
# Split horizontal again: Ctrl-a -
# Move to top-right: Ctrl-a k (twice)

# Now run:
# Left: nvim
# Top right: git status
# Middle right: npm run backend
# Bottom right: npm run dev
```

**Quick Script:**
```bash
#!/bin/bash
tmux new-session -d -s fullstack
tmux split-window -h
tmux split-window -v
tmux split-window -v
tmux select-pane -t 0
tmux send-keys -t 0 'nvim' C-m
tmux send-keys -t 2 'npm run backend' C-m
tmux send-keys -t 3 'npm run dev' C-m
tmux attach -t fullstack
```

---

### 2. Single Project Focus

**Goal:** Simple editor + tests + server setup.

**Layout:**
```
┌──────────────────────────────┐
│         Editor               │
│                              │
├──────────────┬───────────────┤
│  Tests       │    Server     │
└──────────────┴───────────────┘
```

**Setup:**
```bash
tmux new -s myproject
Ctrl-a -           # Split horizontal
Ctrl-a j           # Move down
Ctrl-a |           # Split vertical
Ctrl-a h           # Back to left pane
# Top: editor (nvim)
# Bottom left: npm test -- --watch
# Bottom right: npm start
```

---

### 3. Microservices Development

**Goal:** One window per service, easy switching.

**Windows:**
```
0: auth-service
1: api-gateway
2: user-service
3: logs
4: database
```

**Automation Script:**
```bash
#!/bin/bash
# ~/bin/start-microservices

SESSION="micro"

tmux new-session -d -s $SESSION

# Auth service
tmux rename-window -t $SESSION:0 'auth'
tmux send-keys -t $SESSION:0 'cd ~/services/auth && npm start' C-m

# API Gateway
tmux new-window -t $SESSION:1 -n 'api'
tmux send-keys -t $SESSION:1 'cd ~/services/api && npm start' C-m

# User service
tmux new-window -t $SESSION:2 -n 'user'
tmux send-keys -t $SESSION:2 'cd ~/services/user && npm start' C-m

# Logs viewer
tmux new-window -t $SESSION:3 -n 'logs'
tmux send-keys -t $SESSION:3 'tail -f ~/logs/*.log' C-m

# Database
tmux new-window -t $SESSION:4 -n 'db'
tmux send-keys -t $SESSION:4 'psql -d mydb' C-m

# Attach to session
tmux select-window -t $SESSION:0
tmux attach -t $SESSION
```

**Usage:**
```bash
chmod +x ~/bin/start-microservices
start-microservices
```

---

## System Administration Workflows

### 1. Server Monitoring

**Layout:**
```
┌──────────┬──────────┬──────────┐
│  htop    │  Logs    │  Network │
├──────────┴──────────┴──────────┤
│         Shell                  │
└────────────────────────────────┘
```

**Setup:**
```bash
tmux new -s monitor

# Top row - monitoring tools
htop
Ctrl-a |
tail -f /var/log/syslog
Ctrl-a |
nethogs

# Bottom row - command shell
Ctrl-a h           # Move to first pane
Ctrl-a -           # Split below
```

---

### 2. Multi-Server Management

**Goal:** SSH into multiple servers, one window per server.

**Script:**
```bash
#!/bin/bash
# ~/bin/connect-servers

SESSION="servers"

tmux new-session -d -s $SESSION
tmux rename-window -t $SESSION:0 'web-1'
tmux send-keys -t $SESSION:0 'ssh web-1' C-m

tmux new-window -t $SESSION:1 -n 'web-2'
tmux send-keys -t $SESSION:1 'ssh web-2' C-m

tmux new-window -t $SESSION:2 -n 'db-1'
tmux send-keys -t $SESSION:2 'ssh db-1' C-m

tmux new-window -t $SESSION:3 -n 'cache'
tmux send-keys -t $SESSION:3 'ssh cache-1' C-m

tmux attach -t $SESSION
```

**Usage:**
```bash
# Quick switch between servers
Ctrl-a 0    # web-1
Ctrl-a 1    # web-2
Ctrl-a 2    # db-1
Ctrl-a 3    # cache

# Or use window list
Ctrl-a w
```

---

## Remote Work Workflows

### 1. Persistent Remote Sessions

**Problem:** SSH connection drops, lose all work.
**Solution:** Tmux sessions persist!

```bash
# Initial connection
ssh user@server
tmux new -s work

# Do your work...
# Connection drops!

# Later, reconnect
ssh user@server
tmux attach -t work
# Everything is exactly as you left it!
```

**Pro Tip:** Always start tmux immediately after SSHing.

---

### 2. Pair Programming

**Traditional Approach (Same Server):**
```bash
# Person 1 creates session
tmux new -s pair

# Person 2 SSH's in and joins
ssh user@host
tmux attach -t pair

# Both see and control the same session
```

**Modern Approach (tmate):**
```bash
# Install tmate (tmux for sharing)
# https://tmate.io/

# Person 1
tmate new -s pair

# Get shareable link
tmate show-messages
# Outputs: ssh session link

# Person 2 uses the link
ssh <tmate-link>

# No SSH access needed!
```

---

## Data Science Workflows

### 1. Analysis Session

**Layout:**
```
┌─────────────────────────────┐
│   Jupyter Notebook          │
├──────────────┬──────────────┤
│  Editor      │  Visualizer  │
└──────────────┴──────────────┘
```

**Setup:**
```bash
tmux new -s analysis
jupyter notebook --no-browser
Ctrl-a -
Ctrl-a |
# Top: Jupyter (access via browser)
# Bottom left: Edit scripts (nvim)
# Bottom right: Run visualizations (python)
```

---

### 2. Machine Learning Training

**Layout:**
```
┌──────────────┬──────────────┐
│  Jupyter     │ GPU Monitor  │
├──────────────┤              │
│ TensorBoard  │              │
└──────────────┴──────────────┘
```

**Setup:**
```bash
tmux new -s ml

# Left side
jupyter lab --no-browser
Ctrl-a -
tensorboard --logdir=./logs

# Right side
Ctrl-a |
watch -n 1 nvidia-smi
```

---

## Writing & Documentation Workflows

### 1. Documentation Writing

**Layout:**
```
┌─────────────────┬──────────────┐
│                 │              │
│   Editor        │  Preview     │
│  (Markdown)     │  (Browser)   │
│                 │              │
└─────────────────┴──────────────┘
```

**Setup:**
```bash
tmux new -s docs
nvim README.md
Ctrl-a |
# Start preview server
npx live-server --port=8080
```

---

### 2. Blog Post Creation

**Layout:**
```
┌─────────────────────────────┐
│         Editor              │
├──────────────┬──────────────┤
│ Hugo Server  │  Git Status  │
└──────────────┴──────────────┘
```

**Setup:**
```bash
tmux new -s blog
nvim content/posts/new-post.md
Ctrl-a -
hugo server
Ctrl-a |
watch -n 5 git status --short
```

---

## Session Management Scripts

### Recommended Script Structure

Save as `~/bin/dev`:

```bash
#!/bin/bash
# Quick development session launcher

SESSION=${1:-dev}
PROJECT_DIR=${2:-~/projects}

# Check if session exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Create new session
  cd "$PROJECT_DIR"

  tmux new-session -d -s $SESSION -n editor
  tmux send-keys -t $SESSION:0 "cd $PROJECT_DIR && nvim" C-m

  tmux new-window -t $SESSION:1 -n shell
  tmux send-keys -t $SESSION:1 "cd $PROJECT_DIR" C-m

  tmux new-window -t $SESSION:2 -n git
  tmux send-keys -t $SESSION:2 "cd $PROJECT_DIR && git status" C-m

  tmux select-window -t $SESSION:0
fi

tmux attach -t $SESSION
```

**Usage:**
```bash
chmod +x ~/bin/dev

# Start default dev session
dev

# Start custom session
dev myproject ~/code/myproject
```

---

### Project Switcher

Save as `~/bin/proj`:

```bash
#!/bin/bash
# Interactive project selector

PROJECTS=(
  "~/work/project-a"
  "~/work/project-b"
  "~/personal/blog"
)

echo "Select project:"
select PROJECT in "${PROJECTS[@]}"; do
  if [ -n "$PROJECT" ]; then
    SESSION=$(basename "$PROJECT")
    cd "$PROJECT"

    tmux has-session -t $SESSION 2>/dev/null
    if [ $? != 0 ]; then
      tmux new-session -d -s $SESSION
      tmux send-keys -t $SESSION "cd $PROJECT && nvim" C-m
    fi

    tmux attach -t $SESSION
    break
  fi
done
```

**Usage:**
```bash
chmod +x ~/bin/proj
proj
# Select from menu
```

---

## Advanced Techniques

### 1. Pane Synchronization

**Use Case:** Run the same command on multiple servers.

```bash
# Setup: One pane per server
ssh web-1
Ctrl-a |
ssh web-2
Ctrl-a |
ssh web-3

# Enable synchronization
Ctrl-a : setw synchronize-panes on

# Now typing appears in all panes!
sudo systemctl restart nginx

# Disable synchronization
Ctrl-a : setw synchronize-panes off
```

---

### 2. Session Nesting (Remote + Local)

**Scenario:** Local tmux, SSH to server also running tmux.

```bash
# Local command: Ctrl-a <key>
# Remote command: Ctrl-a Ctrl-a <key>

# Example: Create window on remote
Ctrl-a Ctrl-a c
```

---

### 3. Copy Between Panes

```bash
# In pane 1
Ctrl-a [         # Enter copy mode
# Navigate and select with v, copy with y

# Switch to pane 2
Ctrl-a l

# Paste
Ctrl-a p
```

---

## Session Persistence

With **tmux-resurrect** and **tmux-continuum**, sessions auto-save and restore!

### Auto-Save

Sessions save every 15 minutes automatically.

### Manual Operations

```bash
# Save session manually
Ctrl-a Ctrl-s

# After reboot, restore
Ctrl-a Ctrl-r

# Or auto-restore on tmux start (already enabled)
```

**What Gets Saved:**
- Window layouts
- Pane arrangements
- Working directories
- Pane contents (scrollback)
- Running programs

---

## Workflow Templates

### Template: Bug Investigation

```bash
#!/bin/bash
tmux new-session -d -s debug
tmux rename-window -t debug:0 'code'
tmux new-window -t debug:1 -n 'logs'
tmux new-window -t debug:2 -n 'git'
tmux new-window -t debug:3 -n 'docs'
tmux attach -t debug
```

### Template: Learning New Tech

```bash
#!/bin/bash
tmux new-session -d -s learn
tmux rename-window -t learn:0 'tutorial'
tmux new-window -t learn:1 -n 'practice'
tmux new-window -t learn:2 -n 'repl'
tmux new-window -t learn:3 -n 'notes'
tmux attach -t learn
```

---

## Productivity Tips

1. **One Session Per Project** - Maintain separate contexts, quick switching
2. **Descriptive Names** - `tmux new -s myproject` not `tmux`
3. **Consistent Layouts** - Muscle memory makes you faster
4. **Script Common Setups** - Automate repetitive layouts
5. **Detach Liberally** - `Ctrl-a d` - sessions persist forever
6. **Clean Up Unused** - `tmux kill-session -t old` - keep it tidy
7. **Use Window Numbers** - `Ctrl-a 0-9` for instant access

---

## Real-World Example

My daily development workflow:

```bash
# Morning: Start project sessions
~/bin/dev backend ~/code/backend
Ctrl-a d

~/bin/dev frontend ~/code/frontend
Ctrl-a d

~/bin/dev docs ~/code/docs
Ctrl-a d

# Work throughout the day, switching contexts
tmux attach -t backend    # Focus on API
Ctrl-a d
tmux attach -t frontend   # Build UI
Ctrl-a d

# Evening: Detach everything
tmux ls                   # See all sessions
Ctrl-a d                  # Close terminal

# Next day: Resume exactly where I left off
tmux attach -t backend    # Right back to work
```

---

**Pro Tip:** Create a morning script that launches all your common sessions. Mine starts 5 tmux sessions (work projects, personal projects, monitoring) with one command. Takes 2 seconds, saves 5 minutes of setup every day!
