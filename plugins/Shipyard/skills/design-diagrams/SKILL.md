---
name: design-diagrams
description: >
  Create polished dark-themed diagrams as self-contained HTML+SVG files. Bundles two
  Cocoon AI generators: process-flow (workflows, approval flows, automation sequences,
  cyclical processes) and architecture (system, infrastructure, cloud, security, network
  topology). Use when the user asks for any kind of design diagram, flowchart, or
  architecture illustration that should render in the browser without external assets.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
preconditions:
  - The user wants a visual diagram delivered as a single HTML file (no external images, no Mermaid round-trip)
---

# Design Diagrams Skill

This skill bundles **two** independent diagram generators authored by [Cocoon AI](mailto:hello@cocoon-ai.com) (MIT License) into a single entry point. Pick the right generator first, then follow its dedicated reference.

| Generator | When to pick it | Reference | Template |
|---|---|---|---|
| **process-flow** | Sequential workflows, approval flows, automation pipelines, sprint/dev processes, cyclical loops, runbooks, onboarding steps | [`resources/process-flow/REFERENCE.md`](resources/process-flow/REFERENCE.md) | [`resources/process-flow/template.html`](resources/process-flow/template.html) |
| **architecture** | System component graphs, cloud/AWS topology, infrastructure layout, security zones, message-bus diagrams, network maps | [`resources/architecture/REFERENCE.md`](resources/architecture/REFERENCE.md) | [`resources/architecture/template.html`](resources/architecture/template.html) |

> Rule of thumb: if arrows mean **"then"** (time/sequence) → process-flow. If arrows mean **"talks to"** (data/dependency) → architecture.

Both generators share a common visual language (dark `#020617` background, JetBrains Mono typography, semi-transparent fills, `⋯` export toolbar with PNG/PDF/clipboard buttons via pinned html2canvas + jsPDF), so the look stays consistent if a user needs both diagrams in the same project.

---

## Workflow

### Step 1 — Pick the generator

Read the user's request and decide which generator fits. If the request is ambiguous (e.g. "draw me a diagram of the deployment pipeline" — could be process or architecture), ask the user one clarifying question before continuing.

### Step 2 — Load the matching reference

Read the full reference for the chosen generator. **Do not skip this step** — both references contain non-obvious sizing rules (viewBox math, spacing, legend placement) that are easy to get wrong from memory:

- Process flow: `resources/process-flow/REFERENCE.md`
- Architecture: `resources/architecture/REFERENCE.md`

### Step 3 — Copy the template

Copy the matching `template.html` to the target output path the user requested (default: project root, named `<topic>-diagram.html`). Customize the elements per the reference — `<title>`, header, SVG content, summary cards, footer.

### Step 4 — Preserve the export toolbar

Both templates ship with a `⋯` toolbar that lets the user copy/download PNG or PDF. **Keep these intact** in any output:

- The two pinned CDN `<script>` tags in `<head>` (html2canvas 1.4.1, jsPDF 2.5.2) **with their SRI `integrity` hashes** — do not edit the hashes; if you bump versions, recompute them.
- `id="report-container"` on the outermost `.container` div.
- The `.toolbar` markup, CSS, `@media print` rule, and the `copyAsImage()` / `downloadPNG()` / `downloadPDF()` functions before `</body>`.

### Step 5 — Preview before delivering

After writing the HTML, follow the QA process from the reference:

- Check viewBox sizing (process-flow: 220px stride per step + 200px padding; architecture: legend must sit below all boundary boxes).
- Look for overlapping elements, clipped right edges, arrows that miss box edges.
- If you have browser tools, screenshot it. If you're in Claude Code CLI, tell the user to open the file and report issues.

---

## Quick design-system cheat sheet

Shared across both generators (full details in each REFERENCE.md):

- **Background:** `#020617` (slate-950) with `#1e293b` grid pattern
- **Font:** JetBrains Mono via Google Fonts
- **Boxes:** `rx="6"` (architecture) / `rx="8"` (process-flow), 1.5px stroke, `rgba(..., 0.4)` semi-transparent fill
- **Arrows:** SVG `<marker id="arrowhead">` with `#64748b` polygon
- **Dashed lines:** auth/security (`#fb7185` rose), region boundaries (`#fbbf24` amber), prerequisites/loop-backs (`#94a3b8` slate or `#22d3ee` cyan)

### Semantic colors

| Category | Stroke | Used by |
|---|---|---|
| Frontend / Start-End | `#22d3ee` cyan-400 | architecture, process-flow |
| Backend / Manual step | `#34d399` emerald-400 | architecture, process-flow |
| Database / Automated step | `#a78bfa` violet-400 | architecture, process-flow |
| Cloud / Integration | `#fbbf24` amber-400 | architecture, process-flow |
| Security / Decision | `#fb7185` rose-400 | architecture, process-flow |
| Message bus | `#fb923c` orange-400 | architecture |
| External / Prerequisite | `#94a3b8` slate-400 | architecture, process-flow |

---

## Output contract

Always produce a **single self-contained `.html` file** with:

- Embedded CSS (Google Fonts is the only external stylesheet)
- Inline SVG (no `<img>`, no external assets)
- Two pinned CDN scripts with SRI hashes (html2canvas, jsPDF) — required for the export toolbar
- No other JavaScript dependencies

The file must render correctly when opened directly in any modern browser from `file://`.

---

## Attribution

Both generators are bundled verbatim from upstream and remain under their original MIT License:

- Process flow: <https://github.com/Cocoon-AI/process-flow-diagram-generator> · v1.1
- Architecture: <https://github.com/Cocoon-AI/architecture-diagram-generator> · v1.1
- Author: Cocoon AI <hello@cocoon-ai.com>
