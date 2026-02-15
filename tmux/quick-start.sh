#!/bin/bash
# Quick Start Script for Tmux
# This creates a demo session to help you learn tmux

echo "🚀 Tmux Quick Start Demo"
echo "========================"
echo ""
echo "This script will create a demo tmux session with:"
echo "  - Multiple panes showing different views"
echo "  - Example commands"
echo "  - Interactive tutorial"
echo ""
read -p "Press Enter to continue..."

# Check if tmux is installed
if ! command -v tmux &> /dev/null; then
    echo "❌ Tmux is not installed!"
    exit 1
fi

# Kill existing demo session if it exists
tmux kill-session -t tmux-demo 2>/dev/null

# Create new session
tmux new-session -d -s tmux-demo -n "Welcome"

# Send welcome message to first pane
tmux send-keys -t tmux-demo:0 'clear' C-m
tmux send-keys -t tmux-demo:0 'echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"' C-m
tmux send-keys -t tmux-demo:0 'echo "   Welcome to Tmux! "' C-m
tmux send-keys -t tmux-demo:0 'echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"' C-m
tmux send-keys -t tmux-demo:0 'echo ""' C-m
tmux send-keys -t tmux-demo:0 'echo "🎨 Theme: Catppuccin Mocha (Beautiful!)"' C-m
tmux send-keys -t tmux-demo:0 'echo ""' C-m
tmux send-keys -t tmux-demo:0 'echo "Key Bindings Reference:"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a ?  - Show all key bindings"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a |  - Split vertically"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a -  - Split horizontally"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a h/j/k/l - Navigate panes"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a g  - Git status popup"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a c  - New window"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a d  - Detach session"' C-m
tmux send-keys -t tmux-demo:0 'echo "  Ctrl-a r  - Reload config"' C-m
tmux send-keys -t tmux-demo:0 'echo ""' C-m
tmux send-keys -t tmux-demo:0 'echo "🔌 Plugins: Press Ctrl-a I to install"' C-m
tmux send-keys -t tmux-demo:0 'echo "💾 Auto-save: Sessions auto-save every 15min"' C-m
tmux send-keys -t tmux-demo:0 'echo ""' C-m
tmux send-keys -t tmux-demo:0 'echo "📚 Documentation: ~/Documents/projects/ai-tools/tmux/"' C-m
tmux send-keys -t tmux-demo:0 'echo ""' C-m

# Split vertically
tmux split-window -h -t tmux-demo:0

# Send info to right pane
tmux send-keys -t tmux-demo:0.1 'clear' C-m
tmux send-keys -t tmux-demo:0.1 'echo "📊 System Info"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "━━━━━━━━━━━━━━"' C-m
tmux send-keys -t tmux-demo:0.1 'echo ""' C-m
tmux send-keys -t tmux-demo:0.1 'tmux -V' C-m
tmux send-keys -t tmux-demo:0.1 'echo ""' C-m
tmux send-keys -t tmux-demo:0.1 'echo "Current session: tmux-demo"' C-m
tmux send-keys -t tmux-demo:0.1 'echo ""' C-m
tmux send-keys -t tmux-demo:0.1 'echo "Try these modern features:"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "  • Ctrl-a z  - Zoom this pane"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "  • Ctrl-a g  - Git popup"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "  • Ctrl-a G  - Generic popup"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "  • Ctrl-a s  - Sync panes"' C-m
tmux send-keys -t tmux-demo:0.1 'echo "  • Ctrl-a t  - Show clock"' C-m
tmux send-keys -t tmux-demo:0.1 'echo ""' C-m
tmux send-keys -t tmux-demo:0.1 'echo "Vim users: Seamless navigation!"' C-m

# Select left pane
tmux select-pane -t tmux-demo:0.0

# Create second window - Development Layout
tmux new-window -t tmux-demo:1 -n "Dev-Layout"
tmux send-keys -t tmux-demo:1 'clear' C-m
tmux send-keys -t tmux-demo:1 'echo "💻 Development Layout Example"' C-m
tmux send-keys -t tmux-demo:1 'echo ""' C-m
tmux send-keys -t tmux-demo:1 'echo "This is how a typical dev setup looks:"' C-m
tmux send-keys -t tmux-demo:1 'echo "  • Editor on left"' C-m
tmux send-keys -t tmux-demo:1 'echo "  • Terminal on top right"' C-m
tmux send-keys -t tmux-demo:1 'echo "  • Logs on bottom right"' C-m

# Split for dev layout
tmux split-window -h -t tmux-demo:1
tmux send-keys -t tmux-demo:1.1 'clear && echo "🔧 Commands" && echo "" && ls -la' C-m

tmux split-window -v -t tmux-demo:1.1
tmux send-keys -t tmux-demo:1.2 'clear && echo "📝 Logs Area" && echo "" && echo "Waiting for logs..."' C-m

# Select editor pane
tmux select-pane -t tmux-demo:1.0

# Create third window - Monitoring
tmux new-window -t tmux-demo:2 -n "Monitoring"
tmux send-keys -t tmux-demo:2 'clear' C-m
tmux send-keys -t tmux-demo:2 'echo "📊 Monitoring Example"' C-m
tmux send-keys -t tmux-demo:2 'echo ""' C-m
tmux send-keys -t tmux-demo:2 'echo "Running: top"' C-m
tmux send-keys -t tmux-demo:2 'echo "(Press q to exit top)"' C-m
tmux send-keys -t tmux-demo:2 'sleep 2 && top' C-m

# Select first window
tmux select-window -t tmux-demo:0

# Attach to session
echo ""
echo "✅ Demo session created!"
echo ""
echo "Attaching to tmux-demo session..."
echo ""
echo "When inside tmux:"
echo "  • Use Ctrl-a n/p to switch windows"
echo "  • Use Ctrl-a d to detach (exit without closing)"
echo "  • Type 'exit' or Ctrl-d to close the session"
echo ""
sleep 2

tmux attach -t tmux-demo
