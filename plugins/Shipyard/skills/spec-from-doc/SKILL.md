---
name: spec-from-doc
description: Turn an existing design doc or ADR into a short spec brief (non-goals, success criteria, edge cases, gap-filling) for mattpocock to-spec to publish. Does not write the tracker spec itself.
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - AskUserQuestion
preconditions:
  - A design document, ADR, or other existing write-up to read
---

# Spec From Doc

**Purpose**: Pull the spec-shaped facts out of an existing design doc or ADR so mattpocock `to-spec` can publish them. `to-spec` synthesizes the current conversation onto the issue tracker. It does not read a prior design file, and it has no required success criteria or edge-case section. This skill fills that gap and then stops.

Do not write a second full spec. Do not copy the `to-spec` section list into this repo. If `to-spec` is not installed, stop and point at the ShipYard README Companions section.

## Input

```
$ARGUMENTS
```

A file path, or pasted text. If empty, ask for a path or paste. Do not proceed without source material.

## Stage 1: Read

- Read the source file (or each file, if several).
- Treat ADR rationale and rejected alternatives as context, not as requirements.
- Strip implementation detail: frameworks, languages, databases, API paths, infrastructure. The brief is what and why.

## Stage 2: Extract only what is grounded

| Element | Look for |
|---------|----------|
| **Feature name** | Title or dominant topic, 2–5 words |
| **Actors** | Users, admins, systems |
| **In-scope behavior** | What the feature does: user goals, capabilities, flows, and functional requirements that are in scope |
| **Non-goals** | "out of scope", "not included", "future work", "does not cover" |
| **Success signals** | Goals, KPIs, "done when" |
| **Edge cases** | Failure modes, boundaries, unresolved scenarios |
| **Open gaps** | TBDs, questions, decisions the source does not settle |

Rules:

- Never invent a requirement that the source does not support. Flag the gap instead.
- Every in-scope behavior you can ground in the source goes in the brief. A requirement that is not a success metric still counts. Do not leave it only in the source file.
- If the source states no non-goals, derive at most two from clearly adjacent scope and mark each `(derived)`.
- If the source states no measurable outcome, write "Source stated no measurable success criterion." Do not invent a metric.
- Mark inferred edge cases `(inferred)`.

## Stage 3: Close at most three gaps

Keep at most **3** gaps, the ones with the most scope, security, or UX impact. Make a noted assumption for the rest.

Ask **one** gap at a time with **AskUserQuestion**. Offer a recommended option. After the answers, drop the gap markers. Do not leave `[NEEDS CLARIFICATION]` in the saved brief.

## Stage 4: Write the brief

Write `docs/spec-briefs/<feature-slug>.md`:

```markdown
---
kind: spec-brief
created: YYYY-MM-DD
feature: <feature name>
source: <path, or "pasted">
status: handoff
---

# Spec brief: <feature name>

Handoff for mattpocock `to-spec`. This file is not the published spec.

## Actors

- ...

## In-scope behavior

Grounded, implementation-agnostic requirements. These are not success criteria.

- ...

## Non-goals

- NG-001: ...

## Success criteria

- SC-001: <measurable, technology-agnostic outcome>
- or: Source stated no measurable success criterion.

## Edge cases

- ...

## Gaps resolved

| Question | Answer |
|----------|--------|
| ... | ... |

## Assumptions for gaps not asked

- ...
```

Create `docs/spec-briefs/` only when the brief is written.

If the source file is under `docs/` and has YAML frontmatter, add `spec-brief: docs/spec-briefs/<feature-slug>.md` inside that frontmatter.

## Stage 5: Hand off

Tell the user the brief path, how many in-scope behaviors, non-goals, success criteria, and edge cases it holds, and which items were derived or inferred. The `source` field is the check: if a behavior from the source is missing here, read the source again before handing off.

Ask them to run `to-spec` with this brief in context, and to place:

- In-scope behavior → Solution and User Stories. Do not drop these because they are not measurable success criteria.
- Non-goals → Out of Scope
- Success criteria and edge cases → Further Notes

Do not publish the tracker issue from this skill.
