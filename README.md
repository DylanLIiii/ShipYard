# ShipYard by DylanLi

**Delivery skills for Claude Code and Codex, with planning and review delegated to maintained companions.**

ShipYard used to carry its own path from sketch to spec to plan to review. That path now lives in two skill sets that are actively maintained elsewhere. This repo keeps the delivery skills, plus a few short add-ons that those companions do not cover.

## Companions

Install both next to ShipYard. Do not copy their skill files into this repo.

### mattpocock/skills

Engineering skills, including `tdd`, `to-spec`, `to-tickets`, `wayfinder`, `domain-modeling` (with `ADR-FORMAT.md`), `grill-with-docs`, and `grilling`. Several of them expect an issue tracker and a `GLOSSARY.md`. Run `/setup-matt-pocock-skills` once per repo before the first `to-spec` or `to-tickets`.

Claude Code:

```bash
claude plugin install mattpocock-skills@claude-plugins-official
```

Codex:

```bash
codex plugin marketplace add mattpocock/skills
codex plugin add mattpocock-skills@mattpocock
```

Source: [mattpocock/skills](https://github.com/mattpocock/skills/tree/main/skills/engineering). Both sets are MIT; ShipYard documents them as companions instead of vendoring them.

### tw93/waza

`think` for shaping a rough idea, `check` for reviewing a diff.

```bash
npx skills add tw93/Waza -a claude-code codex cursor -g -y
```

Or as a host plugin (namespaced `/waza:check`):

```bash
/plugin marketplace add tw93/Waza
/plugin install waza@waza
```

Source: [tw93/waza](https://github.com/tw93/waza).

## What replaced what

| Removed ShipYard skill | Replacement |
|------------------------|-------------|
| `tdd` (frontmatter name `test-driven-development`) | mattpocock `tdd` |
| `review` | waza `check` |
| `light-plan` (frontmatter name `light-plan-brain-storming`) | waza `think`. Use mattpocock `wayfinder` when the effort is too big for one session. |
| `clarify` | mattpocock `grilling` / `grill-with-docs`. ShipYard `clarify-coverage` keeps the bounded scan. |
| `turn2spec` | mattpocock `to-spec`. ShipYard `spec-from-doc` keeps the design-doc handoff. |
| `medium-plan` | `to-spec`, then `to-tickets`. ShipYard `ground-spec` keeps repo research and spec-flow. |
| `arch-flow` | The flow in [Suggested usage](#suggested-usage). No orchestrator skill. |
| `adr` | mattpocock `domain-modeling`. ShipYard `adr-index` keeps the candidate list, index, and back-links. |
| `deepen-plan` | Removed. See [plan_review and deepen-plan](#plan_review-and-deepen-plan). |
| `plan_review` | Removed. See [plan_review and deepen-plan](#plan_review-and-deepen-plan). |

`batch-issues` and `git-worktree` were already missing from this tree. The skills that called them (`arch-flow`, `adr`, `review`) are gone. Tracker tickets come from `to-tickets`.

## What we kept from the old pipeline

| Unique behavior | Where it lives now |
|-----------------|--------------------|
| Eight-category coverage scan, at most five questions, Clarifications section written back onto the draft | `clarify-coverage` |
| Existing design doc or ADR → non-goals, success criteria, edge cases, at most three gap questions | `spec-from-doc` (a brief under `docs/spec-briefs/`, then `to-spec` publishes) |
| Repo, best-practice, and framework research agents, plus spec-flow gap analysis | `ground-spec`, using the agents still under `plugins/Shipyard/agents/` |
| Phase table and `[PARALLEL]` tags | Not kept. `to-tickets` blocking edges are the parallel-work model. |
| Decision candidates, `docs/adr/README.md`, back-links onto the source | `adr-index` |
| Long ADR template and full spec template | Not kept. ADR prose follows `domain-modeling` `ADR-FORMAT.md`. Spec prose follows `to-spec`. |

## plan_review and deepen-plan

Both skills assumed a ShipYard `docs/plans/` file and a roster of reviewers or researchers that was never wired to the agent files in this repo. `plan_review` named twelve reviewers; `agents/review/` had six prompt files, and the removed `review` skill did not load them by path. `deepen-plan` named twelve research roles; the real prompts are the three research agents `ground-spec` still launches, plus spec-flow.

Adapting either skill onto tracker issues would duplicate companions that already exist:

- Stress-testing a design is `grilling` / `grill-with-docs`.
- Research on a large, foggy effort is `wayfinder` research tickets.
- Reviewing a diff is waza `check`.

They were removed. The research that was actually backed by prompt files moved into `ground-spec`, which runs before `to-spec` rather than after a local plan file.

## Skills in this plugin

| Skill | Role |
|-------|------|
| `clarify-coverage` | Bounded coverage pass; writes Clarifications back |
| `spec-from-doc` | Design doc or ADR → spec brief for `to-spec` |
| `ground-spec` | Repo research and spec-flow note before `to-spec` |
| `adr-index` | Decision candidates, ADR index, back-links |
| `ask` | Parallel codebase questions |
| `design-diagrams` | Architecture and process diagrams |
| `pre-refactor-analyze` | Pre-migration semantic analysis |
| `commit-changes` | Conventional commits from the session diff |
| `create-pr` | Open a structured pull request |
| `fix-branch` | CI, review comments, conflicts, deslop |
| `compound-docs` | Solved problems as categorized docs |

Agents still shipped, because `ground-spec` loads them:

- `agents/research/repo-research-analyst.md`
- `agents/research/best-practice-research.md`
- `agents/research/framework-docs-researcher.md`
- `agents/core/spec-flow-analyzer.md`

Removed because nothing remaining loads them: `agents/core/general.md`, `agents/research/git-history-analyzer.md`, and every file under `agents/review/` (`architecture-strategist`, `performance-oracle`, `code-simplicity-reviewer`, `pattern-recognition-specialist`, `bobo-python-reviewer`, `bobo-cpp-reviewer`).

## Suggested usage

1. Rough idea in one session: waza `think`. Bigger than one session: mattpocock `wayfinder`.
2. Sharpen terms and decisions: `grill-with-docs` (or `grilling`).
3. Optional bounded pass: `clarify-coverage`.
4. Starting from a design doc or ADR already on disk: `spec-from-doc`.
5. Optional grounding: `ground-spec`.
6. Publish the spec: `to-spec`.
7. Slice the work: `to-tickets`.
8. Record hard-to-reverse decisions: `domain-modeling`, then `adr-index`.
9. Implement with mattpocock `tdd`.
10. Review the diff with waza `check`.
11. `commit-changes`, `create-pr`, and `fix-branch` as the branch moves.
12. `compound-docs` when a solved problem should outlive the session.

`/setup-matt-pocock-skills` has to run once on the target repo before step 6.

## Research plugin

The `research` plugin in `plugins/Research` supports LLM pretraining experiment design and review. It is separate from the Shipyard planning add-ons.

- [`scientific-scaling-ladder`](plugins/Research/skills/scientific-scaling-ladder/SKILL.md) — turn small training runs into decisions about target recipe performance, compute allocation, candidate selection, and hyperparameter transfer
- distinguish fixed-recipe prediction from decisions requiring a sufficiently tuned frontier
- freeze evaluation and holdouts, propagate uncertainty to decisions, and validate extrapolation and production feasibility
- use the [decision-record template](plugins/Research/skills/scientific-scaling-ladder/references/decision-record.md) for a reproducible handoff under `docs/research/`

The skill condenses Jiaxuan Zou's [How to Build a Scientific Scaling Ladder](https://jiaxuanzou0714.github.io/blog/2026/how-to-build-scientific-scaling-ladder/), with links to supporting primary research. Published example sizes, thresholds, and hyperparameters are not universal defaults.

Install from this repository and invoke in Claude Code:

```text
/plugin marketplace add DylanLIiii/ShipYard
/plugin install research@Shipyard
/research:scientific-scaling-ladder Design a ladder for comparing two pretraining recipes under a fixed compute budget.
```

## What this repo contains

```text
ShipYard/
├── .claude-plugin/marketplace.json
├── plugins/Shipyard/
│   ├── agents/          # research + spec-flow prompts used by ground-spec
│   ├── skills/          # delivery skills and the four planning add-ons
│   └── .mcp.json
├── plugins/Research/    # plugin name: research
│   ├── .claude-plugin/plugin.json
│   └── skills/scientific-scaling-ladder/
├── CLAUDE.md
└── README.md
```

MCP servers configured in `plugins/Shipyard/.mcp.json`: Context7, Exa, Devin, Linear, Morph.

## Installation

```bash
/plugin marketplace add DylanLIiii/ShipYard
/plugin install Shipyard@Shipyard
```

Install the companions in [Companions](#companions) as well. ShipYard's planning add-ons hand off to them and will not recreate their workflows.

## Repository conventions

- User-facing workflow docs follow the user's language.
- Skill and agent files stay in the language they were written in. Chinese skills stay Chinese.
- Spec briefs written by `spec-from-doc` and `ground-spec` go under `docs/spec-briefs/` in the target repo.
- ADRs written by `domain-modeling` stay in that repo's `docs/adr/`. `adr-index` only maintains `docs/adr/README.md` and back-links.
- Marketplace metadata is `.claude-plugin/marketplace.json`.

## Developing in this repo

Touchpoints:

- `plugins/Shipyard/skills/*/SKILL.md`
- `plugins/Research/skills/*/SKILL.md`
- `plugins/Research/.claude-plugin/plugin.json`
- `plugins/Shipyard/agents/**/*.md`
- `.claude-plugin/marketplace.json`

There is no automated test suite. Check skill frontmatter, then search the tree for removed skill names before shipping a docs or skill change.

## License

MIT
