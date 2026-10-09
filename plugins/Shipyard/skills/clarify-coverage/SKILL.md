---
name: clarify-coverage
description: Bounded coverage pass on a draft feature. Scan eight categories, ask at most five high-impact questions, and write a Clarifications section back into the draft. Use after grilling, or when a spec brief already exists. Does not replace mattpocock grilling or grill-with-docs.
allowed-tools:
  - AskUserQuestion
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
preconditions:
  - A feature draft is available (conversation, spec brief, or tracker issue)
---

# Clarify Coverage

**Purpose**: Close coverage holes with a short, structured pass, then persist the answers on the draft.

This is not an open interview. Relentless design-tree questioning belongs to mattpocock `grilling` (and `grill-with-docs` when terms or ADRs should be captured as you go). Do not reimplement that interview.

Scan a formed draft whether or not `grilling` is installed. A spec brief, a loaded tracker issue, or a conversation that already states the feature is formed enough. Mention `grilling` only when the draft is still a pile of unsettled branches. If that skill is absent, point at the ShipYard README Companions section and still scan whatever is already decided. Never stop this pass solely because `grilling` is not installed.

## Input

```
$ARGUMENTS
```

Accept a markdown path, a tracker issue reference, or the current conversation. If empty, ask which draft to scan. Do not start without a draft.

## Load the draft

- **Local markdown path** — Read the file.
- **Tracker issue** (number, URL, or key) — Read `docs/agents/issue-tracker.md` when it exists and follow its view operation. Use Bash when that operation is a shell command.
- **Issue body not loaded** (no tracker doc, the command failed, or the host has no tracker tool) — ask the user to paste the issue body. Do not scan an unread reference as if it were empty.
- **Conversation only** — use the current conversation.

## Stage 1: Coverage scan

Mark each category **Clear**, **Partial**, or **Missing**. Keep this scan internal until Stage 4.

| Category | What to check |
|----------|----------------|
| **Functional Scope** | Core user goals, success criteria, explicit out-of-scope |
| **Domain & Data Model** | Entities, attributes, relationships, identity, state transitions |
| **Interaction & UX Flow** | Journeys, error / empty / loading states, accessibility |
| **Non-Functional Requirements** | Performance, scalability, reliability, security, observability |
| **Integration & Dependencies** | External services, data formats, failure modes |
| **Edge Cases & Errors** | Negative paths, conflicts, rate limits |
| **Constraints & Tradeoffs** | Hard constraints, rejected alternatives |
| **Terminology** | Canonical terms, synonyms to avoid |

## Stage 2: At most five questions

Build a queue of up to **5** questions from Partial and Missing categories.

Each question must be:

- Multiple choice (2–4 options) or a short answer (≤5 words)
- High impact: it changes architecture, data shape, task split, or tests
- Unanswered in the draft
- Not a stylistic preference

Order by impact × uncertainty. Skip a second low-impact question while a high-impact category is open.

## Stage 3: Ask one at a time

Use **AskUserQuestion**. One question per turn. Put the recommended option first and suffix it with `(Recommended)`.

Stop when the critical holes are closed, the user says done, or five questions have been asked. Never ask a sixth.

## Stage 4: Write the answers back

Append or replace a `## Clarifications` section on the draft. Do not create `docs/plans/` or `plans/`.

```markdown
## Clarifications

**Session:** YYYY-MM-DD

### Questions & Answers

| # | Question | Answer | Category |
|---|----------|--------|----------|
| 1 | ... | ... | Functional Scope |

### Coverage Summary

| Category | Status |
|----------|--------|
| Functional Scope | Resolved |

### Key Decisions

- **Decision**: rationale from the answer
```

Where to write:

- **Local markdown path** — edit that file.
- **Tracker issue** — follow `docs/agents/issue-tracker.md` if it exists. If it does not, do not guess a tracker CLI. Show the section and tell the user to run `/setup-matt-pocock-skills`, then paste it.
- **Conversation only** — show the section and tell the user to carry it into `to-spec` (Further Notes). Offer to save it on an existing spec brief if one was named.

## Stage 5: Next step

Ask what to do next:

1. **Run `to-spec`** — publish the spec (recommended when the draft is decision-complete)
2. **Run `spec-from-doc`** — only if the source is still a design doc or ADR that has not been turned into a brief
3. **Done**

If every category is already Clear, say so and recommend `to-spec`. Do not invent questions.
