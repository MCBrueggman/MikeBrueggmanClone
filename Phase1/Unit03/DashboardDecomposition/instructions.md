# Dashboard Decomposition

## Introduction
Business requirement: The app needs to let employees request time off. Managers need to 
approve or deny the request. Employees should get notified when a decision is made.

This requirement is intentionally left vague. You must ask questions to drill down to
detailed requirements. 

Have one of your team members play the role of Product Owner to answer the questions. 
Do not start decomposing until you have sufficient answers to your questions. 
Take your time and have the necessary discussions to make sure your team is 
considering all factors contributing to the complexity of the feature.


## Part 1 - Decomposition

1.  Write out at least 5 clarifying questions and their answers. Make sure you understand
    the data architecture required, any integration with other systems, approval workflow,
    notification requirements, authentication requirements, PTO accrual, etc.

2.  Identify the components required for the solution across all ten layers. (As a
    reminder, the layers are included below these instructions.)

3.  Write concrete, estimable tasks to implement the feature. Make sure that each task
    is SMART (Specific, Measurable, Assignable, Realistic, and Testable)

4.  Build the dependency map for the tasks and identify the critical path, as well as
    any tasks that can be accomplished in parallel.

5.  Identify any technical spikes that may exist.


## Part 2 - Scrum Review

6.  Assist the team member playing the role of Product Owner in prioritizing the
    task list into a Product Backlog, rewriting the items as User Stories with
    Acceptance Criteria.

7.  Conduct a Sprint Planning event to identify a Sprint Goal and build a
    Sprint Backlog.





|     Layer                       |     Questions to Ask                                                                                                                                                                                        |
|---------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Data models                 |     What new data structures does this feature require? Do any existing models need new fields? What are the data types? Are there validation rules?                                                      |
|     Persistence                 |     Does this data need to be stored locally (Core Data / Room)? Does it need to survive app restarts? What happens to existing local data if the   schema changes?                                       |
|     API contracts               |     What new endpoints are needed? What are the request and response schemas? What HTTP status codes are expected? Who owns the backend   implementation - the mobile team or a separate backend team?    |
|     Service / business logic    |     What logic runs between the UI and the data layer? What are the business rules (validation, state transitions, calculations)?                                                                         |
|     ViewModel / state           |     How does the UI state change in response to this feature? What loading, success, and error states does the UI need to render?                                                                         |
|     UI / screens                |     How many new screens or components are needed? What does each state look like (loading, empty, error, populated)? Are there animations?                                                               |
|     Navigation                  |     Does this feature require new navigation routes? Are there deep links from notifications or other apps?                                                                                               |
|     Testing                     |     Unit tests for service logic. Integration tests for data layer. UI tests for critical paths. What are the edge cases (empty state, zero, maximum   values, network failure)?                          |
|     Analytics / logging         |     What events need to be tracked for product metrics? What diagnostic information needs to be logged for engineering?                                                                                   |
|     Accessibility               |     Does the feature require VoiceOver   / TalkBack support? Are there dynamic type considerations? Are interactive elements large enough to tap?                                                         |




