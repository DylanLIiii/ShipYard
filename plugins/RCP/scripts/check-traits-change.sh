#!/usr/bin/env bash
# Hook script to detect changes to traits.h in function_statemachine.
# When detected, reminds the developer to use the function-reviewer subagent.

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

# Check if the file is traits.h in function_statemachine
if [[ "$file_path" == *"traits.h"* && "$file_path" == *"function_statemachine"* ]]; then
    cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║  REMINDER: traits.h modified                                  ║
╠═══════════════════════════════════════════════════════════════╣
║  You've modified traits.h in function_statemachine.           ║
║  If you are adding a new function, consider to review it.     ║
║                                                                ║
║  Consider using the function-reviewer subagent to verify:     ║
║  - Parameter header properly included                         ║
║  - Include path is correct                                    ║
║  - No include guard conflicts                                 ║
║  - Function catalog entry exists                              ║
║  - Rule configuration is complete                             ║
║  - Compilation successful                                     ║
║                                                                ║
║  To invoke the reviewer:                                      ║
║  Use Task tool with subagent_type="function-reviewer"         ║
╚═══════════════════════════════════════════════════════════════╝
EOF
fi

exit 0
