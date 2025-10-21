#!/usr/bin/env bash
# Hook script to detect changes to context_keys.h in function_statemachine.
# When detected, reminds the developer to use the context-reviewer subagent.

set -euo pipefail

# Read JSON from stdin
input=$(cat)

# Extract tool_name and file_path using grep and sed
tool_name=$(echo "$input" | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"tool_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
file_path=$(echo "$input" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

# Only process Edit and Write tools
if [[ "$tool_name" != "Edit" && "$tool_name" != "Write" ]]; then
    exit 0
fi

# Check if the file is context_keys.h in function_statemachine
if [[ "$file_path" == *"context_keys.h"* && "$file_path" == *"function_statemachine"* ]]; then
    cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║  REMINDER: context_keys.h modified                            ║
╠═══════════════════════════════════════════════════════════════╣
║  You've modified context_keys.h in function_statemachine.     ║
║  If you are adding a new context key, consider to review it.  ║
║  Consider using the context-reviewer subagent to verify:      ║
║  - Proper enum definition and category placement              ║
║  - Setter/getter registration in correct file                 ║
║  - Type safety with safeconv::to<T>()                         ║
║  - Thread-safe implementation                                 ║
║                                                               ║
║  To invoke the reviewer:                                      ║
║  Use Task tool with subagent_type="context-reviewer"          ║
╚═══════════════════════════════════════════════════════════════╝
EOF
fi

exit 0
