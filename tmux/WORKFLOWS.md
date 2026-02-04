# Tmux Workflows & Use Cases

Practical workflows and real-world scenarios for maximizing tmux productivity.

---

## Development Workflows

### 1. Full Stack Development

**Setup:**
```bash
tmux new -s fullstack
```

**Layout:**
```
┌─────────────────┬─────────────────┐
│                 │   Git/Shell     │
│    Editor       ├─────────────────┤
│   (nvim/code)   │   Backend       │
│                 ├─────────────────┤
│                 │   Frontend      │
└─────────────────┴─────────────────┘
```

**Commands:**
```bash
# Start
tmux new -s fullstack
Ctrl-a |           # Split vertical
Ctrl-a l           # Move to right
Ctrl-a -           # Split horizontal
Ctrl-a -           # Split horizontal again

# Run services
# Right top: git status
# Right middle: npm run backend
# Right bottom: npm run frontend
```

---

### 2. Single Project Focus

**Setup:**
```bash
tmux new -s myproject
```

**Layout:**
```
┌─────────────────────────────────┐
│         Editor                  │
│                                 │
├─────────────────────────────────┤
│    Tests      │      Server     │
└─────────────────────────────────┘
```

**Commands:**
```bash
Ctrl-a -           # Split horizontal
Ctrl-a j           # Move down
Ctrl-a |           # Split vertical
# Top: editor
# Bottom left: npm test -- --watch
# Bottom right: npm start
```

---

### 3. Microservices Development

**Setup:** One window per service

```bash
tmux new -s microservices

# Window layout
0: auth-service
1: api-gateway
2: user-service
3: logs
4: database
```

**Commands:**
```bash
Ctrl-a c           # Create new window for each service
Ctrl-a ,           # Rename each window

# In each window, split as needed
Ctrl-a -           # Code on top, logs on bottom
```

**Quick script:**
```bash
#!/bin/bash
tmux new-session -d -s micro
tmux rename-window -t micro:0 'auth'
tmux send-keys -t micro:0 'cd ~/services/auth && npm start' C-m

tmux new-window -t micro:1 -n 'api'
tmux send-keys -t micro:1 'cd ~/services/api && npm start' C-m

tmux new-window -t micro:2 -n 'user'
tmux send-keys -t micro:2 'cd ~/services/user && npm start' C-m

tmux new-window -t micro:3 -n 'logs'
tmux attach -t micro
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

**Commands:**
```bash
tmux new -s monitor

# Top row
htop
Ctrl-a |
tail -f /var/log/syslog
Ctrl-a |
nethogs

# Bottom
Ctrl-a -
# Regular shell for commands
```

---

### 2. Multi-Server Management

**Setup:** One window per server

```bash
tmux new -s servers

# Windows
0: web-1
1: web-2
2: db-1
3: cache
```

**Auto-connect script:**
```bash
#!/bin/bash
tmux new-session -d -s servers
tmux rename-window -t servers:0 'web-1'
tmux send-keys -t servers:0 'ssh web-1' C-m

tmux new-window -t servers:1 -n 'web-2'
tmux send-keys -t servers:1 'ssh web-2' C-m

tmux new-window -t servers:2 -n 'db-1'
tmux send-keys -t servers:2 'ssh db-1' C-m

tmux attach -t servers
```

---

## Data Science Workflows

### 1. Analysis Session

**Layout:**
```
┌─────────────────────────────────┐
│     Jupyter/IPython             │
├─────────────────┬───────────────┤
│   Editor        │   Visualizer  │
└─────────────────┴───────────────┘
```

**Commands:**
```bash
tmux new -s analysis
jupyter notebook
Ctrl-a -
Ctrl-a |
# Left: edit scripts
# Right: run visualizations
```

---

### 2. ML Training

**Layout:**
```
┌──────────────┬──────────────────┐
│   Jupyter    │   GPU Monitor    │
├──────────────┤                  │
│   TensorBoard│                  │
└──────────────┴──────────────────┘
```

**Commands:**
```bash
tmux new -s ml
jupyter lab
Ctrl-a |
watch -n 1 nvidia-smi
Ctrl-a h
Ctrl-a -
tensorboard --logdir=./logs
```

---

## Remote Work Workflows

### 1. Persistent Remote Session

**Use case:** SSH connection drops but work continues

```bash
# On remote server
ssh user@server
tmux new -s work

# Do your work...
# Connection drops!

# Reconnect
ssh user@server
tmux attach -t work
# Everything is still there!
```

---

### 2. Pair Programming

**Setup:**
```bash
# Person 1 (host)
tmux new -s pair
# Share SSH access or use tmate

