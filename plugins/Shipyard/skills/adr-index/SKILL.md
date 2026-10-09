---
name: adr-index
description: List decision candidates in a spec or brief, then maintain docs/adr/README.md and back-links after domain-modeling writes the ADRs. Does not write ADR bodies.
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - AskUserQuestion
preconditions:
  - A spec, spec brief, tracker issue, or existing docs/adr/ files
---

# ADR Index

**Purpose**: Keep an index and back-links for ADRs, and surface which decisions in a draft are worth recording.

Writing the ADR is mattpocock `domain-modeling`: the three-part test (hard to reverse, surprising without context, a real trade-off) and `ADR-FORMAT.md`. This skill does not define a second ADR template and does not write `docs/adr/NNNN-*.md` bodies. If `domain-modeling` is not installed, stop before any recording step and point at the ShipYard README Companions section. Refreshing the index from files already on disk does not require that skill.

## Input

```
$ARGUMENTS
```

A local markdown path, a tracker issue, "index only", or empty. If empty, ask whether to scan a draft or only refresh the index.

## Step 1: Candidates

Skip this step for "index only".

Scan the draft for settled decisions:

- Sections named Architecture, Design Decisions, Chosen Approach, or Technology Selection
- "We will use X", "We chose X over Y", "Rejected Y because"
- A diagram or brief that encodes one chosen structure
- An explicit trade-off

Present one sentence per candidate with **AskUserQuestion**. The user picks any subset, or none.

For each selected candidate, check the three-part test out loud. Drop any candidate that fails it, and say why. Hand the rest to `domain-modeling` to write. Wait until those files exist before Step 3. Do not draft the ADR prose here.

## Step 2: Refresh the index

Glob `docs/adr/[0-9][0-9][0-9][0-9]-*.md`. If none exist, say so and stop.

For each file, read the start of the file:

- **Number** — the four digits in the filename
- **Title** — frontmatter `title`, else the first heading, else the filename slug
- **Date** — frontmatter `created` or `date`, else `—`
- **Status** — frontmatter `status`, else a `Status` line, else `—`

Rewrite `docs/adr/README.md` from those files, sorted by number. Append-only is not required; the table is rebuilt so renamed files do not leave stale rows. Do not delete ADR files.

```markdown
# Architecture Decision Records

| # | Title | Date | Status |
|---|-------|------|--------|
| [0001](0001-example.md) | Example | YYYY-MM-DD | accepted |
```

## Step 3: Back-links

Offer to point the source at the ADRs just recorded.

- **Local markdown** — add an `adr-refs` list to its YAML frontmatter. Create a frontmatter block if the file has none.
- **Tracker issue** — follow `docs/agents/issue-tracker.md` when it exists. If it does not, show the link lines and tell the user to run `/setup-matt-pocock-skills` rather than guessing a CLI.
- **No source** — index only.

```yaml
adr-refs:
  - docs/adr/0001-example.md
```

Do not remove existing `adr-refs` entries. Add missing ones.

## Done

Report the index path, the rows written, and any back-links added. Ticket breakdown is `to-tickets`, not this skill.
