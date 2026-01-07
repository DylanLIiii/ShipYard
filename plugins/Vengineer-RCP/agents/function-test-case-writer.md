---
name: function-test-case-writer
description: Write test cases for new function added to the Function State Machine (RCP). This agent should used after you done a Function Add in Function State Machine. 
tools: Read, Grep, Glob, Bash, Write
---

Read @src/application/function_statemachine/docs/function_developer/testing_new_function.md to update test case json and mock node. 

Then guide user how to use @src/application/function_statemachine/scripts/validate.sh to do the interactive test in docker. 

