# Multi-Agent Orchestration - Coordinate Multiple Agents

**Advanced patterns for managing multiple subagents simultaneously**

---

## Table of Contents

- [Parallel Agent Execution](#parallel-agent-execution)
- [Agent Pipelines](#agent-pipelines)
- [Agent Coordination Patterns](#agent-coordination-patterns)
- [Resource Management](#resource-management)

---

## Parallel Agent Execution

### Running Multiple Agents

**Launch agents in parallel:**
```
> Launch these agents simultaneously:
> 1. Explore subagent: find all API endpoints
> 2. Code-reviewer: review recent changes
> 3. Test-runner: execute test suite
```

**Benefits:**
- Work completes faster
- Independent tasks don't block each other
- Efficient resource usage

---

## Agent Pipelines

### Sequential Processing

**Create processing pipeline:**
```
Step 1: Explore subagent finds files
Step 2: Security-auditor reviews findings
Step 3: Test-generator creates tests
Step 4: Test-runner executes tests
```

---

## Agent Coordination Patterns

### Pattern 1: Research → Implement

```
> Use Plan subagent to research caching strategies
# Returns: Recommendations for Redis caching

> Use general-purpose subagent to implement recommended caching
```

### Pattern 2: Generate → Review → Fix

```
> Generate API endpoints for products
> Use code-reviewer to review generated code
> Fix issues found in review
```

---

## Resource Management

### Managing Agent Context

**Each agent has separate context:**
- Main conversation: Your context
- Each subagent: Independent context
- Results flow back to main

**Token efficiency:**
- Subagents don't pollute main context
- Use cheaper models for simple tasks
- Parallel work completes faster

---

**Master multi-agent orchestration!** 🎭
