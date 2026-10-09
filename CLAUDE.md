# CLAUDE.md

Guidance for agents working in this repository.

## Repository Overview

This is **ShipYard** (`DylanLIiii/ShipYard`): a Claude Code / Codex plugin marketplace with two plugins, `plugins/Shipyard` and `plugins/Research`.

Planning, test-first implementation, and diff review for the Shipyard plugin are companion skills, not files in this tree. See `README.md` for the replacement table and install commands.

```text
ShipYard/
├── .claude-plugin/marketplace.json
├── plugins/Shipyard/
│   ├── agents/
│   │   ├── core/spec-flow-analyzer.md
│   │   └── research/          # repo, best-practice, framework-docs
│   ├── skills/
│   └── .mcp.json
└── plugins/Research/          # plugin name: research
    ├── .claude-plugin/plugin.json
    └── skills/scientific-scaling-ladder/
```

## Skills in this tree

### Shipyard

| Directory | name |
|-----------|------|
| `skills/clarify-coverage/` | `clarify-coverage` |
| `skills/spec-from-doc/` | `spec-from-doc` |
| `skills/ground-spec/` | `ground-spec` |
| `skills/adr-index/` | `adr-index` |
| `skills/ask/` | `ask` |
| `skills/design-diagrams/` | `design-diagrams` |
| `skills/pre-refactor-analyze/` | `pre-refactor-analyze` |
| `skills/commit-changes/` | `commit-changes` |
| `skills/create-pr/` | `create-pr` |
| `skills/fix-branch/` | `fix-branch` |
| `skills/compound-docs/` | `compound-docs` |

`ground-spec` is the only Shipyard skill that loads agent files. It reads the body after the YAML frontmatter and passes that as the Task system prompt.

### Research

`plugins/Research/skills/scientific-scaling-ladder/SKILL.md` designs or audits LLM pretraining scaling experiments. It distinguishes fixed-recipe predictions from tuned-frontier decisions, preserves independent holdouts, propagates uncertainty, and validates target-scale feasibility. Its linked decision template produces artifacts under `docs/research/`.

Keep `plugins/Research/.claude-plugin/plugin.json` metadata consistent with the `research` entry in `.claude-plugin/marketplace.json`. Skill instructions and templates are English. Cite the source methodology and treat published numeric settings as examples requiring calibration.

## Companions (not in this repo)

Do not vendor these. Point users at `README.md`.

- mattpocock: `tdd`, `to-spec`, `to-tickets`, `wayfinder`, `domain-modeling`, `grill-with-docs`, `grilling`, `/setup-matt-pocock-skills`
- waza: `think`, `check`

There is no `commands/` directory and no hooks directory in this tree.

## When adding a skill

1. Add `plugins/<Plugin>/skills/<name>/SKILL.md`.
2. Frontmatter: `name`, `description`, and, when the skill uses tools, `allowed-tools` plus `preconditions`.
3. If a Shipyard skill overlaps a companion skill, make it a handoff or a short add-on. Do not paste the companion's workflow in.
4. Update the skill tables in `README.md` and in this file.

## Marketplace

`.claude-plugin/marketplace.json` holds each plugin name, version, description, and `source` directory.

## Testing

No automated suite. After a skill or docs edit, confirm the replacement table in `README.md` is the only place that names a Shipyard skill this repo no longer ships.
