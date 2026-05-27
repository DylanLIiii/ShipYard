---
module: [Module name]
date: [YYYY-MM-DD]
problem_type: [build_error|test_failure|runtime_error|performance_issue|data_issue|security_issue|ui_bug|integration_issue|logic_error]
severity: [critical|high|medium|low]
language: rust
tags: [keyword1, keyword2, keyword3]
---

# Troubleshooting: [Clear Problem Title]

## Problem
[1-2 sentence clear description of the Rust issue and what was experienced]

## Environment
- Module: [Name]
- Language: Rust
- Rust Edition: [e.g., 2021]
- Rust Version: [e.g., 1.70]
- Package Manager: [Cargo]
- Affected Component: [e.g., "Borrow checker issues", "Async/await", "Trait system"]
- Date: [YYYY-MM-DD]

## Symptoms
- [Observable symptom 1 - borrow checker errors, compile errors, panics]
- [Observable symptom 2 - specific compiler error messages, clippy warnings]
- [Continue as needed - be specific with actual error output]

## What Didn't Work

**Attempted Solution 1:** [Description of what was tried]
- **Why it failed:** [Technical reason this didn't solve the problem - e.g., borrow checker still complained, runtime panic]

**Attempted Solution 2:** [Description of second attempt]
- **Why it failed:** [Technical reason]

[Continue for all significant attempts that DIDN'T work]

[If nothing else was attempted first, write:]
**Direct solution:** The problem was identified and fixed on the first attempt.

## Solution

[The actual fix that worked - provide specific details]

**Code changes** (if applicable):
```rust
// Before (broken):
[Show the problematic Rust code]
// Example issues: borrow checker errors, lifetime issues, trait bounds, unwrap/expect panics

// After (fixed):
[Show the corrected Rust code with explanation]
// Example fixes: proper borrowing, correct lifetimes, using ?, Result propagation, Clone
```

**Dependency changes** (if applicable):
```toml
# Cargo.toml changes:
[Show dependency updates]
```

**Cargo.toml features** (if applicable):
```toml
# Feature flags added/modified:
[Show feature changes]
```

## Why This Works

[Technical explanation of:]
1. What was the ROOT CAUSE of the problem?
2. Why does the solution address this root cause?
3. What was the underlying Rust concept issue (ownership, borrowing, lifetimes, Send/Sync, etc.)?

[Be detailed enough that future developers understand the Rust "why", not just the "what"]

## Prevention

[How to avoid this problem in future Rust development:]
- [Specific Rust practice, idiom, ownership pattern to follow]
- [What to watch out for - e.g., interior mutability, ref cells, unwrap in production]
- [How to catch this early - e.g., clippy, miri, tests, audit, code review]

## Related Issues

[If any similar problems exist in docs/solutions/, link to them:]
- See also: [another-related-issue.md](../category/another-related-issue.md)
- Similar to: [related-problem.md](../category/related-problem.md)

[If no related issues, write:]
No related issues documented yet.
