---
name: ground-spec
description: Before to-spec, run repo, best-practice, and framework research plus a spec-flow gap pass, and save a grounding note. Does not write an implementation plan or tickets.
allowed-tools:
  - Task
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - AskUserQuestion
preconditions:
  - A feature description, spec brief, or tracker issue to ground
---

# Ground Spec

**Purpose**: Ground a feature in this repo and in user-flow gaps before `to-spec` publishes it.

`to-spec` already explores the repo in one pass. This skill is the heavier pass: three research agents plus spec-flow analysis. Ticket slicing, blocking edges, and a dependency frontier belong to mattpocock `to-tickets`. Do not emit a phase table, `[PARALLEL]` tags, or a `docs/plans/` file.

If `to-spec` is not installed, stop and point at the ShipYard README Companions section. Research can still be saved; do not invent a replacement spec.

## Input

```
$ARGUMENTS
```

A feature description, a `docs/spec-briefs/` path, or an issue reference. If empty, ask for one.

When `GLOSSARY.md` or `docs/adr/` exists, include those paths in every agent prompt.

## Stage 1: Research, in parallel

For each agent, Read the prompt file and use the body after the YAML frontmatter as the Task system prompt. Launch all three `general-purpose` Task agents in the same turn.

| Agent | Prompt file | User prompt |
|-------|-------------|-------------|
| Repository | `plugins/Shipyard/agents/research/repo-research-analyst.md` | Research repository conventions and patterns for: {feature}. Cite file paths. |
| Best practices | `plugins/Shipyard/agents/research/best-practice-research.md` | Research industry practices relevant to: {feature}. Cite URLs. |
| Framework docs | `plugins/Shipyard/agents/research/framework-docs-researcher.md` | Research framework and library docs relevant to: {feature}. Note versions in this repo. |

Collect file paths, external URLs, and conventions from `CLAUDE.md` or `AGENTS.md`. Discard findings that name no source.

## Stage 2: Spec-flow gaps

Launch one `general-purpose` Task agent. Prefer a fast model when the host offers one.

- System prompt: body of `plugins/Shipyard/agents/core/spec-flow-analyzer.md` after the frontmatter
- User prompt: the feature plus the research findings

Keep the agent's flow overview, permutation matrix, and prioritized gaps. Do not interview the user from this list. Recording the questions is the point; answering them is `clarify-coverage` or `grilling`.

## Stage 3: Write the note

Write `docs/spec-briefs/<feature-slug>.grounding.md`:

```markdown
---
kind: grounding-note
created: YYYY-MM-DD
feature: <feature name>
status: handoff
---

# Grounding: <feature name>

Handoff for mattpocock `to-spec`. Not an implementation plan.

## Repo conventions

- path or convention, with a file reference

## External references

- title — URL

## User-flow gaps

- gap, impact, and the assumption if it stays unanswered

## Questions worth a coverage pass

1. ...
```

## Stage 4: Hand off

Summarize the note path and the highest-impact gaps.

Ask:

1. **Run `to-spec`** — publish now, with this note in context (recommended when gaps are minor)
2. **Run `clarify-coverage`** — answer at most five of the questions above, then `to-spec`
3. **Done**

Do not start implementation. Do not break the work into tickets; that is `to-tickets` after the spec exists.
