# ShipYard by DylanLi

**The AI-native engineering workflow system for Claude Code.**

ShipYard by DylanLi is a personal, opinionated system for turning ideas into shipped software with more clarity, better reviews, and cleaner delivery.

At the core is **Vengineer**: a workflow plugin that helps you move from rough intent to production-ready change through a repeatable path:

- clarify requirements
- sketch and spec a feature
- build an implementation plan
- deepen the plan with research
- execute the work
- review the diff
- commit changes cleanly
- open a structured PR
- capture long-term docs and ADRs

## What this repo contains

This repository is the source for the ShipYard workflow toolkit and its Claude Code plugin assets.

```text
vita-cc-market/
├── .claude-plugin/marketplace.json   # Marketplace metadata
├── plugins/
│   ├── Vengineer/                    # Main workflow plugin
│   │   ├── agents/                   # Research and review agents
│   │   ├── hooks/                    # Prompt-time automation
│   │   ├── skills/                   # Reusable workflow skills
│   │   └── .mcp.json                 # MCP server configuration
│   └── Vengineer-RCP/                # Legacy / compatibility plugin
└── README.md
```

## Core workflow

The current repo is organized around **skills-first workflows**.

### 1. Clarify and shape the work

Use these skills when an idea is still fuzzy:

- `clarify` — ask targeted questions to reduce ambiguity
- `light-plan` — turn a rough idea into a lightweight sketch
- `turn2spec` — convert a sketch into a structured feature spec
- `medium-plan` — produce an implementation plan
- `deepen-plan` — enrich a plan with parallel research
- `arch-flow` — orchestrate the full pipeline from sketch → spec → plan → ADR

### 2. Research before implementation

The `plugins/Vengineer/agents/` directory contains focused agents for grounding decisions, including:

- repo analysis
- best-practice research
- framework documentation research
- git history analysis
- spec-flow analysis

Vengineer also ships MCP configuration in `plugins/Vengineer/.mcp.json` for:

- `exa`
- `deepwiki`
- `context7`

### 3. Execute the plan

- `work` — execute a plan with incremental implementation and verification
- `git-worktree` — create isolated worktrees for parallel development
- `ask` — explore the codebase with parallel investigation
- `get-api-docs` — fetch current API documentation before coding against external dependencies

### 4. Review and finish the change

- `review` — run a structured, multi-agent code review workflow
- `plan_review` — review implementation plans before coding
- `resolve-todos` — work through generated TODOs
- `commit-changes` — turn a diff into clean, focused commits
- `create-pr` — draft and open a structured pull request
- `pr-summary-cn` — generate a concise Chinese PR summary

### 5. Preserve knowledge

- `adr` — record architecture decisions in ADR format
- `compound-docs` — save solved problems as reusable documentation
- `batch-issues` — decompose a plan into actionable issues
- `report-bug-issue` — report plugin issues or feature requests

## Plugin highlights

### Vengineer

The main plugin in `plugins/Vengineer` is the active workflow toolkit in this repository.

Highlights:

- end-to-end planning and delivery workflow
- reusable skills for planning, implementation, review, commit, and PR creation
- specialized research and review agents
- prompt hook for automatic language-aware responses
- MCP integrations for external research and docs lookup

### Vengineer-RCP

`plugins/Vengineer-RCP` is a smaller legacy/compatibility plugin that still contains:

- command markdown files
- a few review/test helper agents
- shell scripts and hook configuration

## Hooks

The Vengineer hook set lives in `plugins/Vengineer/hooks/`.

The current hook behavior is focused on **language context injection**:

- detects whether user input is primarily Chinese or English
- adds response-language guidance automatically
- keeps generated code/config artifacts in English

See `plugins/Vengineer/hooks/README.md` for details and testing notes.

## Installation

### Add this marketplace from GitHub

```bash
/plugin marketplace add VitaDynamics/vita-cc-market
```

### Add this marketplace from Git URL

```bash
/plugin marketplace add git@codeup.aliyun.com:vbot/VitaCore/vita-cc-market.git
```

### Install the plugin in Claude Code

```bash
/plugin marketplace list
/plugin browse
/plugin install Vengineer@vita-cc-market
```

If your Claude Code setup expects a different marketplace name, use the name shown by `/plugin marketplace list`.

## Suggested usage flow

A typical flow for a new feature looks like this:

1. Start with `clarify` if requirements are ambiguous.
2. Run `arch-flow` to go from sketch to spec to plan and ADRs.
3. Use `work` to implement from the plan.
4. Run `review` before merging.
5. Use `commit-changes` to create clean commits.
6. Use `create-pr` to open a polished pull request.
7. Capture durable learnings with `compound-docs` or `adr`.

## Repository conventions

- user-facing workflow docs can follow the user language
- skills, agents, code, hooks, and config stay in English
- planning artifacts are expected under `docs/` when generated by the workflow
- plugin marketplace metadata lives in `.claude-plugin/marketplace.json`

## Developing in this repo

When updating the marketplace or plugin content, the most common touchpoints are:

- `plugins/Vengineer/skills/*/SKILL.md`
- `plugins/Vengineer/agents/**/*.md`
- `plugins/Vengineer/hooks/*`
- `.claude-plugin/marketplace.json`

There is no formal automated test suite in the repo today. Typical verification is manual:

- inspect skill frontmatter and structure
- validate hook configuration
- test hook behavior with sample prompt payloads
- manually exercise the workflow in Claude Code

## License

MIT
