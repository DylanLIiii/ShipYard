---
name: fix-ci
description: Diagnose and fix GitHub Actions CI failures. Inspects workflow runs and logs, identifies root causes, implements minimal fixes, and pushes. Use when CI is failing, red, broken, or needs diagnosis.
---

# Fix CI

## Trigger

Branch or PR CI is failing and needs a fast, iterative path to green checks.

## Prerequisites

Verify GitHub CLI authentication before proceeding:

```bash
gh auth status
```

If not authenticated, instruct the user to run `gh auth login` first.

## Workflow

### 1. Locate the Failing Run

Resolve the active PR and inspect checks:

```bash
gh pr checks --json name,bucket,state,workflow,link
```

If working on a PR branch:

```bash
gh pr view --json statusCheckRollup --jq '.statusCheckRollup[] | select(.conclusion == "FAILURE")'
```

If working from a branch or run ID:

```bash
gh run list --branch <branch> --status failure --limit 5
gh run view <run-id> --verbose
```

### 2. Extract Failure Logs

Pull logs from failed steps to identify the root cause:

```bash
gh run view <run-id> --log-failed
```

For deeper inspection:

```bash
gh run view <run-id> --log --job <job-id>
gh run download <run-id> -D .artifacts/<run-id>
```

### 3. Identify Root Cause

Analyze logs for common failure patterns:

- **Build/compilation errors**: Missing dependencies, type errors, syntax issues
- **Test failures**: Assertion failures, timeouts, flaky tests
- **Linting/formatting**: Style violations, unused imports
- **Environment issues**: Missing secrets, permissions, resource limits

Prefer the smallest fix that resolves the issue. Deterministic code fixes are better than workflow plumbing changes.

### 4. Implement the Fix

Make minimal, scoped changes matching the repository's existing style:

- Fix only what's broken—avoid unrelated refactoring
- Keep changes to the failing job/step when possible
- If modifying workflow files, preserve existing permissions and avoid expanding token access

### 5. Push and Verify

Push the fix and monitor:

```bash
gh run list --branch <branch> --limit 1
gh run watch <new-run-id> --exit-status
```

To rerun only failed jobs:

```bash
gh run rerun <run-id> --failed
```

Repeat until green.

## Guardrails

- Fix one actionable failure at a time.
- Prefer minimal, low-risk changes before broader refactors.
- Keep `gh pr checks` as the source of truth for overall PR CI state.
- Avoid `pull_request_target` unless explicitly requested—it can expose secrets to untrusted code.
- Keep workflow `permissions:` minimal; don't broaden access to make tests pass.
- For flaky tests, prefer deterministic fixes over blind reruns.

## Output

- **Failing run**: Link or ID
- **Root cause**: What broke and why
- **Fixes applied**: In iteration order
- **Verification**: Current CI status and next action
