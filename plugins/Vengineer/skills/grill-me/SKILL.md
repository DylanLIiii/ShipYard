---
name: grill-me
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get grilled on their design, or mentions "grill me".
allowed-tools:
  - AskUserQuestion
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - CodebaseInvestigator
---

# Grilling Plan & Design

**Purpose**: Stress-test a plan or design by interviewing the user relentlessly. Walk down every branch of the decision tree, resolving dependencies and ensuring a deep, shared understanding before implementation begins.

## Instructions

When the user requests to be "grilled" or to stress-test a plan:

### 1. Identify the Target
- Determine what plan, design, or architecture document is being discussed.
- If none is provided, ask: "What plan or design should we stress-test?"

### 2. Strategic Grilling Process
- **One Question at a Time**: Never overwhelm the user with multiple questions in one turn.
- **Walk the Decision Tree**: Identify the core architectural decisions and their dependencies. Start with high-level foundational decisions before moving to implementation details.
- **Provide Recommendations**: For every question you ask, include your recommended answer/approach based on best practices and the current codebase context.
- **Deep Research First**: Before asking a question, check if it can be answered by exploring the codebase. Use `Grep`, `Glob`, `Read`, and `CodebaseInvestigator` to understand existing patterns.

### 3. Questioning Areas
Focus on these critical areas of the "decision tree":

| Category | Questions to Explore |
|----------|----------------------|
| **Assumptions** | What must be true for this to work? What if it's not? |
| **Dependencies** | What does this depend on? What depends on this? |
| **Edge Cases** | How does it handle failures, empty states, or extreme scale? |
| **Trade-offs** | Why choose this over alternatives? What are we giving up? |
| **Extensibility** | How easy is it to change or extend this later? |
| **Security & Perf** | Are there hidden risks or bottlenecks? |

### 4. Sequential Questioning Workflow

1. **Analyze**: Review the plan and identify the next branch in the decision tree to resolve.
2. **Research**: Check the codebase for existing patterns that might inform the decision.
3. **Formulate**: Create a sharp, high-impact question.
4. **Recommend**: Draft your recommended answer.
5. **Ask**: Present the question and recommendation to the user using `AskUserQuestion`.

**Example:**
> **Question**: How should we handle concurrency for the `ContextBuilder` updates?
>
> **My Recommendation**: I recommend using a mutex-protected singleton pattern, as seen in `TeamManager/utils/state.py`, to prevent race conditions during parallel processing.

### 5. Resolution & Finality
- Continue until all branches of the decision tree are resolved.
- Once shared understanding is reached, summarize the key decisions.
- Ask if the user is ready to move to the implementation phase (e.g., using `work` skill).

## Behavior Rules
- **Be Relentless**: Don't accept vague answers. Dig deeper if a response creates more ambiguity.
- **Stay Contextual**: Always ground your questions and recommendations in the existing project architecture.
- **Prioritize Stability**: Favor patterns that are already working well in the codebase.
- **Wait for Input**: Stop after each question to get the user's response.
