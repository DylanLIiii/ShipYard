---
description: Deep codebase exploration with parallel explorer agents
argument-hint: "<what to explore in the codebase>"
allowed-tools: Task, Read, Write, Edit, Grep, Glob, Bash
category: workflow
model: sonnet
---

# =
 Explore Command

Conduct deep, parallel codebase exploration using multiple specialized explorer agents.

## Exploration Query
$ARGUMENTS

## Exploration Process

### Phase 1: Query Classification (CRITICAL FIRST STEP)

**PRIMARY DECISION: Classify the query type to determine exploration strategy**

#### Query Types:

1. **BREADTH-FIRST EXPLORATION** (Wide coverage)
   - Characteristics: Multiple independent areas, system overview, cross-cutting concerns
   - Examples: "Find all API endpoints", "List all database models", "Where is authentication used?"
   - Strategy: 5-10 parallel explorer agents, each investigating different areas
   - Each agent gets narrow, specific exploration tasks

2. **DEPTH-FIRST EXPLORATION** (Deep investigation)
   - Characteristics: Single feature/module requiring thorough understanding, implementation details
   - Examples: "How does user authentication work?", "Trace the order processing flow"
   - Strategy: 2-4 explorer agents with overlapping but complementary angles
   - Each agent explores the same feature from different perspectives (data flow, control flow, dependencies)

3. **SIMPLE LOOKUP** (Quick needle search)
   - Characteristics: Specific class/function/variable, exact file location
   - Examples: "Find the UserService class", "Where is API_KEY defined?"
   - Strategy: 1-2 explorer agents for verification
   - Focus on targeted grep/find commands

#### After Classification, Determine:
- **Resource Allocation**: Based on query type (1-10 explorer agents)
- **Search Scope**: Which directories/file patterns to focus on
- **Depth vs Coverage**: How deep vs how wide to explore

### Phase 2: Parallel Exploration Execution

Based on the query classification, spawn appropriate explorer agents IN A SINGLE MESSAGE for true parallelization.

**CRITICAL: Parallel Execution Pattern**
Use multiple Task tool invocations in ONE message, ALL with subagent_type="explore-agent".

**MANDATORY: Start Each Task Prompt with Mode Indicator**
You MUST begin each task prompt with one of these trigger phrases to control explorer behavior:

- **Quick Lookup (1-2 turns, 3-5 searches)**: Start with "Quick find:", "Locate:", or "Find file:"
- **Focused Investigation (2-3 turns, 5-10 searches)**: Start with "Investigate:", "Explore:", or "Trace:"
- **Deep Exploration (3-4 turns, 10-15 searches)**: Start with "Deep dive:", "Comprehensive:", "Thorough exploration:", or "Full analysis:"

Example Task invocations:
```
Task(description="Auth flow exploration", prompt="Deep dive: Trace the complete user authentication flow from login endpoint to session management", subagent_type="explore-agent")
Task(description="Quick class lookup", prompt="Quick find: Locate the UserService class definition and its imports", subagent_type="explore-agent")
Task(description="API investigation", prompt="Investigate: Find all REST API endpoints and their corresponding handlers", subagent_type="explore-agent")
```

This ensures all explorer agents work simultaneously AND understand the expected search depth through these trigger words.

**Filesystem Artifact Pattern**:
Each explorer agent saves full context report to `/tmp/explore_[timestamp]_[topic].md` and returns only:
- File path to the full report
- Brief 2-3 sentence summary
- Key files/locations found
- Number of matches/snippets

### Phase 3: Synthesis from Filesystem Artifacts

**CRITICAL: Explorer Agents Return File References, Not Full Reports**

Each explorer agent will:
1. Write their full context report to `/tmp/explore_*.md`
2. Return only a summary with the file path

Synthesis Process:
1. **Collect File References**: Gather all `/tmp/explore_*.md` paths from agent responses
2. **Read Reports**: Use Read tool to access each exploration artifact
3. **Merge Findings**:
   - Identify common files/patterns across reports
   - Deduplicate overlapping code locations
   - Preserve unique insights from each report
   - Build file dependency graph if relevant
4. **Consolidate Code Locations**:
   - Merge all file:line references
   - Remove duplicate snippets
   - Organize by module/feature area
5. **Write Final Report**: Save synthesized context to `/tmp/explore_final_[timestamp].md`

### Phase 4: Final Context Report Structure

The synthesized report (written to file) must include:

