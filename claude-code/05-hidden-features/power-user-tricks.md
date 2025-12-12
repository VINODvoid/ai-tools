# Power User Tricks - Hidden Capabilities

**Advanced techniques**

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Tab` | Toggle thinking |
| `Ctrl+C` | Exit |
| `Ctrl+L` | Clear screen |
| `!cmd` | Run bash |
| `@file` | Reference file |
| `#text` | Quick memory |

---

## Advanced Patterns

### Pipe Chains
```bash
cat log | grep ERROR | claude -p "Analyze"
```

### JSON Processing
```bash
claude -p "Generate data" --json-schema '{...}' | jq
```

### Multi-Directory
```bash
claude --add-dir ~/utils --add-dir ~/configs
```

---

**Become a power user!** 🚀
