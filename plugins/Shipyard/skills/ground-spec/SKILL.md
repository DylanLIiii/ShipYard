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

Launch the plugin's own agents. Their registered definitions supply the system prompt and tools. Do not spawn a generic worker and paste the prompt in as ordinary task text.

Launch all three in the same turn. Pass only the user prompt.

| Agent | Scoped id | User prompt |
|-------|-----------|-------------|
| Repository | `Shipyard:research:repo-research-analyst` | Research repository conventions and patterns for: {feature}. Cite file paths. |
| Best practices | `Shipyard:research:best-practice-research` | Research industry practices relevant to: {feature}. Cite URLs. |
| Framework docs | `Shipyard:research:framework-docs-researcher` | Research framework and library docs relevant to: {feature}. Note versions in this repo. |

The scoped id is the installed plugin name plus the path under `agents/`. On Claude Code the plugin name is `Shipyard`. If the host lists the best-practice agent under its frontmatter name instead of the filename, that id is `Shipyard:research:best-practices-researcher`.

If a scoped agent is not registered, do not invent a `general-purpose` pass as the first choice. Read that agent's file from the installed plugin and use the body after the YAML frontmatter as the worker's system prompt:

`${CLAUDE_PLUGIN_ROOT}/agents/research/repo-research-analyst.md`
`${CLAUDE_PLUGIN_ROOT}/agents/research/best-practice-research.md`
`${CLAUDE_PLUGIN_ROOT}/agents/research/framework-docs-researcher.md`

Claude Code substitutes `${CLAUDE_PLUGIN_ROOT}` when it loads this skill. That directory is the plugin install root, the parent of `skills/` and `agents/`. Never resolve these files from the consumer repository's `plugins/Shipyard/agents/`. If the variable is still unsubstituted or the file is missing, stop and say the plugin agents could not be found.

Collect file paths, external URLs, and conventions from `CLAUDE.md` or `AGENTS.md`. Discard findings that name no source.

## Stage 2: Spec-flow gaps

Launch `Shipyard:core:spec-flow-analyzer` with the feature plus the research findings. Prefer a fast model when the host offers one.

Same fallback as Stage 1, and only when that agent is not registered: read `${CLAUDE_PLUGIN_ROOT}/agents/core/spec-flow-analyzer.md` and use the body after the frontmatter as the system prompt. Do not look for that file in the consumer repository.

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
