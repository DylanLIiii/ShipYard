---
name: resolve-comments
description: Fetch open PR review comments, implement the requested changes, and mark them resolved. Use when the user wants to address, fix, or resolve PR feedback.
---

# Resolve PR Comments

## Trigger

PR has open review comments that need to be addressed with code changes.

## Workflow

1. Resolve the active PR for the current branch.
2. Fetch open review comments:
   ```bash
   gh api repos/{owner}/{repo}/pulls/{pr}/comments --jq '.[] | select(.position != null) | {path: .path, line: .line, body: .body, id: .id}'
   ```
3. Group comments by file and prioritize by severity.
4. For each actionable comment:
   - Read the relevant file and surrounding context.
   - Implement the requested change with a minimal, focused edit.
   - Verify the fix doesn't break anything (type-check, tests).
5. Commit fixes and push.
6. Summarize what was resolved.

## Guardrails

- Only address what the reviewer asked for—don't refactor beyond the comment scope.
- If a comment is unclear or conflicts with another, flag it for the user instead of guessing.
- Prefer one commit per logical group of related comments.
- Run tests before pushing to avoid introducing new failures.

## Output

- List of comments addressed with file locations
- Any comments skipped (with reason)
- Current branch status after push
