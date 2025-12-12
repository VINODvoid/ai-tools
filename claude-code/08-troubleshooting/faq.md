# FAQ - Frequently Asked Questions

**Quick answers to common questions**

---

## General Questions

**Q: How much does Claude Code cost?**
A: You pay for API usage. Average: $3-6/developer/day for active development. Sonnet: $3 per 1M input tokens, $15 per 1M output tokens.

**Q: Is my code private?**
A: Yes. Code is only sent to Anthropic's API for processing. Not used for training. See privacy policy.

**Q: Can I use Claude Code offline?**
A: No. Requires internet connection to Anthropic's API.

**Q: What's the context window size?**
A: ~200,000 tokens total, ~180,000 usable for your work.

---

## Usage Questions

**Q: How do I reference files?**
A: Use `@` syntax: `@src/app.ts` or `@path/to/file`

**Q: How do I run bash commands?**
A: Use `!` prefix: `! git status` or `! npm test`

**Q: How do I add to memory?**
A: Use `#` prefix or `/memory` command

**Q: How do I clear conversation?**
A: Use `/clear` command

**Q: How do I check token usage?**
A: Use `/context` for tokens, `/cost` for spending

---

## Feature Questions

**Q: Can Claude commit code for me?**
A: Yes. Ask: "Create a commit for these changes"

**Q: Can Claude create pull requests?**
A: Yes. Requires `gh` CLI: "Create a PR"

**Q: Can Claude run tests?**
A: Yes. It can run any bash command including tests

**Q: Does Claude remember between sessions?**
A: Memory files (CLAUDE.md) persist. Conversation history only persists if you resume session.

---

## Troubleshooting

**Q: Why is Claude slow?**
A: Check context usage (`/context`). If high, compact (`/compact`). Consider using Haiku for simple tasks.

**Q: Why did my API key stop working?**
A: Keys can expire or be revoked. Get new key from console.anthropic.com

**Q: How do I update Claude Code?**
A: `npm update -g @anthropic-ai/claude-code` or `claude update`

---

## Best Practices

**Q: Should I put everything in CLAUDE.md?**
A: No. Keep it concise (500-2000 tokens). Reference external docs.

**Q: When should I use subagents?**
A: For self-contained tasks that don't need details in main conversation.

**Q: How often should I compact?**
A: When context reaches 60-70%. Check with `/context`.

**Q: Should I use Opus or Sonnet?**
A: Sonnet for most work. Opus for complex analysis/security reviews.

---

**Still have questions? Check official docs or GitHub issues!** ❓
