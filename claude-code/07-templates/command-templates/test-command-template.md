---
description: Run all tests and report results
allowed-tools: Bash
model: sonnet
---

Run comprehensive test suite:

1. Unit tests: !`npm test`
2. Integration tests: !`npm run test:integration`
3. E2E tests: !`npm run test:e2e`

Analyze results:
- Report pass/fail counts
- Show any failing tests
- Suggest fixes for failures
- Verify coverage >80%

If all pass: ready to commit
If failures: show errors and recommend fixes
