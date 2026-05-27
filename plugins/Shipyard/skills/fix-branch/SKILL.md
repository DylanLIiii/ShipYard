---
name: fix-branch
description: Fix issues on the current branch — CI failures, review comments, merge conflicts, code slop — and get it ready to ship. Use when a branch needs fixing, cleaning, or preparing for merge.
---

# Fix Branch

Comprehensive skill for getting a branch from broken/messy to merge-ready. Routes to the appropriate sub-workflow based on what needs fixing.

## Trigger

Use when:
- CI is failing
- PR has unresolved review comments
- Branch has merge conflicts
- Code has AI slop or quality issues
- Branch needs final review before shipping

## Workflow

1. Assess the current branch state:
   ```bash
   git status
   gh pr checks --json name,bucket,state,workflow,link
   gh api repos/{owner}/{repo}/pulls/{pr}/comments --jq '[.[] | select(.in_reply_to_id == null)] | length'
   ```

2. Identify what needs fixing and address issues in priority order:
   - **CI failures** → Follow the [fix-ci](reference/fix-ci-faulire.md) workflow
   - **Open review comments** → Follow the [resolve-comments](reference/resolve-comments.md) workflow
   - **Merge conflicts** → Follow the [merge-conflicts](reference/merge-conflicts.md) workflow
   - **Code slop** → Follow the [deslop](reference/deslop.md) workflow
   - **PR not review-ready** → Follow the [pr-better-to-review](reference/pr-better-to-review.md) workflow
   - **Ready to ship** → Follow the [review-and-ship](reference/review-and-ship.md) workflow

3. After each fix, re-assess and move to the next issue until the branch is green and clean.

## Guardrails

- Fix one category of issue at a time before moving to the next.
- Always run tests after changes to avoid introducing new failures.
- Keep commits focused — one commit per fix category.
- Don't bypass hooks or force-push without explicit user approval.

## Output

- Summary of issues found and fixed
- Current CI status
- PR readiness assessment
