# YAML Frontmatter Schema

**See `schema.yaml` for the complete schema specification.**

## Required Fields

- **module** (string): Module name (e.g., "Email Processing", "Authentication", "Data Pipeline")
- **date** (string): ISO 8601 date (YYYY-MM-DD)
- **problem_type** (enum): One of [build_error, test_failure, runtime_error, performance_issue, data_issue, security_issue, ui_bug, integration_issue, logic_error, developer_experience, workflow_issue, best_practice, documentation_gap]
- **severity** (enum): One of [critical, high, medium, low]
- **tags** (array): 1-8 searchable keywords (lowercase, hyphen-separated)

## Optional Fields

- **language** (enum): Programming language - One of [cpp, python, rust, javascript, typescript, go, java, ruby]

## Language-Specific Details

The following fields are NO LONGER in the schema. Instead, document these in the body:

- **component**: Specific component type (e.g., "ActiveRecord model", "struct", "class") - document in Environment section
- **root_cause**: Technical root cause - document in "Why This Works" section
- **resolution_type**: How the fix was applied - document in Solution section
- **version numbers**: Language/framework versions - document in Environment section

## Template Selection

Based on the `language` field:
- **cpp** → `assets/templates/cpp-resolution.md`
- **python** → `assets/templates/python-resolution.md`
- **rust** → `assets/templates/rust-resolution.md`
- **javascript** → `assets/templates/javascript-resolution.md` (if created)
- **typescript** → `assets/templates/typescript-resolution.md` (if created)
- **go** → `assets/templates/go-resolution.md` (if created)
- **java** → `assets/templates/java-resolution.md` (if created)
- **ruby** → `assets/templates/ruby-resolution.md` (if created)
- **No language field** → `assets/resolution-template.md` (generic template)

## Validation Rules

1. All required fields must be present
2. Enum fields must match allowed values exactly (case-sensitive)
3. tags must be YAML array with 1-8 items
4. date must match YYYY-MM-DD format
5. language (if provided) must match one of the enum values
6. tags should be lowercase, hyphen-separated

## Examples

### C++ Example
```yaml
---
module: Memory Management
date: 2025-11-12
problem_type: runtime_error
severity: critical
language: cpp
tags: [memory-leak, dangling-pointer, ownership]
---
```

### Python Example
```yaml
---
module: Data Processing Pipeline
date: 2025-11-13
problem_type: performance_issue
severity: high
language: python
tags: [async, concurrency, performance]
---
```

### Rust Example
```yaml
---
module: API Integration
date: 2025-11-14
problem_type: build_error
severity: medium
language: rust
tags: [borrow-checker, lifetime, trait]
---
```

### Generic Example (no language)
```yaml
---
module: Documentation Workflow
date: 2025-11-15
problem_type: workflow_issue
severity: low
tags: [workflow, documentation, process]
---
```

## Category Mapping

Based on `problem_type`, documentation is filed in:

- **build_error** → `docs/solutions/build-errors/`
- **test_failure** → `docs/solutions/test-failures/`
- **runtime_error** → `docs/solutions/runtime-errors/`
- **performance_issue** → `docs/solutions/performance-issues/`
- **database_issue** → `docs/solutions/database-issues/`
- **security_issue** → `docs/solutions/security-issues/`
- **ui_bug** → `docs/solutions/ui-bugs/`
- **integration_issue** → `docs/solutions/integration-issues/`
- **logic_error** → `docs/solutions/logic-errors/`
- **developer_experience** → `docs/solutions/developer-experience/`
- **workflow_issue** → `docs/solutions/workflow-issues/`
- **best_practice** → `docs/solutions/best-practices/`
- **documentation_gap** → `docs/solutions/documentation-gaps/`
