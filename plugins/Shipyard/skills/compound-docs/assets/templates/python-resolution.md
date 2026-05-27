---
module: [Module name]
date: [YYYY-MM-DD]
problem_type: [build_error|test_failure|runtime_error|performance_issue|data_issue|security_issue|ui_bug|integration_issue|logic_error]
severity: [critical|high|medium|low]
language: python
tags: [keyword1, keyword2, keyword3]
---

# Troubleshooting: [Clear Problem Title]

## Problem
[1-2 sentence clear description of the Python issue and what was experienced]

## Environment
- Module: [Name]
- Language: Python
- Python Version: [e.g., 3.10, 3.11]
- Framework: [e.g., Django, Flask, FastAPI, PyTorch]
- Package Manager: [e.g., pip, poetry, conda]
- Affected Component: [e.g., "ORM queries", "Async processing", "Data serialization"]
- Date: [YYYY-MM-DD]

## Symptoms
- [Observable symptom 1 - exceptions, slow performance, unexpected behavior]
- [Observable symptom 2 - specific error tracebacks, warnings, performance metrics]
- [Continue as needed - be specific with actual error output]

## What Didn't Work

**Attempted Solution 1:** [Description of what was tried]
- **Why it failed:** [Technical reason this didn't solve the problem - e.g., still had race condition, memory leak persisted]

**Attempted Solution 2:** [Description of second attempt]
- **Why it failed:** [Technical reason]

[Continue for all significant attempts that DIDN'T work]

[If nothing else was attempted first, write:]
**Direct solution:** The problem was identified and fixed on the first attempt.

## Solution

[The actual fix that worked - provide specific details]

**Code changes** (if applicable):
```python
# Before (broken):
[Show the problematic Python code]
# Example issues: mutable default args, reference cycles, GIL contention, wrong exception handling

# After (fixed):
[Show the corrected Python code with explanation]
# Example fixes: None defaults, weakref, async/await, proper context managers
```

**Dependency changes** (if applicable):
```bash
# pip install commands:
pip install package==version

# or poetry/pyproject.toml changes:
[Show dependency updates]
```

**Configuration changes** (if applicable):
```python
# Settings/config changes:
[Show configuration modifications]
```

## Why This Works

[Technical explanation of:]
1. What was the ROOT CAUSE of the problem?
2. Why does the solution address this root cause?
3. What was the underlying Python concept issue (GIL, reference counting, mutability, etc.)?

[Be detailed enough that future developers understand the Python "why", not just the "what"]

## Prevention

[How to avoid this problem in future Python development:]
- [Specific Python practice, idiom, PEP guideline to follow]
- [What to watch out for - e.g., mutable defaults, global state, blocking I/O in async]
- [How to catch this early - e.g., mypy, pylint, pytest, type hints, code review]

## Related Issues

[If any similar problems exist in docs/solutions/, link to them:]
- See also: [another-related-issue.md](../category/another-related-issue.md)
- Similar to: [related-problem.md](../category/related-problem.md)

[If no related issues, write:]
No related issues documented yet.
