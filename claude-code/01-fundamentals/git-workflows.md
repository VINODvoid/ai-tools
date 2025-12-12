# Git Workflows - Master Version Control with Claude

**Complete guide to Git integration, commits, and pull requests**

---

## Table of Contents

- [Git Integration Overview](#git-integration-overview)
- [Basic Git Operations](#basic-git-operations)
- [Commit Workflows](#commit-workflows)
- [Branch Management](#branch-management)
- [Pull Request Creation](#pull-request-creation)
- [Code Review with Claude](#code-review-with-claude)
- [Git Conflict Resolution](#git-conflict-resolution)
- [Advanced Git Workflows](#advanced-git-workflows)
- [GitHub CLI Integration](#github-cli-integration)
- [Best Practices](#best-practices)

---

## Git Integration Overview

### What Claude Can Do with Git

✅ **Can do:**
- Run any git command via Bash tool
- Create commits with generated messages
- Create pull requests via `gh` CLI
- Review code changes
- Analyze git history
- Suggest commit messages
- Resolve merge conflicts
- Generate changelogs

❌ **Should not do (without explicit permission):**
- Force push
- Delete branches
- Rewrite public history
- Skip commit hooks
- Modify git config

### Prerequisites

```bash
# Git should be installed and configured
git --version

# Configure identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# GitHub CLI (for PR creation)
gh --version
# Install if needed: https://cli.github.com/
```

---

## Basic Git Operations

### Checking Status

```
> ! git status

> What's the current git status?

> Show me uncommitted changes
```

**Claude runs git status and reports:**
- Modified files
- Untracked files
- Current branch
- Ahead/behind remote

### Viewing Diffs

```
> ! git diff

> Show me what changed in src/app.ts

> ! git diff --staged

> What are the staged changes?
```

### Viewing History

```
> ! git log --oneline -10

> Show me recent commits

> ! git log --graph --all --oneline -20

> What's the commit history for this feature?
```

### Branch Information

```
> ! git branch

> What branch am I on?

> ! git branch -a

> List all branches including remote
```

---

## Commit Workflows

### Method 1: Let Claude Create Commit

**Simple commit:**
```
> Create a commit for my changes
```

**Claude will:**
1. Run `git status` to see changes
2. Run `git diff` to review modifications
3. Check recent commit messages for style
4. Generate appropriate commit message
5. Stage files (`git add`)
6. Create commit
7. Show result

**With specifications:**
```
> Create a commit for the authentication changes
> Use conventional commits format
> Include breaking changes note
```

### Method 2: Specify Commit Message

```
> Create a commit with message: "feat: add user authentication"

> Commit these changes: "fix: resolve login bug"
```

### Method 3: Interactive Commit Creation

```
> Let's create a commit

# Claude asks:
# - What files to include?
# - Commit type (feat/fix/docs)?
# - Breaking changes?
# - Additional context?

# Then creates commit with your input
```

### Conventional Commits Format

Claude automatically uses conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, no code change
- `refactor`: Code change that neither fixes bug nor adds feature
- `perf`: Performance improvement
- `test`: Adding tests
- `chore`: Maintenance tasks

**Example:**
```
feat(auth): implement JWT authentication

- Add JWT token generation
- Implement refresh token logic
- Add authentication middleware
- Update user model with tokens

🤖 Generated with Claude Code
Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Amending Commits

**When to amend:**
- Pre-commit hook modified files
- Small fix to last commit
- Update commit message

**Verification before amending:**
Claude checks:
1. Last commit is yours (`git log -1 --format='%an %ae'`)
2. Not yet pushed (`git status`)
3. Safe to amend

**Example:**
```
> ! git commit -m "feat: add login"
# Pre-commit hook runs prettier

> Amend the commit to include formatting changes
# Claude verifies it's safe, then amends
```

### Commit Message Best Practices

**Good commit messages:**
```
feat: add user registration endpoint

fix: resolve null pointer in auth middleware (closes #123)

docs: update API documentation for v2 endpoints

refactor: extract validation logic to separate module
```

**Bad commit messages:**
```
Update stuff
Fixed it
WIP
asdfasdf
...
```

Claude generates good messages by:
1. Analyzing actual changes
2. Following conventional commits
3. Being concise but descriptive
4. Including context when needed

---

## Branch Management

### Creating Branches

```
> Create a new branch called feature/user-dashboard

> ! git checkout -b feature/notifications

> Switch to a new branch for the API refactor
```

### Switching Branches

```
> Switch to main branch

> ! git checkout develop

> Go back to previous branch

> ! git checkout -
```

### Listing Branches

```
> Show all branches

> ! git branch -a

> Which branch am I on?
```

### Deleting Branches

```
> Delete the feature/old-feature branch

> ! git branch -d feature/completed

# Delete remote branch
> ! git push origin --delete feature/old
```

### Branch Comparison

```
> Compare current branch with main

> ! git diff main...HEAD

> What changed since branching from main?

> ! git log main..HEAD --oneline
```

---

## Pull Request Creation

### Prerequisites

Install and authenticate GitHub CLI:

```bash
# Install gh CLI
# macOS: brew install gh
# Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

# Authenticate
gh auth login
```

### Method 1: Let Claude Create PR

**Basic PR:**
```
> Create a pull request
```

**Claude will:**
1. Check git status
2. Review all commits since branch diverged
3. Analyze all changes (not just last commit!)
4. Create PR title and description
5. Push branch if needed
6. Create PR via `gh pr create`
7. Return PR URL

**With specifications:**
```
> Create a PR to main branch
> Title: "Add user authentication system"
> Include setup instructions in description
```

### Method 2: Manual PR with Claude-Generated Description

```
> ! git log main..HEAD

> ! git diff main...HEAD

> Based on these changes, write a PR description
```

**Copy the generated description, then:**
```bash
gh pr create --title "Feature X" --body "$(cat description.txt)"
```

### PR Description Format

Claude generates comprehensive PR descriptions:

```markdown
## Summary
- Implemented JWT authentication system
- Added user registration and login endpoints
- Created authentication middleware
- Updated user model with password hashing

## Changes
- `src/auth/` - New authentication module
- `src/middleware/auth.ts` - JWT validation middleware
- `src/routes/auth.ts` - Auth routes (register, login, refresh)
- `src/models/User.ts` - Added password and token fields
- `tests/auth.test.ts` - Authentication tests

## Test Plan
- [ ] User can register with email/password
- [ ] User can login and receive JWT
- [ ] Protected routes require valid JWT
- [ ] Token refresh works correctly
- [ ] Invalid tokens are rejected
- [ ] Passwords are properly hashed

## Breaking Changes
- User model schema changed (migration required)
- New environment variables needed (see .env.example)

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

### PR to Specific Branch

```
> Create a PR to develop branch

> ! gh pr create --base develop --head feature/my-branch
```

### Draft PR

```
> Create a draft PR

> ! gh pr create --draft
```

---

## Code Review with Claude

### Reviewing Your Own Changes

```
> Review my changes before committing

> ! git diff | Review these changes for:
> - Security issues
> - Performance problems
> - Best practices violations
> - Missing error handling
```

### Reviewing Pull Requests

**Method 1: Via URL**
```
> Review this PR: https://github.com/owner/repo/pull/123
```

**Method 2: Via gh CLI**
```
> ! gh pr view 123

> Review PR #123 for security issues
```

**Method 3: Get PR comments**
```
> ! gh api repos/owner/repo/pulls/123/comments

> Summarize the feedback on PR #123
```

### Review Checklist

Claude checks for:

**Security:**
- SQL injection
- XSS vulnerabilities
- Authentication bypasses
- Exposed secrets
- Insecure dependencies

**Performance:**
- N+1 queries
- Inefficient algorithms
- Memory leaks
- Unnecessary re-renders (React)
- Missing indexes (database)

**Best Practices:**
- Code organization
- Naming conventions
- Error handling
- TypeScript type safety
- Test coverage

**Example review:**
```
> Review @src/api/users.ts for security and performance
```

**Claude's response:**
```markdown
## Security Issues
🔴 HIGH: SQL injection vulnerability on line 45
- User input not sanitized in query
- Use parameterized queries

⚠️ MEDIUM: Password not hashed (line 67)
- Storing plaintext passwords
- Use bcrypt

## Performance Issues
⚠️ MEDIUM: N+1 query problem (line 112)
- Loading related data in loop
- Use eager loading or single query

## Best Practices
✅ Good error handling
⚠️ Missing input validation on createUser
🔵 Consider adding JSDoc comments
```

---

## Git Conflict Resolution

### Detecting Conflicts

```
> ! git merge feature-branch
# CONFLICT in src/app.ts

> I have a merge conflict in @src/app.ts
> Help me resolve it
```

### Resolving Conflicts

**Claude can:**
1. Read conflicted file
2. Show both versions
3. Suggest resolution
4. Apply fix
5. Mark as resolved

**Example:**
```
> ! git status
# Conflicted: src/app.ts

> Read @src/app.ts

> The file has merge conflicts
> Here's what each version is trying to do:
>
> Current branch (HEAD): [explains]
> Incoming branch: [explains]
>
> Which resolution do you prefer, or should I merge both?
```

### Conflict Resolution Strategies

**Keep yours:**
```
> ! git checkout --ours src/app.ts
> ! git add src/app.ts
```

**Keep theirs:**
```
> ! git checkout --theirs src/app.ts
> ! git add src/app.ts
```

**Manual merge:**
```
> Merge both changes intelligently in @src/app.ts
> Keep the authentication logic from current branch
> Add the new validation from incoming branch
```

---

## Advanced Git Workflows

### Git Worktrees

**Use case:** Work on multiple features simultaneously

```
> ! git worktree add ../project-feature-a -b feature-a

# In new terminal
cd ../project-feature-a
claude
> Work on feature A here

# Original terminal
claude
> Continue on current feature
```

### Interactive Rebase

```
> ! git log --oneline -5

> Clean up commit history before PR
> Squash "fix typo" and "WIP" commits
> Reword vague commit messages
```

**Claude can:**
- Suggest which commits to squash
- Generate better commit messages
- Create rebase plan

**Don't use `-i` flag directly** (not supported in non-interactive mode):
```
# Instead of: git rebase -i HEAD~5
# Ask Claude to create script:

> Create a git rebase plan for last 5 commits
# Claude provides commands to run
```

### Cherry-Picking

```
> ! git log feature-branch --oneline

> Cherry-pick commit abc123 to current branch

> ! git cherry-pick abc123
```

### Stashing Changes

```
> ! git stash save "WIP: authentication changes"

> ! git stash list

> ! git stash pop

> ! git stash apply stash@{1}
```

### Git Bisect

```
> ! git bisect start
> ! git bisect bad HEAD
> ! git bisect good v1.0.0

# Claude can help test each revision
> ! npm test
# Good or bad?

> ! git bisect good
# Continue until bad commit found
```

---

## GitHub CLI Integration

### Installation

```bash
# macOS
brew install gh

# Linux (Debian/Ubuntu)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Arch
sudo pacman -S github-cli
```

### Authentication

```bash
gh auth login
# Follow prompts to authenticate
```

### Common gh Commands with Claude

**PR Operations:**
```
> ! gh pr list

> ! gh pr view 123

> ! gh pr create --title "Feature X" --body "Description"

> ! gh pr merge 123 --squash

> ! gh pr close 123
```

**Issue Operations:**
```
> ! gh issue list

> ! gh issue create --title "Bug: login fails" --body "Steps to reproduce..."

> ! gh issue view 456
```

**Repository Operations:**
```
> ! gh repo view

> ! gh repo clone owner/repo

> ! gh repo fork
```

**Workflow Operations:**
```
> ! gh run list

> ! gh run view 789

> ! gh workflow view ci.yml
```

### Using gh with Claude

**Create issue from error:**
```
> ! npm test
# Tests fail with error

> Create a GitHub issue for this test failure
# Include error details and stack trace
```

**Get PR comments:**
```
> ! gh api repos/owner/repo/pulls/123/comments

> Summarize PR feedback and create response
```

---

## Best Practices

### 1. Meaningful Commit Messages

✅ **Good:**
```
feat(auth): implement password reset flow

- Add reset token generation
- Create reset email template
- Add reset route handler
- Include expiration logic (24h)

Closes #234
```

❌ **Bad:**
```
updated files
fix
WIP
...
```

### 2. Atomic Commits

**Each commit should:**
- Do one thing
- Be self-contained
- Pass all tests
- Be revertible independently

**Example workflow:**
```
# Commit 1
> Add User model with basic fields

# Commit 2
> Add validation to User model

# Commit 3
> Create UserService with CRUD operations

# Commit 4
> Add tests for UserService
```

### 3. Review Before Commit

```
> ! git status
# See what's changed

> ! git diff
# Review all changes

> Analyze these changes for issues

# Fix any problems

> Create commit
```

### 4. Never Commit Secrets

```
# Check for secrets before commit
> ! git diff | grep -i "password\|secret\|key\|token"

> Are there any secrets in my staged changes?
```

**If secrets were committed:**
```
# Remove from history
> ! git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all

# Rotate the exposed secrets!
```

### 5. Keep Commits Clean

```
# Before creating PR
> ! git log main..HEAD --oneline

> Clean up commit history
> Squash WIP and fixup commits
> Reword vague messages
```

### 6. Test Before Push

```
> ! npm test

# If tests pass:
> ! git push

# If tests fail:
> Fix failing tests first
```

### 7. Use .gitignore

```
> Check if .gitignore is properly configured

> Add node_modules/ to .gitignore

> Make sure .env files are ignored
```

### 8. Branch Naming

**Good branch names:**
```
feature/user-authentication
bugfix/login-redirect
hotfix/security-patch
refactor/api-routes
docs/api-documentation
```

**Bad branch names:**
```
test
my-branch
fix
temp
asdf
```

---

## Complete Workflows

### Workflow 1: Feature Development

```
# 1. Create branch
> ! git checkout -b feature/user-profile

# 2. Make changes with Claude
> Implement user profile editing

# 3. Test
> ! npm test

# 4. Commit
> Create a commit for the profile feature

# 5. Push
> ! git push -u origin feature/user-profile

# 6. Create PR
> Create a pull request to main
```

### Workflow 2: Bug Fix

```
# 1. Create bugfix branch
> ! git checkout -b bugfix/login-timeout

# 2. Reproduce bug
> ! npm start
# Reproduce the issue

# 3. Fix with Claude
> Fix the login timeout issue in @src/auth/login.ts

# 4. Verify fix
> ! npm test
> # Manually test

# 5. Commit
> Create commit fixing login timeout (closes #123)

# 6. Push and PR
> ! git push -u origin bugfix/login-timeout
> Create a PR with bug fix details
```

### Workflow 3: Code Review and Merge

```
# 1. Get PR for review
> ! gh pr checkout 456

# 2. Review changes
> ! git diff main...HEAD

> Review these changes for:
> - Code quality
> - Security
> - Performance
> - Tests

# 3. Request changes or approve
> ! gh pr review 456 --comment --body "LGTM! Great work on error handling."

# 4. Merge
> ! gh pr merge 456 --squash
```

### Workflow 4: Hotfix

```
# 1. Branch from production
> ! git checkout main
> ! git checkout -b hotfix/critical-security-fix

# 2. Implement fix
> Fix the security vulnerability in @src/auth/

# 3. Test thoroughly
> ! npm test
> ! npm run e2e

# 4. Commit
> Create commit for security hotfix

# 5. PR to main
> Create PR to main (hotfix: security patch)

# 6. After merge, also merge to develop
> ! git checkout develop
> ! git merge main
```

---

## Troubleshooting

### Issue: Commit Hooks Fail

```
> ! git commit -m "feat: add feature"
# Pre-commit hook fails

> The pre-commit hook modified files
> Amend the commit to include these changes
```

### Issue: Push Rejected

```
> ! git push
# rejected: non-fast-forward

> ! git pull --rebase origin main
> # Resolve any conflicts
> ! git push
```

### Issue: Wrong Commit

```
> I committed to wrong branch

> ! git log -1
# Get commit hash

> ! git checkout correct-branch
> ! git cherry-pick abc123

> ! git checkout wrong-branch
> ! git reset --hard HEAD~1
```

### Issue: Need to Undo Commit

```
# Keep changes, undo commit
> ! git reset --soft HEAD~1

# Discard changes and commit
> ! git reset --hard HEAD~1

# Undo push (dangerous!)
> ! git push --force-with-lease
# Only if you haven't shared the branch!
```

---

## Quick Reference

### Essential Git Commands

```bash
# Status and info
git status
git log --oneline -10
git diff
git branch

# Making changes
git add .
git commit -m "message"
git push

# Branching
git checkout -b feature-name
git checkout main
git merge feature-name
git branch -d feature-name

# GitHub CLI
gh pr create
gh pr list
gh pr merge 123
gh issue create
```

### Claude Git Prompts

```
# Commits
> Create a commit for these changes
> Generate a commit message for my changes
> Amend last commit with new changes

# PRs
> Create a pull request
> Review PR #123
> Summarize PR feedback

# Review
> Review my changes for security issues
> What changed since main branch?
> Are there any problems with these changes?

# Conflicts
> Help resolve merge conflicts in @file.ts
> Explain this merge conflict

# History
> Show recent commits
> What changed in last 5 commits?
> Create changelog from git history
```

---

## Next Steps

- **Context Optimization** → [../02-optimization/token-management.md](../02-optimization/token-management.md)
- **Workflow Patterns** → [../03-intermediate/workflow-patterns.md](../03-intermediate/workflow-patterns.md)
- **CI/CD Integration** → [../04-advanced/enterprise-patterns.md](../04-advanced/enterprise-patterns.md)

---

**Master Git with Claude and ship code faster!** 🚀
