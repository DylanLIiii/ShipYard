---
module: [Module name]
date: [YYYY-MM-DD]
problem_type: [build_error|test_failure|runtime_error|performance_issue|data_issue|security_issue|ui_bug|integration_issue|logic_error]
severity: [critical|high|medium|low]
language: cpp
tags: [keyword1, keyword2, keyword3]
---

# Troubleshooting: [Clear Problem Title]

## Problem
[1-2 sentence clear description of the C++ issue and what was experienced]

## Environment
- Module: [Name]
- Language: C++
- Standard: [e.g., C++17, C++20]
- Compiler: [e.g., GCC 11.2, Clang 14]
- Build System: [e.g., CMake, Make, Bazel]
- Affected Component: [e.g., "Memory management", "Concurrency module", "Data structures"]
- Date: [YYYY-MM-DD]

## Symptoms
- [Observable symptom 1 - compiler errors, runtime crashes, unexpected behavior]
- [Observable symptom 2 - specific error messages, valgrind output, ASAN reports]
- [Continue as needed - be specific with actual error output]

## What Didn't Work

**Attempted Solution 1:** [Description of what was tried]
- **Why it failed:** [Technical reason this didn't solve the problem - e.g., still had memory leak, compiler error persisted]

**Attempted Solution 2:** [Description of second attempt]
- **Why it failed:** [Technical reason]

[Continue for all significant attempts that DIDN'T work]

[If nothing else was attempted first, write:]
**Direct solution:** The problem was identified and fixed on the first attempt.

## Solution

[The actual fix that worked - provide specific details]

**Code changes** (if applicable):
```cpp
// Before (broken):
[Show the problematic C++ code]
// Example issues: memory leak, use-after-free, race condition, undefined behavior

// After (fixed):
[Show the corrected C++ code with explanation]
// Example fixes: smart pointers, proper RAII, mutex locking, correct lifetime
```

**Build system changes** (if applicable):
```cmake
# CMakeLists.txt changes:
[Show what was changed]
```

**Compiler flags** (if applicable):
```bash
# Compiler flags added/modified:
[Flags for warnings, sanitizers, standards]
```

## Why This Works

[Technical explanation of:]
1. What was the ROOT CAUSE of the problem?
2. Why does the solution address this root cause?
3. What was the underlying C++ concept issue (RAII, ownership, lifetimes, undefined behavior, etc.)?

[Be detailed enough that future developers understand the C++ "why", not just the "what"]

## Prevention

[How to avoid this problem in future C++ development:]
- [Specific C++ practice, RAII pattern, smart pointer usage, modern C++ idioms to follow]
- [What to watch out for - e.g., manual memory management, raw pointers, data races]
- [How to catch this early - e.g., -Wall -Wextra, sanitizers, static analysis, code review]

## Related Issues

[If any similar problems exist in docs/solutions/, link to them:]
- See also: [another-related-issue.md](../category/another-related-issue.md)
- Similar to: [related-problem.md](../category/related-problem.md)

[If no related issues, write:]
No related issues documented yet.