# Person 2
ssh user@host
tmux attach -t pair
```

**With tmate (easier sharing):**
```bash
# Install tmate (tmux fork for sharing)
tmate new -s pair
# Get share link
tmate show-messages
# Share link with pair
```

---

## Writing & Documentation Workflows

### 1. Documentation Writing

**Layout:**
```
┌─────────────────┬───────────────┐
│                 │               │
│   Editor        │   Preview     │
│   (markdown)    │   (browser)   │
│                 │               │
└─────────────────┴───────────────┘
```

**Commands:**
```bash
tmux new -s docs
nvim README.md
Ctrl-a |
# Use live markdown preview server
npx live-server --port=8080
```

---

### 2. Blog Post Creation

**Layout:**
```
┌─────────────────────────────────┐
│         Editor                  │
├─────────────────┬───────────────┤
│   Hugo Server   │   Git Status  │
└─────────────────┴───────────────┘
```

---

## Custom Session Scripts

### Development Session Script

Save as `~/bin/dev-session`:

```bash
#!/bin/bash
SESSION="dev"

# Check if session exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # Create new session
  tmux new-session -d -s $SESSION -n editor

  # Window 0: Editor
  tmux send-keys -t $SESSION:0 'cd ~/projects && nvim' C-m

  # Window 1: Server
  tmux new-window -t $SESSION:1 -n server
  tmux send-keys -t $SESSION:1 'cd ~/projects' C-m

  # Window 2: Git
  tmux new-window -t $SESSION:2 -n git
  tmux send-keys -t $SESSION:2 'cd ~/projects && git status' C-m

  # Window 3: Logs
  tmux new-window -t $SESSION:3 -n logs

  # Select first window
  tmux select-window -t $SESSION:0
fi

# Attach to session
tmux attach -t $SESSION
```

Make it executable:
```bash
chmod +x ~/bin/dev-session
dev-session  # Run it
```

---

### Multi-Project Manager

Save as `~/bin/project-switch`:

```bash
#!/bin/bash
# Select project and launch tmux session

PROJECTS=(
  "~/work/project-a"
  "~/work/project-b"
  "~/personal/project-c"
)

echo "Select project:"
select PROJECT in "${PROJECTS[@]}"; do
  if [ -n "$PROJECT" ]; then
    SESSION=$(basename "$PROJECT")
    cd "$PROJECT"

    tmux has-session -t $SESSION 2>/dev/null
    if [ $? != 0 ]; then
      tmux new-session -d -s $SESSION
      tmux send-keys -t $SESSION "cd $PROJECT" C-m
    fi

    tmux attach -t $SESSION
    break
  fi
done
```

---

## Advanced Tips

### 1. Synchronized Panes

Run same command in all panes:

```bash
Ctrl-a : setw synchronize-panes on

# Now type appears in all panes
# Useful for multi-server management

Ctrl-a : setw synchronize-panes off
```

---

### 2. Session Nesting

Working on remote server that also uses tmux:

```bash
# Local: Ctrl-a (commands go to local tmux)
# Remote: Ctrl-a Ctrl-a (send prefix to remote)

# Example
Ctrl-a Ctrl-a c  # Create window in remote tmux
```

---

### 3. Copy Between Panes

```bash
# In pane 1
Ctrl-a Escape    # Copy mode
# Select text with v and y

# Switch to pane 2
Ctrl-a l

# Paste
Ctrl-a p
```

---

### 4. Command History Per Pane

Each pane maintains independent shell history!

---

### 5. Automatic Session Saving

With tmux-resurrect plugin:

```bash
# Save session
Ctrl-a Ctrl-s

# Restore session (after reboot)
Ctrl-a Ctrl-r
```

---

## Workflow Templates

### Template: Rapid Prototyping

```bash
tmux new -s proto
# Split into 4 panes (Ctrl-a ", Ctrl-a %)
# 1: Editor
# 2: File watcher (nodemon, etc)
# 3: Browser automation (playwright)
# 4: Notes/documentation
```

### Template: Bug Investigation

```bash
tmux new -s debug
# Window 0: Code editor
# Window 1: Running app with logs
# Window 2: Git bisect/history
# Window 3: Stack Overflow/docs in w3m
```

### Template: Learning New Tech

```bash
tmux new -s learn
# Window 0: Tutorial/documentation
# Window 1: Practice code
# Window 2: REPL/playground
# Window 3: Notes
```

---

## Productivity Tips

1. **One session per project** - Quickly switch contexts
2. **Descriptive names** - Know what's running
3. **Consistent layouts** - Muscle memory
4. **Script repetitive setups** - Save time
5. **Use session groups** - Share windows between sessions
6. **Detach liberally** - tmux persists everything
7. **Kill unused sessions** - Keep it clean

---

**Pro Tip:** Create your most common workflow as a script and alias it. Mine is `dev` which launches my full development environment in seconds!