```markdown
# Exploration Report: [Query Topic]

## Executive Summary
[3-5 paragraph overview synthesizing all findings]

## Key Locations
1. **[Primary Entry Point]** - `file.py:123-145`
2. **[Core Implementation]** - `module/service.py:234-567`
3. **[Related Components]** - Multiple files identified

## Detailed Context

### [Feature/Module 1 - Merged from Multiple Agents]
**Primary Files:**
- `path/to/file1.py:10-50` - Main implementation
- `path/to/file2.py:100-150` - Helper functions

**Code Snippets:**
```language
[Relevant code excerpts with context]
```

**Dependencies:**
- Called by: [List of callers]
- Calls: [List of callees]
- Imports: [Key imports]

### [Feature/Module 2 - Merged from Multiple Agents]
[Comprehensive synthesis integrating all relevant agent findings]

## File Index
[Organized list of all relevant files discovered, grouped by module/feature]

## Call Graph
[If applicable: visual or textual representation of function call relationships]

## Exploration Methodology
- Query Classification: [Breadth/Depth/Simple]
- Explorer Agents Deployed: [Number and focus areas]
- Total Files Analyzed: [Combined count]
- Total Code Locations: [Number of file:line references]
- Exploration Artifacts: [List of all /tmp/explore_*.md files]
```

## Exploration Principles

### Quality Heuristics
- Start with broad file patterns, then narrow based on findings
- Prefer source code over tests/docs (unless specifically requested)
- Follow call chains and data flow when tracing features
- Identify architectural patterns and code organization
- Note gaps, inconsistencies, or potential issues

### Effort Scaling by Query Type
- **Simple Lookup**: 1-2 agents, 1-2 turns each (targeted search)
- **Depth-First**: 2-4 agents, 3-4 turns each (thorough tracing)
- **Breadth-First**: 5-10 agents, 2-3 turns each (wide coverage)
- **Maximum Complexity**: 10 agents (Claude Code limit)

### Parallelization Strategy
- Spawn all initial explorer agents simultaneously for speed
- Each agent performs multiple parallel bash searches per turn
- 90% time reduction compared to sequential exploration
- Independent exploration prevents tunnel vision

## Execution

**Step 1: CLASSIFY THE QUERY** (Breadth-first, Depth-first, or Simple lookup)

**Step 2: LAUNCH APPROPRIATE EXPLORER AGENT CONFIGURATION**

### Example Execution Patterns:

**BREADTH-FIRST Example:** "Find all places where the database is accessed"
- Classification: Breadth-first (cross-cutting concern, multiple locations)
- Launch 6 explorer agents in ONE message with focused investigation mode:
  - Task 1: "Investigate: Find all database model definitions and their locations"
  - Task 2: "Explore: Locate all database query functions and ORM usage"
  - Task 3: "Investigate: Find database connection initialization and configuration"
  - Task 4: "Explore: Search for database migration files and schema definitions"
  - Task 5: "Investigate: Find all database transaction management code"
  - Task 6: "Explore: Locate database error handling and retry logic"

**DEPTH-FIRST Example:** "How does the order processing system work?"
- Classification: Depth-first (single feature, deep understanding)
- Launch 4 explorer agents in ONE message with deep exploration mode:
  - Task 1: "Deep dive: Trace the complete order processing flow from API endpoint through all services"
  - Task 2: "Comprehensive: Find all data models, validation logic, and business rules for orders"
  - Task 3: "Thorough exploration: Identify all external dependencies, payment integrations, and notifications in order processing"
  - Task 4: "Full analysis: Locate error handling, edge cases, and state transitions for order lifecycle"

**SIMPLE LOOKUP Example:** "Where is the JWT token validation function?"
- Classification: Simple lookup
- Launch 1 explorer agent with quick lookup mode:
  - Task 1: "Quick find: Locate JWT token validation function and its usage locations"

Each explorer agent works independently, writes findings to `/tmp/explore_*.md`, and returns a lightweight summary.

### Step 3: SYNTHESIZE AND DELIVER

After all explorer agents complete:
1. Read all exploration artifact files from `/tmp/explore_*.md`
2. Synthesize findings into comprehensive context report
3. Write final report to `/tmp/explore_final_[timestamp].md`
4. Provide user with:
   - Executive summary (displayed directly)
   - Path to full report file
   - Key code locations with file:line references
   - Architectural insights and recommendations

## Integration with Other Commands

- Use `/research` for external documentation and API references
- Use `/explore` for internal codebase understanding
- Combine both when implementing features that require external library knowledge and internal code changes

Now executing query classification and multi-agent exploration...
