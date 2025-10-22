---
description: Add a New Context Key to the Function State Machine. Specify the context key name and description.
argument-hint: "<你对于该应用的想法, 设计, 尽量补充已有的详细信息>"
---
# Background 

READ documents in @src/application/function_statemachine/docs/app_developer folder to understand the application development framework.

## Documentation References
- **Application Developer Guide**: See @src/application/function_statemachine/docs/app_developer/
- **DAG Workflow Guide**: See documentation on directed acyclic graph (DAG) patterns
- **Context Integration**: See context management documentation for state handling

## Required Information (Ask User First)

Before proceeding, clarify the following with the user. For each question, explain what it means and encourage brainstorming:

!!! It is your responsibility to ask the user to clarify these aspects and proactively explain the meaning of each question. This must be done after you have read the documentation. Encourage users to discuss and brainstorm until a complete plan is developed.

1. **Application Complexity and State Management**:
   - "Could you describe the application you want to build? Is it a complex, multi-step behavior that needs to maintain state across operations (like a tour guide that remembers visited locations), or is it a simple, stateless policy that just reacts to events (like a safety monitor that checks conditions)?"
   - **Why this matters**: Stateful applications require DAG-based workflows with context tracking, while stateless applications can use simpler policy-based patterns.

2. **Triggering Mechanism**:
   - "What will trigger your application's logic? Will it be:"
     - An external request (like a ROS2 service call from a user)
     - A change in the robot's context (like battery level dropping below threshold)
     - A message from another system (like a sensor reading or event notification)
   - **Why this matters**: This determines the interface type (service, action, subscriber) and how your application integrates with the system.

3. **External Interface Design** (if applicable):
   - "If your application is triggered by an external request, what kind of interface do you need?"
     - ROS2 service: Best for quick, request-response operations
     - ROS2 action: Better for long-running tasks with feedback and cancellation
     - ROS2 subscriber: For event-driven, continuous monitoring
   - "What information will you need to pass in (request parameters) and return (response data)?"
   - **Why this matters**: The interface type affects how users interact with your application and what features are available.

4. **Core Logic and Robot Actions**:
   - "What is the main goal of your application, and what robot actions will it need to perform?"
     - Navigation (NAV): Moving to locations
     - Speech (SPEAK): Verbal communication
     - Emotion (EMOTION): Expressing robot emotions
     - Other custom functions
   - "What is the sequence or workflow of these actions? Should they run in parallel or sequentially?"
   - **Why this matters**: This helps design the DAG structure and identify which functions need to be orchestrated.

5. **Context Interaction Requirements**:
   - "What information about the robot's state will your application need to READ from the global context?"
     - Examples: battery level, current location, system status, sensor data
   - "Will your application need to WRITE or UPDATE any information in the global context for other components to see?"
     - Examples: application state, progress indicators, computed results
   - **Why this matters**: This determines which context keys your application depends on and whether new context keys need to be created.

## Brainstorming Encouraged

💡 **Feel free to ask for clarification or deeper explanation on any question above.** We strongly encourage discussing and brainstorming together until you have a complete, well-thought-out plan. Don't hesitate to explore different approaches or ask "what if" questions!

! You always strictly check whether the design is complete, otherwise, you prompt the user to add any information.

## Next Steps

After gathering all required information, we will:
1. Design the application architecture (stateful DAG vs. stateless policy)
2. Define the external interface (if needed)
3. Identify required context keys and functions
4. Create the implementation plan with file structure
5. Guide you through the development process

And use the docs in @src/application/function_statemachine/docs/app_developer/README.md information to add this app. 